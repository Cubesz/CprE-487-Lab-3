#include "Flatten.h"
#include <cstring>

namespace ML
{
    FlattenLayer::FlattenLayer(const LayerParams &inParams, const LayerParams &outParams)
        : Layer(inParams, outParams, LayerType::NONE) {}

    // Reshape (C, H, W) input into (1, K) output
    void FlattenLayer::computeNaive(const LayerData &dataIn) const
    {
        // Since both (C, H, W) and (1, K) are contiguous memory blocks,
        // a memory copy should (probably) work.
        const auto &inParams = getInputParams();
        const float *input = static_cast<const float *>(dataIn.raw());
        float *output = static_cast<float *>(this->getOutputData().raw());
        std::memcpy(output, input, inParams.byte_size());
    }

    void FlattenLayer::computeQuantized(const LayerData &dataIn, QParams qparam) const
    {
        // Since both (C, H, W) and (1, K) are contiguous memory blocks,
        // a memory copy should (probably) work.
        const auto &inParams = getInputParams();
        const int8_t *input = static_cast<const int8_t*>(dataIn.raw());
        int8_t *output = static_cast<int8_t *>(this->getOutputData().raw());
        std::memcpy(output, input, inParams.byte_size());
    }
}