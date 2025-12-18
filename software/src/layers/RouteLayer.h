#pragma once
#include "Layer.h"

namespace ML
{

    class RouteLayer : public Layer
    {
    public:
        RouteLayer(const LayerParams &inParams, const LayerParams &outParams, const std::vector<const Layer *> &inputLayers)
            : Layer(inParams, outParams, LayerType::ROUTE), sources(inputLayers) {}

        void computeNaive(const LayerData &d) const override {}
        void computeThreaded(const LayerData &d) const override {}
        void computeTiled(const LayerData &d) const override {}
        void computeSIMD(const LayerData &d) const override {}

        void computeQuantized(const LayerData &ignored, QParams qparam) const override;

    private:
        std::vector<const Layer *> sources;
    };

}