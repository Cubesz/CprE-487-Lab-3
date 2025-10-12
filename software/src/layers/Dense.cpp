#include "Dense.h"
#include <iostream>

namespace ML
{

    void DenseLayer::computeNaive(const LayerData &dataIn) const
    {
        /*
            weights: (filter width, n Filters / n output channels)
            input: (input width / filter width)
            output: (n output channels)
        */

        const LayerParams& outputParams = getOutputParams();
        const LayerParams& inputParams = getInputParams();
        LayerData& outputData = getOutputData();


        const size_t nOutputChannels = outputParams.dims[0];
        const size_t inputWidth = inputParams.dims[0];


        for (size_t outputPixelIdx = 0; outputPixelIdx < nOutputChannels; outputPixelIdx++) {

            fp96 accumulate = biasData.get<fp32>(outputPixelIdx);

            for (size_t inputPixelIdx = 0; inputPixelIdx < inputWidth; inputPixelIdx++) {
                size_t filterIdx = inputPixelIdx * (nOutputChannels) + outputPixelIdx;
                const fp32 filterPixel = weightData.get<fp32>(filterIdx);
                const fp32 inputPixel = dataIn.get<fp32>(inputPixelIdx);
                accumulate += ((fp96) filterPixel) * inputPixel;
            }

            const fp32 finalOutputPixel = (accumulate > 0 || !useRelu) ? (fp32) accumulate : 0;
            outputData.get<fp32>(outputPixelIdx) = finalOutputPixel;
        }

    }

} // namespace ML