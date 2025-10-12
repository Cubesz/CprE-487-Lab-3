#ifdef ZEDBOARD

#pragma once

#include <xllfifo_hw.h>
#include <xil_io.h>
#include "Utils.h"
namespace ML {
    void testFPGAMac() {
        typedef struct __packed {
            int8_t weight;    
            int8_t inp;
            operator uint32_t() const {
                return (weight << 8) | ((uint8_t) inp);
            }
        } input_t;
        input_t input;
        input.weight = 10;
        input.inp = -5;
        // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + 0x38, 0x5);
        // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x020A);
        // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + 0x38, 0x5);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -30);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, input);
        // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0908);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, 2*4);

        while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

        while (true) {
            uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
            for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
                int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
                logInfo("Got " + std::to_string(in_data));
            }

            if (!(read_len & (1 << 31)))
                break;
        }
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -30);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0AFB);
        // Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, 0x0908);
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, 2*4);

        while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

        while (true) {
            uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
            for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
                int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
                logInfo("Got " + std::to_string(in_data));
            }

            if (!(read_len & (1 << 31)))
                break;
        }

        input_t weights_and_inputs[]  = { {30, -35}, {18, 10}, {-122, 43}, {99, -1}, {-128, -127}, {99, 99} };
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, -99);
        for (input_t x : weights_and_inputs) {
            Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TDFD_OFFSET, x);
        }
        Xil_Out32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_TLF_OFFSET, ((sizeof(weights_and_inputs) / sizeof(input_t)) + 1) * 4);

        while (Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFO_OFFSET) == 0);

        while (true) {
            uint32_t read_len = Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RLF_OFFSET);
            for (int i = 0; i < (read_len & 0x7FFFFFFFUL); i += 4) {
                int32_t in_data = (int32_t) Xil_In32(XPAR_AXI_FIFO_0_BASEADDR + XLLF_RDFD_OFFSET);
                logInfo("Got " + std::to_string(in_data));
            }

            if (!(read_len & (1 << 31)))
                break;
        }

    }
}

#endif