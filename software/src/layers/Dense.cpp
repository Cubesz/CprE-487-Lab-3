#include "Dense.h"
#include <iostream>

typedef struct __packed
{
    int8_t weight;
    int8_t inp;
    operator uint32_t() const
    {
        return ((uint32_t)(uint8_t)weight << 8) | ((uint8_t)inp);
    }
} input_t;

namespace ML
{

#if defined(ZEDBOARD) && defined(FIFOSTUFF)
// #include <xllfifo_hw.h>
#include <xil_io.h>
#include "xparameters.h"

    // Write a 32-bit data word to the FIFO's Transmit port
    static inline void fifo_write_data(uint32_t data)
    {
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, data);
    }

    // Set the packet length and tell the FIFO to start transmitting
    static inline void fifo_set_transmit_length(uint32_t bytes)
    {
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, bytes);
    }

    // Read a 32-bit data word from the FIFO's Receive port
    static inline int32_t fifo_read_data()
    {
        return (int32_t)Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
    }

    // Wait until the receive buffer is no longer empty
    static inline void fifo_wait_for_data()
    {
        while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0)
            ;
    }

#endif


    void DenseLayer::computeNaive(const LayerData &dataIn) const
    {
        /*
            weights: (filter width, n Filters / n output channels)
            input: (input width / filter width)
            output: (n output channels)
        */

        const LayerParams &outputParams = getOutputParams();
        const LayerParams &inputParams = getInputParams();
        LayerData &outputData = getOutputData();

        const size_t nOutputChannels = outputParams.dims[0];
        const size_t inputWidth = inputParams.dims[0];

        for (size_t outputPixelIdx = 0; outputPixelIdx < nOutputChannels; outputPixelIdx++)
        {

            fp96 accumulate = biasData.get<fp32>(outputPixelIdx);

            for (size_t inputPixelIdx = 0; inputPixelIdx < inputWidth; inputPixelIdx++)
            {
                size_t filterIdx = inputPixelIdx * (nOutputChannels) + outputPixelIdx;
                const fp32 filterPixel = weightData.get<fp32>(filterIdx);
                const fp32 inputPixel = dataIn.get<fp32>(inputPixelIdx);
                accumulate += ((fp96)filterPixel) * inputPixel;
            }

            const fp32 finalOutputPixel = (accumulate > 0 || !useRelu) ? (fp32)accumulate : 0;
            outputData.get<fp32>(outputPixelIdx) = finalOutputPixel;
        }
    }

    void DenseLayer::computeQuantized(const LayerData &dataIn, QParams qparam) const {
        /*
            weights: (filter width, n Filters / n output channels)
            input: (input width / filter width)
            output: (n output channels)
        */

        const LayerParams &outputParams = getOutputParams();
        const LayerParams &inputParams = getInputParams();
        LayerData &outputData = getOutputData();

        const size_t nOutputChannels = outputParams.dims[0];
        const size_t inputWidth = inputParams.dims[0];

        for (size_t outputPixelIdx = 0; outputPixelIdx < nOutputChannels; outputPixelIdx++)
        {

            #if defined(ZEDBOARD) && defined(FIFOSTUFF)
            fifo_write_data(biasData.get<i16>(outputPixelIdx));
            for (size_t inputPixelIdx = 0; inputPixelIdx < inputWidth; inputPixelIdx++)
            {
                size_t filterIdx = inputPixelIdx * (nOutputChannels) + outputPixelIdx;
                const i32 filterPixel = weightData.get<i8>(filterIdx);
                const i32 inputPixel = dataIn.get<i8>(inputPixelIdx);
                uint32_t multPacket = (filterPixel << 8) | (0xFF & inputPixel);
                fifo_write_data(multPacket);
            }
            fifo_set_transmit_length((inputWidth + 1) * 4);
            fifo_wait_for_data();
            i32 accumulate = fifo_read_data();
            accumulate -= qparam.zp_macced[outputPixelIdx];

            #else

            i64 accumulate = biasData.get<i16>(outputPixelIdx) - qparam.zp_macced[outputPixelIdx];

            for (size_t inputPixelIdx = 0; inputPixelIdx < inputWidth; inputPixelIdx++)
            {
                size_t filterIdx = inputPixelIdx * (nOutputChannels) + outputPixelIdx;
                const i32 filterPixel = weightData.get<i8>(filterIdx);
                const i32 inputPixel = dataIn.get<i8>(inputPixelIdx);
                accumulate += ((i64)filterPixel) * inputPixel;
            }

            #endif


            if (qparam.quantedOutput) {
                i32 outputPixel = accumulate / qparam.outputscaler;
                // i32 outputPixel = (accumulate * qparam.outputscaler) >> 32;
                const i8 finalOutputPixel = (outputPixel > 0 || !useRelu) ? (int8_t) (outputPixel + qparam.Z_i_next) : (int8_t) qparam.Z_i_next;
                outputData.get<i8>(outputPixelIdx) = finalOutputPixel;
            }
            else {
                fp64 testPixel = ((fp64) accumulate) * (1.0f / (((float) qparam.S_i) * ((float) qparam.S_w)));
                const fp32 finalTestPixel = (testPixel > 0 || !useRelu) ? (fp32) testPixel : 0;
                outputData.get<fp32>(outputPixelIdx) = finalTestPixel;
            }
        }

    }

    void DenseLayer::computeFastAccelerated(const LayerData &dataIn, AccelParams aparam) const {

    }


    void DenseLayer::computeAccelerated(const LayerData &dataIn) const
    {
#ifdef BRUH
        /*
            weights: (filter width, n Filters / n output channels)
            input: (input width / filter width)
            output: (n output channels)
        */

        const LayerParams &outputParams = getOutputParams();
        const LayerParams &inputParams = getInputParams();

        const int8_t *input_data_ptr = static_cast<const int8_t *>(dataIn.raw());
        const int8_t *weight_data_ptr = static_cast<const int8_t *>(weightData.raw());
        const int32_t *bias_data_ptr = static_cast<const int32_t *>(biasData.raw());
        // LayerData &outputData = getOutputData();
        int8_t *output_data_ptr = static_cast<int8_t *>(getOutputData().raw());

        const size_t nOutputChannels = outputParams.dims[0];
        const size_t inputWidth = inputParams.dims[0];

        std::vector<input_t> mac_operations;
        mac_operations.reserve(inputWidth); // Reserve space for inputs

        for (size_t outputPixelIdx = 0; outputPixelIdx < nOutputChannels; outputPixelIdx++)
        {
            mac_operations.clear(); // Clear previous output

            // The bias is the initial value for the accumulator
            const int32_t initial_acc = bias_data_ptr[outputPixelIdx];

            for (size_t inputPixelIdx = 0; inputPixelIdx < inputWidth; inputPixelIdx++)
            {
                size_t filterIdx = outputPixelIdx * (inputWidth) + inputPixelIdx;
                const int8_t filterPixel = weight_data_ptr[filterIdx];
                const int8_t inputPixel = input_data_ptr[inputPixelIdx];
                mac_operations.push_back({filterPixel, inputPixel});
            }

            // Send to the hardware
            fifo_write_data(initial_acc);

            for (const auto &op : mac_operations)
            {
                fifo_write_data(op);
            }

            uint32_t totalBytes = (1 + mac_operations.size()) * 4;
            fifo_set_transmit_length(totalBytes);

            fifo_wait_for_data();
            int32_t hardware_result = fifo_read_data();

            // Apply relu if enabled for this layer.
            if (useRelu && hardware_result < 0)
            {
                hardware_result = 0;
            }

            // Clamp 32-bit result to fit into 8-bit int
            int8_t finalOutputPixel;
            if (hardware_result > 127)
            {
                finalOutputPixel = 127;
            }
            else if (hardware_result < -128)
            {
                finalOutputPixel = -128;
            }
            else
            {
                finalOutputPixel = static_cast<int8_t>(hardware_result);
            }

            output_data_ptr[outputPixelIdx] = finalOutputPixel;
        }
#endif
    }

} // namespace ML