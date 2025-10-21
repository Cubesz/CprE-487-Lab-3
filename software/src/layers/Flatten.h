#pragma once

#include "Layer.h"

namespace ML
{

    class FlattenLayer : public Layer
    {
    public:
        FlattenLayer(const LayerParams &inParams, const LayerParams &outParams);

        void allocLayer() override { Layer::allocLayer(); }
        void freeLayer() override { Layer::freeLayer(); }

        void computeNaive(const LayerData &dataIn) const override;

        // TODO
        void computeThreaded(const LayerData &dataIn) const override
        {
            computeNaive(dataIn);
        }
        void computeTiled(const LayerData &dataIn) const override
        {
            computeNaive(dataIn);
        }
        void computeSIMD(const LayerData &dataIn) const override
        {
            computeNaive(dataIn);
        }
        void computeQuantized(const LayerData &dataIn, QParams qparam) const override;

    private:
    };

} // namespace ML