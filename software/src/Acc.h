#ifdef ZEDBOARD

#pragma once

#include <xllfifo_hw.h>
#include <xil_io.h>
#include "Utils.h"

namespace ML {
    typedef struct __packed {
        int8_t weight;    
        int8_t inp;
        operator uint32_t() const {
            return (weight << 8) | ((uint8_t) inp);
        }
    } input_t;

    void runMacTest(const std::string& name, int32_t initial_acc, const std::vector<input_t>& inputs) {
        printf("Running Test: %s \n", name.c_str());
        int32_t expectedResult = initial_acc;
        for (const auto& input_pair: inputs) {
            expectedResult += (int32_t) input_pair.weight * (int32_t) input_pair.inp;
        }
        printf("    - Expected Result: %ld \n", expectedResult);

        // Send inital accumulator value
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, initial_acc);
        
        // Send inputs
        for (const auto& input_pair: inputs) {
            Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, input_pair);
        }

        uint32_t totalBytes = ((1 + inputs.size()) * 4);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, totalBytes);

        // Wait until FIFO receives data
        while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);
        int32_t hardware_Result = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
        printf("    - Hardware Result: %d \n", (int) hardware_Result);
        
    }    

    void testFPGAMac() {

        printf("--- Testing Hardware MAC ---\n\n");

        runMacTest("Basic Positive Values", 0, {{5, 10}, {8, 4}});
        runMacTest("Basic Negative Values", 0, {{-5, -10}, {-8, -4}});
        runMacTest("Mixed Sign Values", 0, {{10, -5}, {-4, 20}});
        runMacTest("All Zero Inputs", 0, {{0, 0}, {0, 0}});

        runMacTest("Max Positive Values", 0, {{127, 127}});
        runMacTest("Min Negative Values", 0, {{-128, -128}});
        runMacTest("Min x Max Values", 0, {{-128, 127}});
        runMacTest("Max x Min Values", 0, {{127, -128}});
        runMacTest("Mixed Boundaries", 0, {{127, 127}, {-128, -128}});

        runMacTest("Positive Initial Accumulator", 1000, {{10, 10}, {-5, 5}});
        runMacTest("Negative Initial Accumulator", -1000, {{10, 10}, {-5, 5}});

        runMacTest("No MAC operations", 12345, {});
        runMacTest("Single MAC operation", 0, {{-10, -20}});

        runMacTest("Larger Batch Operation", -99, {
            {30, -35}, {18, 10}, {-122, 43}, {99, -1}, {-128, -127}, {99, 99}, {0, 127}, {-1, -1}, {13, -99}, {12, 123}, {-128, -128}
        });


    //     input_t input;
    //     input.weight = 10;
    //     input.inp = -5;
    //     // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + 0x38, 0x5);
    //     // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x020A);
    //     // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + 0x38, 0x5);
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -30);
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, input);
    //     // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0908);
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, 2*4);

    //     while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

    //     while (true) {
    //         uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
    //         for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
    //             int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
    //             logInfo("Got " + std::to_string(in_data));
    //         }

    //         if (!(read_len & (1 << 31)))
    //             break;
    //     }
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -30);
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0AFB);
    //     // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0908);
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, 2*4);

    //     while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

    //     while (true) {
    //         uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
    //         for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
    //             int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
    //             logInfo("Got " + std::to_string(in_data));
    //         }

    //         if (!(read_len & (1 << 31)))
    //             break;
    //     }

    //     input_t weights_and_inputs[]  = { {30, -35}, {18, 10}, {-122, 43}, {99, -1}, {-128, -127}, {99, 99} };
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -99);
    //     for (input_t x : weights_and_inputs) {
    //         Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, x);
    //     }
    //     Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, ((sizeof(weights_and_inputs) / sizeof(input_t)) + 1) * 4);

    //     while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

    //     while (true) {
    //         uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
    //         for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
    //             int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
    //             logInfo("Got " + std::to_string(in_data));
    //         }

    //         if (!(read_len & (1 << 31)))
    //             break;
    //     }

    }
}

#endif