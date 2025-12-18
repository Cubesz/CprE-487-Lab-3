#pragma once
#include "Convolutional.h"

namespace ML
{
    void resetYoloLayerId();
}

namespace ML
{

    class YoloConvLayer : public ConvolutionalLayer
    {
    public:
        using ConvolutionalLayer::ConvolutionalLayer;

        void computeQuantized(const LayerData &dataIn, QParams qparam) const override;
    };

}