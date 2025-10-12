#pragma once

#include "Layer.h"

namespace ML
{

    class SoftmaxLayer : public Layer
    {
    public:
        SoftmaxLayer(const LayerParams &inParams, const LayerParams &outParams);

        void allocLayer() override { Layer::allocLayer(); }
        void freeLayer() override { Layer::freeLayer(); }

        void computeNaive(const LayerData &dataIn) const override;

        // TODO
        void computeThreaded(const LayerData &dataIn) const override { computeNaive(dataIn); }

        void computeTiled(const LayerData &dataIn) const override { computeNaive(dataIn); }

        void computeSIMD(const LayerData &dataIn) const override { computeNaive(dataIn); }
    };

} // namespace ML