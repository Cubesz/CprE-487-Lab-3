#pragma once

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"

namespace ML
{

    class DenseLayer : public Layer
    {
    public:
        DenseLayer(const LayerParams inParams, const LayerParams outParams,
                   const LayerParams weightParams, const LayerParams biasParams, bool useRelu = true)
                   : Layer(inParams, outParams, LayerType::DENSE),
                     weightParam(weightParams),
                     weightData(weightParams),
                     biasParam(biasParams),
                     biasData(biasParams),
                     useRelu(useRelu) {}

        const LayerParams& getWeightParams() const { return weightParam; }
        const LayerParams& getBiasParams() const { return biasParam; }
        const LayerData &getWeightData() const { return weightData; }
        const LayerData &getBiasData() const { return biasData; }

        // Allocate all resources needed for the layer & Load all of the required data for the layer
        virtual void allocLayer() override {
            Layer::allocLayer();
            weightData.loadData();
            biasData.loadData();
        }

        // Fre all resources allocated for the layer
        virtual void freeLayer() override {
            Layer::freeLayer();
            weightData.freeData();
            biasData.freeData();
        }

        virtual void computeNaive(const LayerData &dataIn) const override;

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
        void computeQuantized(const LayerData &dataIn, QParams qparam) const override {
            computeNaive(dataIn);
        }
        void computeAccelerated(const LayerData &dataIn) const override;

    private:
        LayerParams weightParam;
        LayerData weightData;

        LayerParams biasParam;
        LayerData biasData;
        bool useRelu;
    };

} // namespace ML