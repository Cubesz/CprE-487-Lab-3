#include "MaxPooling.h"

#include <iostream>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"

namespace ML
{
    // --- Begin Student Code ---

    MaxPoolingLayer::MaxPoolingLayer(const LayerParams &inParams, const LayerParams &outParams)
        : Layer(inParams, outParams, LayerType::MAX_POOLING) {}

    // Compute the convultion for the layer data
    void MaxPoolingLayer::computeNaive(const LayerData &dataIn) const
    {
        // TODO: Your Code Here...

        const auto &inParams = getInputParams();
        const auto &outParams = getOutputParams();

        const size_t inputWidth = inParams.dims[0]; // W
        // const size_t inputHeight = inParams.dims[1]; // H
        const size_t numChannels = inParams.dims[2]; // C

        const size_t outputWidth = outParams.dims[0];  // Q
        const size_t outputHeight = outParams.dims[1]; // P

        const size_t poolHeight = 2; // R
        const size_t poolWidth = 2;  // S
        const size_t stride = 2;     // U

        const float *input = static_cast<const float *>(dataIn.raw());
        float *output = static_cast<float *>(this->getOutputData().raw());

        for (size_t c = 0; c < numChannels; ++c)
        {
            for (size_t p = 0; p < outputHeight; ++p)
            {
                for (size_t q = 0; q < outputWidth; ++q)
                {

                    // Find max in window

                    float bruh = std::numeric_limits<float>::lowest();

                    for (size_t r = 0; r < poolHeight; r++)
                    {
                        for (size_t s = 0; s < poolWidth; s++)
                        {
                            size_t h = p * stride + r;
                            size_t w = q * stride + s;
                            // size_t input_idx = (c * inputHeight * inputWidth) + (h * inputWidth) + w;
                            size_t input_idx = (h * inputWidth * numChannels) + (w * numChannels) + c;
                            bruh = (bruh > input[input_idx]) ? bruh : input[input_idx];
                        }
                    }
                    // size_t output_idx = (c * outputHeight * outputWidth) + (p * outputWidth) + q;
                    size_t output_idx = (p * outputWidth * numChannels) + (q * numChannels) + c;
                    output[output_idx] = bruh;
                }
            }
        }
    }

    // Compute the Max Pooling using threads
    void MaxPoolingLayer::computeThreaded(const LayerData &dataIn) const
    {
        // TODO: Your Code Here...
    }

    // Compute the Max Pooling using a tiled approach
    void MaxPoolingLayer::computeTiled(const LayerData &dataIn) const
    {
        // TODO: Your Code Here...
    }

    // Compute the Max Pooling using SIMD
    void MaxPoolingLayer::computeSIMD(const LayerData &dataIn) const
    {
        // TODO: Your Code Here...
    }

} // namespace ML
