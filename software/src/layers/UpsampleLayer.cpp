#include "UpsampleLayer.h"

namespace ML
{

    void UpsampleLayer::computeQuantized(const LayerData &dataIn, QParams qparam) const
    {
        const i8 *in_ptr = (const i8 *)dataIn.raw();
        i8 *out_ptr = (i8 *)getOutputData().raw();

        size_t inW = getInputParams().dims[0];
        size_t inH = getInputParams().dims[1];
        size_t C = getInputParams().dims[2];
        size_t outW = inW * stride;
        size_t outH = inH * stride;

        for (size_t c = 0; c < C; ++c)
        {
            for (size_t y = 0; y < inH; ++y)
            {
                for (size_t x = 0; x < inW; ++x)
                {
                    i8 val = in_ptr[(c * inH * inW) + (y * inW) + x];

                    for (int dy = 0; dy < stride; ++dy)
                    {
                        for (int dx = 0; dx < stride; ++dx)
                        {
                            size_t out_y = y * stride + dy;
                            size_t out_x = x * stride + dx;
                            out_ptr[(c * outH * outW) + (out_y * outW) + out_x] = val;
                        }
                    }
                }
            }
        }
    }

}