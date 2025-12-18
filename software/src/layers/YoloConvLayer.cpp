#include "YoloConvLayer.h"
#include "../Utils.h"

namespace ML
{

    void YoloConvLayer::computeQuantized(const LayerData &dataIn, QParams qparam) const
    {
        const LayerData &filterData = getWeightData();
        LayerData &outputData = getOutputData();
        const LayerData &biasData = getBiasData();

        // Get Dimensions
        const LayerParams &filterParams = getWeightParams();
        const size_t filterWidth = filterParams.dims[0];
        const size_t filterHeight = filterParams.dims[1];
        const size_t nOutputCh = filterParams.dims[3];

        const LayerParams &outputParams = getOutputParams();
        const size_t nOutputCols = outputParams.dims[0];
        const size_t nOutputRows = outputParams.dims[1];

        const size_t inputWidth = dataIn.getParams().dims[0];
        const size_t inputCh = dataIn.getParams().dims[2];

        // Get Raw Pointers
        const i8 *in_ptr = (const i8 *)dataIn.raw();
        const i8 *w_ptr = (const i8 *)filterData.raw();
        const i32 *b_ptr = (const i32 *)biasData.raw();

        bool returnFloat = (outputParams.elementSize == sizeof(fp32));
        i8 *out_ptr_i8 = nullptr;
        fp32 *out_ptr_fp32 = nullptr;

        if (returnFloat)
            out_ptr_fp32 = (fp32 *)outputData.raw();
        else
            out_ptr_i8 = (i8 *)outputData.raw();

        for (size_t oy = 0; oy < nOutputRows; ++oy)
        {
            for (size_t ox = 0; ox < nOutputCols; ++ox)
            {

                size_t out_pixel_offset = (oy * nOutputCols + ox) * nOutputCh;

                for (size_t oc = 0; oc < nOutputCh; ++oc)
                {

                    int32_t acc = b_ptr[oc];

                    for (size_t ky = 0; ky < filterHeight; ++ky)
                    {
                        for (size_t kx = 0; kx < filterWidth; ++kx)
                        {

                            // same padding
                            int ix = (int)ox + (int)kx - ((int)filterWidth / 2);
                            int iy = (int)oy + (int)ky - ((int)filterHeight / 2);

                            if (ix >= 0 && ix < (int)inputWidth && iy >= 0 && iy < (int)nOutputRows)
                            {

                                size_t ux = (size_t)ix;
                                size_t uy = (size_t)iy;

                                size_t in_idx_base = (uy * inputWidth + ux) * inputCh;
                                size_t w_idx_base = kx * (filterHeight * inputCh * nOutputCh) +
                                                    ky * (inputCh * nOutputCh) + oc;

                                for (size_t ic = 0; ic < inputCh; ++ic)
                                {
                                    size_t w_idx = w_idx_base + ic * nOutputCh;

                                    int32_t input_val = in_ptr[in_idx_base + ic];
                                    int32_t weight_val = w_ptr[w_idx];

                                    acc += input_val * weight_val;
                                }
                            }
                        }
                    }

                    if (returnFloat)
                    {
                        // Output Head Mode
                        float acc_scale = qparam.S_i * qparam.S_w;
                        if (acc_scale > 1e-9)
                        {
                            out_ptr_fp32[out_pixel_offset + oc] = (float)acc / acc_scale;
                        }
                        else
                        {
                            out_ptr_fp32[out_pixel_offset + oc] = 0.0f;
                        }
                    }
                    else
                    {
                        if (acc < 0)
                            acc = acc >> 3; // Leaky

                        acc = MultiplyByQuantizedMultiplier(acc, qparam.output_multiplier, qparam.output_shift);
                        acc += qparam.Z_i_next;

                        // Clamp
                        if (acc > 127)
                            acc = 127;
                        if (acc < -128)
                            acc = -128;

                        out_ptr_i8[out_pixel_offset + oc] = (i8)acc;
                    }
                }
            }
        }
    }

}