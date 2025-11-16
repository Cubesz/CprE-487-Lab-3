#include "Convolutional.h"

#include <iostream>

#include "../Types.h"
#include "../Utils.h"
#include "Layer.h"
#include "QuantParams.h"

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

#ifdef CACHED_NAIVE

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
    const LayerData& biasData = getBiasData();
    // const float* biases = static_cast<const float*>(getBiasData().raw());

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

                // fp96 outputPixel = biases[outputChannel];
                fp96 outputPixel = biasData.get<fp32>(outputChannel);

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

}

#else

void ConvolutionalLayer::computeNaive(const LayerData& dataIn) const {
    const LayerData& filterData = getWeightData();
    LayerData& outputData = getOutputData();
    const LayerData& biasData = getBiasData();

    const LayerParams& filterParams = getWeightParams();
    const size_t filterHeight = filterParams.dims[0];
    const size_t filterWidth = filterParams.dims[1];
    const size_t nFilterChannels = filterParams.dims[2];
    
    const LayerParams& inputParams = dataIn.getParams();
    // const size_t inputHeight = inputParams.dims[0];
    const size_t inputWidth = inputParams.dims[1];

    const LayerParams& outputParams = getOutputData().getParams();
    const size_t nOutputRows = outputParams.dims[0];
    const size_t nOutputColumns = outputParams.dims[1];
    const size_t nOutputChannels = outputParams.dims[2];
    
    const size_t stride = 1;

    // Initialize output with biases first
    // This avoids repeatedly adding the bias inside the loops.
    for (size_t oc = 0; oc < nOutputColumns; ++oc) {
        for (size_t orow = 0; orow < nOutputRows; ++orow) {
            for (size_t och = 0; och < nOutputChannels; ++och) {
                size_t outputPixelIdx = (orow * nOutputColumns * nOutputChannels) + (oc * nOutputChannels) + och;
                outputData.get<fp32>(outputPixelIdx) = biasData.get<fp32>(och);
            }
        }
    }

    // Reordered Loops for Cache Locality
    // Loop Order: (Output Row -> Output Col -> Kernel Row -> Kernel Col -> Input Channel -> Output Channel)
    for (size_t orow = 0; orow < nOutputRows; ++orow) {
        for (size_t oc = 0; oc < nOutputColumns; ++oc) {
            for (size_t kh = 0; kh < filterHeight; ++kh) {
                for (size_t kw = 0; kw < filterWidth; ++kw) {
                    for (size_t ic = 0; ic < nFilterChannels; ++ic) {
                        
                        // Calculate input coordinates
                        size_t inputPixelRow = orow * stride + kh;
                        size_t inputPixelColumn = oc * stride + kw;

                        // Fetch the input value once and reuse it (Temporal Locality)
                        size_t inputPixelIdx = (inputPixelRow * inputWidth * nFilterChannels) + (inputPixelColumn * nFilterChannels) + ic;
                        fp32 inputValue = dataIn.get<fp32>(inputPixelIdx);

                        for (size_t och = 0; och < nOutputChannels; ++och) {
                            
                            // This access is now sequential (Spatial Locality)
                            size_t filterPixelIdx = ((((kh * filterWidth) + kw) * nFilterChannels) + ic) * nOutputChannels + och;
                            fp32 filterValue = filterData.get<fp32>(filterPixelIdx);
                            size_t outputPixelIdx = (orow * nOutputColumns * nOutputChannels) + (oc * nOutputChannels) + och;                            
                            outputData.get<fp32>(outputPixelIdx) += inputValue * filterValue;
                        }
                    }
                }
            }
        }
    }
    
    // Applying Relu activation in a separate pass
    for (size_t i = 0; i < outputData.getParams().flat_count(); ++i) {
        if (outputData.get<fp32>(i) < 0) {
            outputData.get<fp32>(i) = 0;
        }
    }
}

#endif

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

void ConvolutionalLayer::computeQuantized(const LayerData& dataIn, QParams qparam) const {
    const LayerData& filterData = getWeightData();
    LayerData& outputData = getOutputData();
    const LayerData& biasData = getBiasData();

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

                #ifdef ZEDBOARD
                fifo_write_data(biasData.get<i16>(outputChannel));
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

                            i8 inputPixel = dataIn.get<i8>(inputPixelIdx);
                            i8 filterPixel = filterData.get<i8>(filterPixelIdx);
                            uint32_t multPacket = (inputPixel << 8) | (0xFF & filterPixel);
                            fifo_write_data(multPacket);

                            // std::cout << getWeightData().get<fp32>(filterPixelIdx) << "\n";
                        }
                    }
                }
                fifo_set_transmit_length((nFilterChannels * filterWidth * filterHeight + 1)*4);
                fifo_wait_for_data();
                i32 outputPixel = fifo_read_data();
                outputPixel -= qparam.zp_macced[outputChannel];

                #else

                i32 outputPixel = biasData.get<i16>(outputChannel) - qparam.zp_macced[outputChannel];
                // i32 outputPixel = biasData.get<i16>(outputChannel);

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

                            i32 inputPixel = dataIn.get<i8>(inputPixelIdx);
                            i32 filterPixel = filterData.get<i8>(filterPixelIdx);

                            i32 mult = filterPixel * inputPixel;
                            outputPixel += mult;

                            // std::cout << getWeightData().get<fp32>(filterPixelIdx) << "\n";
                        }
                    }
                }
                #endif

                
                size_t outputPixelIdx = outputColumn * (nOutputRows * nOutputChannels) + outputRow * (nOutputChannels) + outputChannel;
                if (qparam.quantedOutput) {
                    outputPixel = outputPixel / qparam.outputscaler;
                    const i8 finalOutputPixel = (outputPixel > 0) ? (int8_t) (outputPixel + qparam.Z_i_next) : (int8_t) qparam.Z_i_next;
                    outputData.get<i8>(outputPixelIdx) = finalOutputPixel;
                } else {
                    fp32 testPixel = ((float) outputPixel) * (1.0f / (((float) qparam.S_i) * ((float) qparam.S_w)));
                    const fp32 finalTestPixel = (testPixel > 0) ? testPixel : 0;
                    outputData.get<fp32>(outputPixelIdx) = finalTestPixel;
                }
                // outputData.get<fp32>(outputPixelIdx) = finalTestPixel;

            }
        }
    }


}


// Compute the convolution using custom MAC
void ConvolutionalLayer::computeAccelerated(const LayerData& dataIn) const {
#ifdef BRUH
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


#endif

}


}  // namespace ML
