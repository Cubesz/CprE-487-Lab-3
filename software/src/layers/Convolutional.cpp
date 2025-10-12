#include "Convolutional.h"

#include <iostream>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"

namespace ML {
// --- Begin Student Code ---

// Compute the convultion for the layer data
void ConvolutionalLayer::computeNaive(const LayerData& dataIn) const {
    // TODO: Your Code Here...
    // The following line is an example of copying a single 32-bit floating point integer from the input layer data to the output layer data
    // getOutputData().get<fp32>(0) = dataIn.get<fp32>(0);
    // size_t width = getWeightParams().dims[0];
    // size_t height = getWeightParams().dims[1];
    // size_t channels_per_filter = getWeightParams().dims[2];
    // size_t output_channels = getWeightParams().dims[3];

    /*
    Filter dimensions:
    (width, height, filter channel/input channel, n filter or n output channel)

    Input dimensions:
    (width, height, input channel/filter channel)
    
    Output dimensions:
    (width, height, output channel/filter)
    
    
    */

    const LayerData& filterData = getWeightData();
    LayerData& outputData = getOutputData();
    const float* biases = static_cast<const float*>(getBiasData().raw());

    const LayerParams& filterParams = getWeightParams();
    const size_t nFilterChannels = filterParams.dims[2];
    const size_t filterWidth = filterParams.dims[0];
    const size_t filterHeight = filterParams.dims[1];
    const LayerParams& outputParams = getOutputData().getParams();
    const LayerParams& inputParams = dataIn.getParams();
    // const size_t inputWidth = inputParams.dims[0];
    const size_t inputHeight = inputParams.dims[1];
    const size_t stride = 1;

    const size_t nOutputChannels = outputParams.dims[2];
    const size_t nOutputColumns = outputParams.dims[0];
    const size_t nOutputRows = outputParams.dims[1];


    for (size_t outputChannel = 0; outputChannel < nOutputChannels; outputChannel++) {
        for (size_t outputColumn = 0; outputColumn < nOutputColumns; outputColumn++) {
            for (size_t outputRow = 0; outputRow < nOutputRows; outputRow++) {
                // at this point, we are in a specific pixel of an output channel
                
                // this pixel should be the 3D filter that corresponds with the output channel smashed against a 3D portion of the input

                fp96 outputPixel = biases[outputChannel];

                for (size_t filterChannel = 0; filterChannel < nFilterChannels; filterChannel++) {
                    for (size_t filterColumn = 0; filterColumn < filterWidth; filterColumn++) {
                        for (size_t filterRow = 0; filterRow < filterHeight; filterRow++) {
                            size_t filterPixelIdx = filterColumn * (filterHeight * nFilterChannels * nOutputChannels) + filterRow * (nFilterChannels * nOutputChannels) + filterChannel * (nOutputChannels) + outputChannel;
                            // input pixel of input channel: `filterChannel`
                            // of column: Stride * outputColumn + filterColumn
                            // of row: Stride * outputRow + filterRow
                            size_t inputPixelColumn = stride * outputColumn + filterColumn;
                            size_t inputPixelRow = stride * outputRow + filterRow;
                            size_t inputPixelIdx = inputPixelColumn * (inputHeight * nFilterChannels) + inputPixelRow * (nFilterChannels) + filterChannel;

                            fp64 inputPixel = dataIn.get<fp32>(inputPixelIdx);
                            fp64 filterPixel = filterData.get<fp32>(filterPixelIdx);

                            fp64 mult = filterPixel * inputPixel;
                            outputPixel += mult;

                            // std::cout << getWeightData().get<fp32>(filterPixelIdx) << "\n";
                        }
                    }
                }

                const fp32 finalOutputPixel = (outputPixel > 0) ? (fp32) outputPixel : 0;
                
                size_t outputPixelIdx = outputColumn * (nOutputRows * nOutputChannels) + outputRow * (nOutputChannels) + outputChannel;
                outputData.get<fp32>(outputPixelIdx) = finalOutputPixel;

            }
        }
    }




    // std::cout << getWeightParams().dims.size() << "\n";
    // std::cout << "Dims again: (" << getWeightParams().dims[0] << ", " << getWeightParams().dims[1] << ", " << getWeightParams().dims[2] << ", " << getWeightParams().dims[3] << ")\n";
    // std::cout << dataIn.getParams().dims.size() << "\n";
    // std::cout << "Dims: (" << dataIn.getParams().dims[0] << ", " << dataIn.getParams().dims[1] << ", " << dataIn.getParams().dims[2] << ")\n";
    // std::cout << outputParams.dims.size() << "\n";
    // std::cout << "Dims again: (" << outputParams.dims[0] << ", " << outputParams.dims[1] << ", " << outputParams.dims[2] << ")\n";

}

// void ConvolutionalLayer::computeAccelerated(const LayerData& dataIn) const {
//     const LayerData& filterData = getWeightData();
//     LayerData& outputData = getOutputData();
//     const float* biases = static_cast<const float*>(getBiasData().raw());

//     const LayerParams& filterParams = getWeightParams();
//     const size_t nFilterChannels = filterParams.dims[2];
//     const size_t filterWidth = filterParams.dims[0];
//     const size_t filterHeight = filterParams.dims[1];
//     const LayerParams& outputParams = getOutputData().getParams();
//     const LayerParams& inputParams = dataIn.getParams();
//     // const size_t inputWidth = inputParams.dims[0];
//     const size_t inputHeight = inputParams.dims[1];
//     const size_t stride = 1;

//     const size_t nOutputChannels = outputParams.dims[2];
//     const size_t nOutputColumns = outputParams.dims[0];
//     const size_t nOutputRows = outputParams.dims[1];


//     for (size_t outputChannel = 0; outputChannel < nOutputChannels; outputChannel++) {
//         for (size_t outputColumn = 0; outputColumn < nOutputColumns; outputColumn++) {
//             for (size_t outputRow = 0; outputRow < nOutputRows; outputRow++) {
//                 // at this point, we are in a specific pixel of an output channel
                
//                 // this pixel should be the 3D filter that corresponds with the output channel smashed against a 3D portion of the input

//                 fp96 outputPixel = biases[outputChannel];

//                 for (size_t filterChannel = 0; filterChannel < nFilterChannels; filterChannel++) {
//                     for (size_t filterColumn = 0; filterColumn < filterWidth; filterColumn++) {
//                         for (size_t filterRow = 0; filterRow < filterHeight; filterRow++) {
//                             size_t filterPixelIdx = filterColumn * (filterHeight * nFilterChannels * nOutputChannels) + filterRow * (nFilterChannels * nOutputChannels) + filterChannel * (nOutputChannels) + outputChannel;
//                             // input pixel of input channel: `filterChannel`
//                             // of column: Stride * outputColumn + filterColumn
//                             // of row: Stride * outputRow + filterRow
//                             size_t inputPixelColumn = stride * outputColumn + filterColumn;
//                             size_t inputPixelRow = stride * outputRow + filterRow;
//                             size_t inputPixelIdx = inputPixelColumn * (inputHeight * nFilterChannels) + inputPixelRow * (nFilterChannels) + filterChannel;

//                             fp64 inputPixel = dataIn.get<fp32>(inputPixelIdx);
//                             fp64 filterPixel = filterData.get<fp32>(filterPixelIdx);

//                             fp64 mult = filterPixel * inputPixel;
//                             outputPixel += mult;

//                             // std::cout << getWeightData().get<fp32>(filterPixelIdx) << "\n";
//                         }
//                     }
//                 }

//                 const fp32 finalOutputPixel = (outputPixel > 0) ? (fp32) outputPixel : 0;
                
//                 size_t outputPixelIdx = outputColumn * (nOutputRows * nOutputChannels) + outputRow * (nOutputChannels) + outputChannel;
//                 outputData.get<fp32>(outputPixelIdx) = finalOutputPixel;

//             }
//         }
//     }
    
// }

// Compute the convolution using threads
void ConvolutionalLayer::computeThreaded(const LayerData& dataIn) const {
    // TODO: Your Code Here...
}

// Compute the convolution using a tiled approach
void ConvolutionalLayer::computeTiled(const LayerData& dataIn) const {
    // TODO: Your Code Here...
}

// Compute the convolution using SIMD
void ConvolutionalLayer::computeSIMD(const LayerData& dataIn) const {
    // TODO: Your Code Here...
}
}  // namespace ML
