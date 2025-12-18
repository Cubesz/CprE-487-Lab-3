#pragma once
#include "Convolutional.h"

namespace ML
{

    class YoloConvLayer : public ConvolutionalLayer
    {
    public:
        using ConvolutionalLayer::ConvolutionalLayer;

        void computeQuantized(const LayerData &dataIn, QParams qparam) const override;
    };

}