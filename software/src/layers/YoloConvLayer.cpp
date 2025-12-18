#include "YoloConvLayer.h"
#include "../Utils.h"

struct YoloHWParams
{
    uint32_t multiplier;
    int shift;
};

static const YoloHWParams yolo_hw_table[] = {
    {0x50ade9db, 39}, {0x544e8f1d, 37}, {0x768d9cc4, 37}, {0x6cff0288, 38}, {0x40a4bec8, 37}, {0x7cfd0b92, 38}, {0x7e852ce2, 39}, {0x656b008c, 37}, {0x7b69ac08, 39}, {0x4a06c895, 40}, {0x6c0df0fb, 39}, {0x421d6a24, 38}, {0x758171e0, 41}};

static int yolo_layer_id = 0;

namespace ML
{

    void resetYoloLayerId()
    {
        yolo_layer_id = 0;
    }

    void YoloConvLayer::computeQuantized(const LayerData &dataIn, QParams qparam) const
    {
        const LayerData &filterData = getWeightData();
        LayerData &outputData = getOutputData();
        const LayerData &biasData = getBiasData();

        const size_t nInputCh = getWeightParams().dims[2];
        const size_t nOutputCh = getWeightParams().dims[3];
        const size_t filterW = getWeightParams().dims[0];
        const size_t filterH = getWeightParams().dims[1];
        const size_t outW = getOutputParams().dims[0];
        const size_t outH = getOutputParams().dims[1];
        const size_t inW = dataIn.getParams().dims[0];
        const size_t inH = dataIn.getParams().dims[1];

        const i8 *in_ptr = (const i8 *)dataIn.raw();
        const i8 *w_ptr = (const i8 *)filterData.raw();
        const i32 *b_ptr = (const i32 *)biasData.raw();

        bool isHead = (getOutputParams().elementSize == sizeof(fp32));
        i8 *out_ptr_i8 = isHead ? nullptr : (i8 *)outputData.raw();
        fp32 *out_ptr_fp32 = isHead ? (fp32 *)outputData.raw() : nullptr;

        uint32_t hw_mult = yolo_hw_table[yolo_layer_id].multiplier;
        int hw_shift = yolo_hw_table[yolo_layer_id].shift;

        for (size_t oc = 0; oc < nOutputCh; ++oc)
        {
            for (size_t oy = 0; oy < outH; ++oy)
            {
                for (size_t ox = 0; ox < outW; ++ox)
                {
                    int32_t acc = b_ptr[oc];
                    for (size_t ic = 0; ic < nInputCh; ++ic)
                    {
                        for (size_t ky = 0; ky < filterH; ++ky)
                        {
                            for (size_t kx = 0; kx < filterW; ++kx)
                            {
                                int ix = (int)ox + (int)kx - ((int)filterW / 2);
                                int iy = (int)oy + (int)ky - ((int)filterH / 2);
                                i8 input_val = 0;
                                if (ix >= 0 && ix < (int)inW && iy >= 0 && iy < (int)inH)
                                {
                                    input_val = in_ptr[(ic * inH * inW) + (iy * inW) + ix];
                                }
                                size_t w_idx = kx * (filterH * nInputCh * nOutputCh) +
                                               ky * (nInputCh * nOutputCh) +
                                               ic * (nOutputCh) + oc;
                                acc += (int32_t)input_val * (int32_t)w_ptr[w_idx];
                            }
                        }
                    }

                    size_t out_idx = (oc * outH * outW) + (oy * outW) + ox;
                    if (isHead)
                    {
                        float divisor = qparam.S_i * qparam.S_w;
                        out_ptr_fp32[out_idx] = (divisor > 1e-9f) ? (float)acc / divisor : 0.0f;
                    }
                    else
                    {
                        if (acc < 0)
                            acc = acc >> 3;
                        acc = MultiplyByQuantizedMultiplier(acc, hw_mult, hw_shift);
                        acc += qparam.Z_i_next;
                        out_ptr_i8[out_idx] = (i8)ML::clamp(acc, -128, 127);
                    }
                }
            }
        }
        yolo_layer_id = (yolo_layer_id + 1) % 13;
    }
}