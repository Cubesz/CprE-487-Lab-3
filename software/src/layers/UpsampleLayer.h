#pragma once
#include "Layer.h"

namespace ML
{

    class UpsampleLayer : public Layer
    {
    public:
        UpsampleLayer(const LayerParams &inParams, const LayerParams &outParams, int stride)
            : Layer(inParams, outParams, LayerType::UPSAMPLE), stride(stride) {}

        void computeNaive(const LayerData &d) const override {}
        void computeThreaded(const LayerData &d) const override {}
        void computeTiled(const LayerData &d) const override {}
        void computeSIMD(const LayerData &d) const override {}

        void computeQuantized(const LayerData &dataIn, QParams qparam) const override;

    private:
        int stride;
    };

}