#pragma once

#include "Layer.h"

namespace ML
{
    class MaxPoolingLayer : public Layer
    {
    public:
        MaxPoolingLayer(const LayerParams &inParams, const LayerParams &outParams);

        void allocLayer() override { Layer::allocLayer(); }
        void freeLayer() override { Layer::freeLayer(); }

        void computeNaive(const LayerData &dataIn) const override;
        void computeThreaded(const LayerData &dataIn) const override;
        void computeTiled(const LayerData &dataIn) const override;
        void computeSIMD(const LayerData &dataIn) const override;
        void computeQuantized(const LayerData &dataIn, QParams qparam) const override;

    private:
    };

} // namespace ML