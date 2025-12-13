#include "Model.h"

#include <cassert>

namespace ML
{

    // Run inference on the entire model using the inData and outputting the outData
    // infType can be used to determine the inference function to call
    // const LayerData &Model::inference(const LayerData &inData, const Layer::InfType infType, const QParams *qparams) const
    // {
    //     assert(layers.size() > 0 && "There must be at least 1 layer to perform inference");
    //     if (infType == Layer::InfType::QUANTIZED)
    //     {
    //         inferenceLayer(inData, 0, infType, qparams[0]);

    //         for (std::size_t i = 1; i < layers.size(); i++)
    //         {
    //             inferenceLayer(layers[i - 1]->getOutputData(), i, infType, qparams[i]);
    //         }
    //     }
    //     else
    //     {
    //         inferenceLayer(inData, 0, infType);

    //         for (std::size_t i = 1; i < layers.size(); i++)
    //         {
    //             inferenceLayer(layers[i - 1]->getOutputData(), i, infType);
    //         }
    //     }

    //     return layers.back()->getOutputData();
    // }

    // Allocate the internal output buffers for each layer in the model
    void Model::allocLayers()
    {
        for (std::size_t i = 0; i < layers.size(); i++)
        {
            layers[i]->allocLayer();
        }
    }

    // Free all layers in the model
    void Model::freeLayers()
    {
        // All classes use RAII, so just wipe out the vector of layers.
        layers.clear();
    }

    const LayerData &Model::inference(const LayerData &inData, const Layer::InfType infType, const QParams *qparams) const
    {
        assert(layers.size() > 0 && "There must be at least 1 layer to perform inference");

        // pointer holds the output of the previous layer, which is the input for the current layer.
        const LayerData *currentData = &inData;

        if (infType == Layer::InfType::QUANTIZED)
        {
            for (std::size_t i = 0; i < layers.size(); i++)
            {
                currentData = &inferenceLayer(*currentData, i, infType, qparams[i]);
            }
        }
        else
        {
            for (std::size_t i = 0; i < layers.size(); i++)
            {
                currentData = &inferenceLayer(*currentData, i, infType);
            }
        }

        // After loop, currentData points to the output of the final layer.
        return *currentData;
    }

    // Run inference on a single layer of the model using the inData and outputting the outData
    // infType can be used to determine the inference function to call
    const LayerData &Model::inferenceLayer(const LayerData &inData, const int layerNum, const Layer::InfType infType, const QParams qparam, size_t tileSize, size_t threadCount) const
    {
        Layer &layer = *layers[layerNum];

        assert(layer.getInputParams().isCompatible(inData.getParams()) && "Input data is not compatible with layer");
        assert(layer.isOutputBufferAlloced() && "Output buffer must be allocated prior to inference");

        switch (infType)
        {
        case Layer::InfType::NAIVE:
            layer.computeNaive(inData);
            break;
        case Layer::InfType::THREADED:
            if (auto convLayer = dynamic_cast<ConvolutionalLayer *>(&layer))
            {
                // If it's a conv layer, call threaded function
                convLayer->computeThreaded(inData, threadCount);
            }
            else
            {
                layer.computeNaive(inData);
            }
            break;
        case Layer::InfType::TILED:
            if (auto convLayer = dynamic_cast<ConvolutionalLayer *>(&layer))
            {
                // If it's a conv layer, call tiled function
                convLayer->computeTiled(inData, tileSize);
            }
            else
            {
                layer.computeNaive(inData);
            }
            break;
        case Layer::InfType::SIMD:
            layer.computeSIMD(inData);
            break;
        case Layer::InfType::QUANTIZED:
            layer.computeQuantized(inData, qparam);
            break;
        // case Layer::InfType::ACCELERATED:
        //     layer.computeAccelerated(inData);
        //     break;
        default:
            assert(false && "Inference Type not implemented");
        }

        return layer.getOutputData();
    }

} // namespace ML
