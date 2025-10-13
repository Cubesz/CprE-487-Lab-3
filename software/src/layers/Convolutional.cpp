#include "Convolutional.h"

#include <iostream>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"

#ifdef ZEDBOARD
#include <xllfifo_hw.h>
#include <xil_io.h>
#include "xparameters.h"

// Write a 32-bit data word to the FIFO's Transmit port
static inline void fifo_write_data(uint32_t data) {
    Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, data);
}

// Set the packet length and tell the FIFO to start transmitting
static inline void fifo_set_transmit_length(uint32_t bytes) {
    Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, bytes);
}

// Read a 32-bit data word from the FIFO's Receive port
static inline int32_t fifo_read_data() {
    return (int32_t)Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
}

// Wait until the receive buffer is no longer empty
static inline void fifo_wait_for_data() {
    while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);
}

#endif

namespace ML {
// --- Begin Student Code ---

typedef struct __packed {
    int8_t weight;
    int8_t inp;
    operator uint32_t() const {
        return ((uint32_t)(uint8_t)weight << 8) | ((uint8_t)inp);
    }
} input_t;


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

#ifdef ZEDBOARD

// Compute the convolution using custom MAC
void ConvolutionalLayer::computeAccelerated(const LayerData& dataIn) const {
    // TODO: Your Code Here...
    
    const int8_t* filter_data_ptr = static_cast<const int8_t*>(getWeightData().raw());
    const int8_t* input_data_ptr = static_cast<const int8_t*>(dataIn.raw());
    const int32_t* biases = static_cast<const int32_t*>(getBiasData().raw());
    int8_t* output_data_ptr = static_cast<int8_t*>(getOutputData().raw());

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

    std::vector<input_t> mac_operations;
    mac_operations.reserve(filterWidth * filterHeight * nFilterChannels);


    for (size_t outputChannel = 0; outputChannel < nOutputChannels; outputChannel++) {
        for (size_t outputColumn = 0; outputColumn < nOutputColumns; outputColumn++) {
            for (size_t outputRow = 0; outputRow < nOutputRows; outputRow++) {
                // at this point, we are in a specific pixel of an output channel
                
                // this pixel should be the 3D filter that corresponds with the output channel smashed against a 3D portion of the input
                // fp96 outputPixel = biases[outputChannel];
                // Clear previous output pixel
                mac_operations.clear();
                // Start with bias in accumulator 
                const int32_t initial_acc = biases[outputChannel];


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

                            // fp64 inputPixel = dataIn.get<fp32>(inputPixelIdx);
                            // fp64 filterPixel = filterData.get<fp32>(filterPixelIdx);

                            // fp64 mult = filterPixel * inputPixel;
                            // outputPixel += mult;

                            const int8_t filterPixel = filter_data_ptr[filterPixelIdx];
                            const int8_t inputPixel = input_data_ptr[inputPixelIdx];
                            
                            // Add the operation to our packet list.
                            mac_operations.push_back({filterPixel, inputPixel});


                            // std::cout << getWeightData().get<fp32>(filterPixelIdx) << "\n";
                        }
                    }
                }

                // const fp32 finalOutputPixel = (outputPixel > 0) ? (fp32) outputPixel : 0;
                // outputData.get<fp32>(outputPixelIdx) = finalOutputPixel;

                // Send initial accumulator value
                fifo_write_data(initial_acc);

                // Send weight input pairs
                for (const auto& op : mac_operations) {
                    fifo_write_data(op);
                }

                // FIFO transmit
                uint32_t totalBytes = (1 + mac_operations.size()) * 4;
                fifo_set_transmit_length(totalBytes);

                // Wait for hardware to finish
                fifo_wait_for_data();
                int32_t hardware_result = fifo_read_data();

                // relu
                if (hardware_result < 0) {
                    hardware_result = 0;
                }
                
                // clamp the 32-bit result to fit into an 8-bit integer
                // No need to worry about negative cuz relu
                int8_t finalOutputPixel;
                if (hardware_result > 127) {
                    finalOutputPixel = 127;
                } else {
                    finalOutputPixel = static_cast<int8_t>(hardware_result);
                }
                
                // Calculate output index
                size_t outputPixelIdx = outputColumn * (nOutputRows * nOutputChannels) + outputRow * (nOutputChannels) + outputChannel;

                // Store the final quantized 8-bit value
                output_data_ptr[outputPixelIdx] = finalOutputPixel;

            }
        }
    }



}

#endif

}  // namespace ML
