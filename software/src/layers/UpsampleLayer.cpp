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

        size_t outW = getOutputParams().dims[0]; // Should be inW * stride

        for (size_t y = 0; y < inH; ++y)
        {
            for (size_t x = 0; x < inW; ++x)
            {

                // Pointer to the start of the pixel channels in Input
                const i8 *pixel_src = in_ptr + (y * inW + x) * C;

                // Map to output blocks
                for (int dy = 0; dy < stride; ++dy)
                {
                    for (int dx = 0; dx < stride; ++dx)
                    {

                        size_t out_y = y * stride + dy;
                        size_t out_x = x * stride + dx;

                        i8 *pixel_dst = out_ptr + (out_y * outW + out_x) * C;

                        // Copy all channels
                        std::memcpy(pixel_dst, pixel_src, C);
                    }
                }
            }
        }
    }

}