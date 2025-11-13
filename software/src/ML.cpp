#include <iostream>
#include <sstream>
#include <vector>

#include "Config.h"
#include "Model.h"
#include "Types.h"
#include "Utils.h"
#include "layers/Convolutional.h"
#include "layers/Dense.h"
#include "layers/Flatten.h"
#include "layers/Layer.h"
#include "layers/MaxPooling.h"
#include "layers/Softmax.h"
#include "image_classes.h"

#ifdef ZEDBOARD
#include <file_transfer/file_transfer.h>
#include "Acc.h"
#endif

namespace ML
{
    Model build4QModel() {
        Model model;

        std::cout << "Adding Layer 1: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},                                    // Input Data
            LayerParams{sizeof(i8), {60, 60, 32}},                                   // Output Data
            LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_4q.bin"}            // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32

        std::cout << "Adding Layer 2: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {60, 60, 32}},                                    // Input Data
            LayerParams{sizeof(i8), {56, 56, 32}},                                    // Output Data
            LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_4q.bin"}             // Bias
        );

        // --- MPL 1: L3 ---
        // Input shape: 56x56x32
        // Output shape: 28x28x32
        std::cout << "Adding Layer 3: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {56, 56, 32}}, // Input
            LayerParams{sizeof(i8), {28, 28, 32}}  // Output
        );

        // --- Conv 3: L4 ---
        // Input shape: 28x28x32
        // Output shape: 26x26x64
        std::cout << "Adding Layer 4: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {28, 28, 32}},                                    // Input Data
            LayerParams{sizeof(i8), {26, 26, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_4q.bin"}             // Bias
        );

        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        std::cout << "Adding Layer 5: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {26, 26, 64}},                                    // Input Data
            LayerParams{sizeof(i8), {24, 24, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_4q.bin"}             // Bias
        );

        // --- MPL 2: L6 ---
        // Input shape: 24x24x64
        // Output shape: 12x12x64
        std::cout << "Adding Layer 6: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {24, 24, 64}}, // Input
            LayerParams{sizeof(i8), {12, 12, 64}}  // Output
        );

        // --- Conv 5: L7 ---
        // Input shape: 12x12x64
        // Output shape: 10x10x64

        std::cout << "Adding Layer 7: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {12, 12, 64}},                                    // Input Data
            LayerParams{sizeof(i8), {10, 10, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_4q.bin"}             // Bias
        );

        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        std::cout << "Adding Layer 8: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {10, 10, 64}},                                     // Input Data
            LayerParams{sizeof(i8), {8, 8, 128}},                                      // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_4q.bin"}             // Bias
        );

        // --- MPL 3: L9 ---
        // Input shape: 8x8x128
        // Output shape: 4x4x128

        std::cout << "Adding Layer 9: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {8, 8, 128}}, // Input
            LayerParams{sizeof(i8), {4, 4, 128}}  // Output
        );

        // --- Flatten 1: L10 ---
        // Input shape: 4x4x128
        // Output shape: 2048

        std::cout << "Adding Layer 10: Flatten" << std::endl;
        model.addLayer<FlattenLayer>(
            LayerParams{sizeof(i8), {4, 4, 128}}, // Input
            LayerParams{sizeof(i8), {2048}}       // Output
        );

        // --- Dense 1: L11 ---
        // Input shape: 2048
        // Output shape: 256

        std::cout << "Adding Layer 11: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {2048}},                                        // Input
            LayerParams{sizeof(i8), {256}},                                         // Output
            LayerParams{sizeof(i8), {2048, 256},"data/quant/param_layer_6/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {256},"data/quant/param_layer_6/biases_4q.bin"},        // Biases,
            true);

        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200

        std::cout << "Adding Layer 12: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {256}},                                        // Input
            LayerParams{sizeof(fp32), {200}},                                        // Output
            LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_4q.bin"},       // Biases
            false                                                                    // Enable Relu
        );

        // --- Softmax 1: L13 ---
        // Input shape: 200
        // Output shape: 200

        std::cout << "Adding Layer 13: Softmax" << std::endl;
        model.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );

        return model;
    }

    Model build8QModel() {
        Model model;

        std::cout << "Adding Layer 1: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},                                    // Input Data
            LayerParams{sizeof(i8), {60, 60, 32}},                                   // Output Data
            LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"}            // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32

        std::cout << "Adding Layer 2: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {60, 60, 32}},                                    // Input Data
            LayerParams{sizeof(i8), {56, 56, 32}},                                    // Output Data
            LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_8q.bin"}             // Bias
        );

        // --- MPL 1: L3 ---
        // Input shape: 56x56x32
        // Output shape: 28x28x32
        std::cout << "Adding Layer 3: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {56, 56, 32}}, // Input
            LayerParams{sizeof(i8), {28, 28, 32}}  // Output
        );

        // --- Conv 3: L4 ---
        // Input shape: 28x28x32
        // Output shape: 26x26x64
        std::cout << "Adding Layer 4: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {28, 28, 32}},                                    // Input Data
            LayerParams{sizeof(i8), {26, 26, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_8q.bin"}             // Bias
        );

        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        std::cout << "Adding Layer 5: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {26, 26, 64}},                                    // Input Data
            LayerParams{sizeof(i8), {24, 24, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_8q.bin"}             // Bias
        );

        // --- MPL 2: L6 ---
        // Input shape: 24x24x64
        // Output shape: 12x12x64
        std::cout << "Adding Layer 6: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {24, 24, 64}}, // Input
            LayerParams{sizeof(i8), {12, 12, 64}}  // Output
        );

        // --- Conv 5: L7 ---
        // Input shape: 12x12x64
        // Output shape: 10x10x64

        std::cout << "Adding Layer 7: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {12, 12, 64}},                                    // Input Data
            LayerParams{sizeof(i8), {10, 10, 64}},                                    // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_8q.bin"}             // Bias
        );

        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        std::cout << "Adding Layer 8: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {10, 10, 64}},                                     // Input Data
            LayerParams{sizeof(i8), {8, 8, 128}},                                      // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_8q.bin"}             // Bias
        );

        // --- MPL 3: L9 ---
        // Input shape: 8x8x128
        // Output shape: 4x4x128

        std::cout << "Adding Layer 9: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {8, 8, 128}}, // Input
            LayerParams{sizeof(i8), {4, 4, 128}}  // Output
        );

        // --- Flatten 1: L10 ---
        // Input shape: 4x4x128
        // Output shape: 2048

        std::cout << "Adding Layer 10: Flatten" << std::endl;
        model.addLayer<FlattenLayer>(
            LayerParams{sizeof(i8), {4, 4, 128}}, // Input
            LayerParams{sizeof(i8), {2048}}       // Output
        );

        // --- Dense 1: L11 ---
        // Input shape: 2048
        // Output shape: 256

        std::cout << "Adding Layer 11: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {2048}},                                        // Input
            LayerParams{sizeof(i8), {256}},                                         // Output
            LayerParams{sizeof(i8), {2048, 256},"data/quant/param_layer_6/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {256},"data/quant/param_layer_6/biases_8q.bin"},        // Biases,
            true);

        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200

        std::cout << "Adding Layer 12: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {256}},                                        // Input
            LayerParams{sizeof(fp32), {200}},                                        // Output
            LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_8q.bin"},       // Biases
            false                                                                    // Enable Relu
        );

        // --- Softmax 1: L13 ---
        // Input shape: 200
        // Output shape: 200

        std::cout << "Adding Layer 13: Softmax" << std::endl;
        model.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );

        return model;
    }

    // Build our ML toy model
    Model buildToyModel(const Path modelPath)
    {
        Model model;
        logInfo("--- Building Toy Model ---");

        // --- Conv 1: L1 ---
        // Input shape: 64x64x3
        // Output shape: 60x60x32

        // You can pick how you want to implement your layers, both are allowed:

        // LayerParams conv1_inDataParam(sizeof(fp32), {64, 64, 3});
        // LayerParams conv1_outDataParam(sizeof(fp32), {60, 60, 32});
        // LayerParams conv1_weightParam(sizeof(fp32), {5, 5, 3, 32}, modelPath / "conv1_weights.bin");
        // LayerParams conv1_biasParam(sizeof(fp32), {32}, modelPath / "conv1_biases.bin");
        // auto conv1 = new ConvolutionalLayer(conv1_inDataParam, conv1_outDataParam, conv1_weightParam, conv1_biasParam);

        std::cout << "Adding Layer 1: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {64, 64, 3}},                                    // Input Data
            LayerParams{sizeof(fp32), {60, 60, 32}},                                   // Output Data
            LayerParams{sizeof(fp32), {5, 5, 3, 32}, modelPath / "conv1_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {32}, modelPath / "conv1_biases.bin"}            // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32

        std::cout << "Adding Layer 2: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {60, 60, 32}},                                    // Input Data
            LayerParams{sizeof(fp32), {56, 56, 32}},                                    // Output Data
            LayerParams{sizeof(fp32), {5, 5, 32, 32}, modelPath / "conv2_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {32}, modelPath / "conv2_biases.bin"}             // Bias
        );

        // --- MPL 1: L3 ---
        // Input shape: 56x56x32
        // Output shape: 28x28x32
        std::cout << "Adding Layer 3: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(fp32), {56, 56, 32}}, // Input
            LayerParams{sizeof(fp32), {28, 28, 32}}  // Output
        );

        // --- Conv 3: L4 ---
        // Input shape: 28x28x32
        // Output shape: 26x26x64
        std::cout << "Adding Layer 4: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {28, 28, 32}},                                    // Input Data
            LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 32, 64}, modelPath / "conv3_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv3_biases.bin"}             // Bias
        );

        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        std::cout << "Adding Layer 5: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Input Data
            LayerParams{sizeof(fp32), {24, 24, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv4_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv4_biases.bin"}             // Bias
        );

        // --- MPL 2: L6 ---
        // Input shape: 24x24x64
        // Output shape: 12x12x64
        std::cout << "Adding Layer 6: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(fp32), {24, 24, 64}}, // Input
            LayerParams{sizeof(fp32), {12, 12, 64}}  // Output
        );

        // --- Conv 5: L7 ---
        // Input shape: 12x12x64
        // Output shape: 10x10x64

        std::cout << "Adding Layer 7: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {12, 12, 64}},                                    // Input Data
            LayerParams{sizeof(fp32), {10, 10, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv5_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv5_biases.bin"}             // Bias
        );

        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        std::cout << "Adding Layer 8: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(fp32), {10, 10, 64}},                                     // Input Data
            LayerParams{sizeof(fp32), {8, 8, 128}},                                      // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 128}, modelPath / "conv6_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {128}, modelPath / "conv6_biases.bin"}             // Bias
        );

        // --- MPL 3: L9 ---
        // Input shape: 8x8x128
        // Output shape: 4x4x128

        std::cout << "Adding Layer 9: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(fp32), {8, 8, 128}}, // Input
            LayerParams{sizeof(fp32), {4, 4, 128}}  // Output
        );

        // --- Flatten 1: L10 ---
        // Input shape: 4x4x128
        // Output shape: 2048

        std::cout << "Adding Layer 10: Flatten" << std::endl;
        model.addLayer<FlattenLayer>(
            LayerParams{sizeof(fp32), {4, 4, 128}}, // Input
            LayerParams{sizeof(fp32), {2048}}       // Output
        );

        // --- Dense 1: L11 ---
        // Input shape: 2048
        // Output shape: 256

        std::cout << "Adding Layer 11: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(fp32), {2048}},                                        // Input
            LayerParams{sizeof(fp32), {256}},                                         // Output
            LayerParams{sizeof(fp32), {2048, 256}, modelPath / "dense1_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {256}, modelPath / "dense1_biases.bin"},        // Biases,
            true);

        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200

        std::cout << "Adding Layer 12: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(fp32), {256}},                                        // Input
            LayerParams{sizeof(fp32), {200}},                                        // Output
            LayerParams{sizeof(fp32), {256, 200}, modelPath / "dense2_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {200}, modelPath / "dense2_biases.bin"},       // Biases
            false                                                                    // Enable Relu
        );

        // --- Softmax 1: L13 ---
        // Input shape: 200
        // Output shape: 200

        std::cout << "Adding Layer 13: Softmax" << std::endl;
        model.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );

        return model;
    }

    // Function to get the input file path for a given layer index
    Path getLayerInputPath(const Path &basePath, int layer_idx)
    {
        if (layer_idx == 0)
        {
            return basePath / "image_0.bin";
        }
        std::string prev_layer_output_filename = "layer_" + std::to_string(layer_idx - 1) + "_output.bin";
        return basePath / "image_0_data" / prev_layer_output_filename.c_str();
    }

    void checkConvLayer(
        const Path &basePath,
        int layer_idx,
        const LayerParams &inParams,
        const LayerParams &outParams,
        const LayerParams &weightParams,
        const LayerParams &biasParams)
    {
        std::string layer_name = "Layer " + std::to_string(layer_idx) + ": Convolutional";
        logInfo("----- Verifying " + layer_name + " -----");

        ConvolutionalLayer layer(inParams, outParams, weightParams, biasParams);
        layer.allocLayer();

        Path input_file_path = getLayerInputPath(basePath, layer_idx);
        LayerData inputData(inParams, input_file_path);
        inputData.loadData();

        Timer timer(layer_name + " Inference");
        timer.start();
        layer.computeNaive(inputData);
        timer.stop();

        const LayerData &actual_output = layer.getOutputData();
        std::string expected_output_filename = "layer_" + std::to_string(layer_idx) + "_output.bin";
        LayerData expected_output(outParams, basePath / "image_0_data" / expected_output_filename.c_str());
        expected_output.loadData();

        log("Comparing C++ output against TensorFlow output...");
        actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

        layer.freeLayer();
    }


    // void checkMaxPoolingLayer(
    //     const Path &basePath,
    //     int layer_idx,
    //     const LayerParams &inParams,
    //     const LayerParams &outParams)
    // {
    //     std::string layer_name = "Layer " + std::to_string(layer_idx) + ": MaxPooling";
    //     logInfo("----- Verifying " + layer_name + " -----");

    //     MaxPoolingLayer layer(inParams, outParams);
    //     layer.allocLayer();

    //     Path input_file_path = getLayerInputPath(basePath, layer_idx);
    //     LayerData inputData(inParams, input_file_path);
    //     inputData.loadData();

    //     Timer timer(layer_name + " Inference");
    //     timer.start();
    //     layer.computeNaive(inputData);
    //     timer.stop();

    //     const LayerData &actual_output = layer.getOutputData();
    //     std::string expected_output_filename = "layer_" + std::to_string(layer_idx) + "_output.bin";
    //     LayerData expected_output(outParams, basePath / "image_0_data" / expected_output_filename.c_str());
    //     expected_output.loadData();

    //     log("Comparing C++ output against TensorFlow output...");
    //     actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

    //     layer.freeLayer();
    // }

    // void checkFlattenLayer(
    //     const Path &basePath,
    //     int layer_idx,
    //     const LayerParams &inParams,
    //     const LayerParams &outParams)
    // {
    //     std::string layer_name = "Layer " + std::to_string(layer_idx) + ": Flatten";
    //     logInfo("----- Verifying " + layer_name + " -----");

    //     FlattenLayer layer(inParams, outParams);
    //     layer.allocLayer();

    //     Path input_file_path = getLayerInputPath(basePath, layer_idx);
    //     LayerData inputData(inParams, input_file_path);
    //     inputData.loadData();

    //     Timer timer(layer_name + " Inference");
    //     timer.start();
    //     layer.computeNaive(inputData);
    //     timer.stop();

    //     const LayerData &actual_output = layer.getOutputData();
    //     std::string expected_output_filename = "layer_" + std::to_string(layer_idx) + "_output.bin";
    //     LayerData expected_output(outParams, basePath / "image_0_data" / expected_output_filename.c_str());
    //     expected_output.loadData();

    //     log("Comparing C++ output against TensorFlow output...");
    //     actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

    //     layer.freeLayer();
    // }

    // std::string formatDims(const ML::dimVec &dims)
    // {
    //     std::stringstream ss;
    //     ss << "[";
    //     for (size_t i = 0; i < dims.size(); ++i)
    //     {
    //         ss << dims[i];
    //         if (i < dims.size() - 1)
    //         {
    //             ss << ", ";
    //         }
    //     }
    //     ss << "]";
    //     return ss.str();
    // }

    // void checkDenseLayer(
    //     const Path &basePath,
    //     int layer_idx,
    //     const LayerParams &inParams,
    //     const LayerParams &outParams,
    //     const LayerParams &weightParams,
    //     const LayerParams &biasParams,
    //     bool useRelu)
    // {
    //     std::string layer_name = "Layer " + std::to_string(layer_idx) + ": Dense";
    //     logInfo("----- Verifying " + layer_name + " -----");

    //     DenseLayer layer(inParams, outParams, weightParams, biasParams, useRelu);
    //     layer.allocLayer();

    //     std::cout << "Layer " << layer_idx << " Input Shape:  " << formatDims(inParams.dims) << std::endl;
    //     std::cout << "Layer " << layer_idx << " Output Shape: " << formatDims(outParams.dims) << std::endl;

    //     std::cout << "--- Inspecting Layer " << layer_idx << " Data ---" << std::endl;
    //     const float *weights = static_cast<const float *>(layer.getWeightData().raw());
    //     const float *biases = static_cast<const float *>(layer.getBiasData().raw());
    //     std::cout << "First 5 weights: ";
    //     for (int i = 0; i < 5; ++i)
    //         std::cout << weights[i] << " ";
    //     std::cout << std::endl;
    //     std::cout << "First 5 biases: ";
    //     for (int i = 0; i < 5; ++i)
    //         std::cout << biases[i] << " ";
    //     std::cout << std::endl;

    //     Path input_file_path = getLayerInputPath(basePath, layer_idx);
    //     LayerData inputData(inParams, input_file_path);
    //     inputData.loadData();

    //     Timer timer(layer_name + " Inference");
    //     timer.start();
    //     layer.computeNaive(inputData);
    //     timer.stop();

    //     const LayerData &actual_output = layer.getOutputData();
    //     std::string expected_output_filename = "layer_" + std::to_string(layer_idx) + "_output.bin";
    //     LayerData expected_output(outParams, basePath / "image_0_data" / expected_output_filename.c_str());
    //     expected_output.loadData();

    //     log("Comparing C++ output against TensorFlow output...");
    //     actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

    //     layer.freeLayer();
    // }

    // void checkDenseWithSoftmaxLayer(
    //     const Path &denseBasePath,
    //     int denseLayer_idx,
    //     const LayerParams &denseInParams,
    //     const LayerParams &denseOutParams,
    //     const LayerParams &denseWeightParams,
    //     const LayerParams &denseBiasParams,
    //     const Path &softmaxBasePath,
    //     int softmaxLayer_idx,
    //     const LayerParams &softmaxInParams,
    //     const LayerParams &softmaxOutParams)
    // {

    //     std::string denseLayer_name = "Layer " + std::to_string(denseLayer_idx) + ": Dense";
    //     std::string softmaxLayer_name = "Layer " + std::to_string(softmaxLayer_idx) + ": Softmax";
    //     logInfo("----- Verifying " + denseLayer_name + " + " + softmaxLayer_name + " -----");

    //     DenseLayer denseLayer(denseInParams, denseOutParams, denseWeightParams, denseBiasParams, false);
    //     SoftmaxLayer softmaxLayer(softmaxInParams, softmaxOutParams);
    //     denseLayer.allocLayer();
    //     softmaxLayer.allocLayer();

    //     std::cout << "Dense Layer " << denseLayer_idx << " Input Shape:  " << formatDims(denseInParams.dims) << std::endl;
    //     std::cout << "Dense Layer " << denseLayer_idx << " Output Shape: " << formatDims(denseOutParams.dims) << std::endl;

    //     std::cout << "Softmax Layer " << denseLayer_idx << " Input Shape:  " << formatDims(denseInParams.dims) << std::endl;
    //     std::cout << "Softmax Layer " << denseLayer_idx << " Output Shape: " << formatDims(denseOutParams.dims) << std::endl;

    //     Path dense_input_file_path = getLayerInputPath(denseBasePath, denseLayer_idx);
    //     LayerData denseInputData(denseInParams, dense_input_file_path);
    //     denseInputData.loadData();

    //     Timer denseTimer(denseLayer_name + " Inference");
    //     denseTimer.start();
    //     denseLayer.computeNaive(denseInputData);
    //     denseTimer.stop();
    //     Timer softmaxTimer(softmaxLayer_name + " Inference");
    //     softmaxTimer.start();
    //     softmaxLayer.computeNaive(denseLayer.getOutputData());
    //     softmaxTimer.stop();

    //     const LayerData &actual_output = softmaxLayer.getOutputData();
    //     std::string expected_output_filename = "layer_" + std::to_string(denseLayer_idx) + "_output.bin";
    //     LayerData expected_output(denseOutParams, denseBasePath / "image_0_data" / expected_output_filename.c_str());
    //     expected_output.loadData();

    //     log("Comparing C++ output against TensorFlow output...");
    //     actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

    //     denseLayer.freeLayer();
    // }

    void runBasicTest(const Model &model, const Path &basePath)
    {
        logInfo("--- Running Basic Test ---");

        // Load an image
        LayerData img = {{sizeof(fp32), {64, 64, 3}, "./data/image_0.bin"}};
        img.loadData();

        // Compare images
        std::cout << "Comparing image 0 to itself (max error): " << img.compare<fp32>(img) << std::endl
                  << "Comparing image 0 to itself (T/F within epsilon " << ML::Config::EPSILON << "): " << std::boolalpha
                  << img.compareWithin<fp32>(img, ML::Config::EPSILON) << std::endl;

        // Test again with a modified copy
        std::cout << "\nChange a value by 0.1 and compare again" << std::endl;

        LayerData imgCopy = img;
        imgCopy.get<fp32>(0) += 0.1;

        // Compare images
        img.compareWithinPrint<fp32>(imgCopy);

        // Test again with a modified copy
        log("Change a value by 0.1 and compare again...");
        imgCopy.get<fp32>(0) += 0.1;

        // Compare Images
        img.compareWithinPrint<fp32>(imgCopy);
    }

    void runLayerTest(const std::size_t layerNum, const Model &model, const Path &basePath)
    {
        // Load an image
        logInfo(std::string("--- Running Layer Test ") + std::to_string(layerNum) + "---");

        // Construct a LayerData object from a LayerParams one
        // LayerData img(model[layerNum].getInputParams(), test_image_files[layerNum].first);
        dimVec inDims = {64, 64, 3};
        LayerData img({sizeof(fp32), inDims, basePath / "image_0.bin"});
        img.loadData();

        Timer timer("Layer Inference");

        // Run inference on the model
        timer.start();
        const LayerData &output = model.inferenceLayer(img, layerNum, Layer::InfType::NAIVE);
        timer.stop();

        // Compare the output
        // Construct a LayerData object from a LayerParams one
        LayerData expected(output.getParams(), basePath / "image_0_data" / "layer_0_output.bin");
        expected.loadData();
        output.compareWithinPrint<fp32>(expected);
    }

    bool runInfTestQuant(const Model& model, Path inputPath, int actualClass, const QParams* qparams) {
        // Load an image
        logInfo("--- Running Inference Test ---");

        // Construct a LayerData object from a LayerParams one
        LayerData img(model[0].getInputParams(), inputPath);
        img.loadData();

        // Timer timer("Full Inference");

        // Run inference on the model
        // timer.start();
        const LayerData &output = model.inference(img, Layer::InfType::QUANTIZED, qparams);
        // timer.stop();

        
        struct ClassPrediction {
            size_t classIdx;
            fp32 confidence;
        };
        ClassPrediction top10[10] = {0};
        for (size_t i = 0; i < output.getParams().dims[0]; i++) {
            fp32 confidence = output.get<fp32>(i);
            for (size_t j = 0; j < 10; j++) {
                if (confidence > top10[j].confidence) {
                    top10[j] = { i, confidence };
                    break;
                }
            }
        }

        // printf("Top10:\n");
        // for (size_t i = 0; i < 10; i++) {
        //     printf("Class: %ld, Confidence: %f\n", top10[i].classIdx, top10[i].confidence);
        // }

        return top10[0].classIdx == (size_t) actualClass;

    }

    void runInferenceTest(const Model &model, const Path &basePath)
    {
        // Load an image
        logInfo("--- Running Inference Test ---");

        // Construct a LayerData object from a LayerParams one
        LayerData img(model[0].getInputParams(), basePath / "image_0.bin");
        img.loadData();

        Timer timer("Full Inference");

        // Run inference on the model
        timer.start();
        const LayerData &output = model.inference(img, Layer::InfType::NAIVE);
        timer.stop();

        // Compare the output
        // Construct a LayerData object from a LayerParams one
        // LayerData expected(model.getOutputLayer().getOutputParams(), basePath / "image_0_data" / "layer_0_output.bin");
        LayerData expected(model.getOutputLayer().getOutputParams(), basePath / "image_0_data" / ("layer_" + std::to_string(model.getNumLayers() - 2) + "_output.bin")); // minus 2 because the final dense bin includes softmax
        // while we have it as a seperate layer and also 0 vs 1 start indexing
        expected.loadData();
        output.compareWithinPrint<fp32>(expected);
        
        struct ClassPrediction {
            size_t classIdx;
            fp32 confidence;
        };
        ClassPrediction top10[10] = {0};
        for (size_t i = 0; i < output.getParams().dims[0]; i++) {
            fp32 confidence = output.get<fp32>(i);
            for (size_t j = 0; j < 10; j++) {
                if (confidence > top10[j].confidence) {
                    top10[j] = { i, confidence };
                    break;
                }
            }
        }

        printf("Top10:\n");
        for (size_t i = 0; i < 10; i++) {
            printf("Class: %ld, Confidence: %f\n", top10[i].classIdx, top10[i].confidence);
        }
    }

    void runProfilingTest(const Model &model, const Path &basePath)
    {
        logInfo("----- Running Profiling Test -----");
        LayerData img(model[0].getInputParams(), basePath / "image_0.bin");
        img.loadData();

        std::vector<float> layerTimes;
        const LayerData *currentData = &img;

        for (size_t i = 0; i < model.getNumLayers(); ++i)
        {
            Timer layerTimer(std::string("Layer ") + std::to_string(i));
            layerTimer.start();
            currentData = &model.inferenceLayer(*currentData, i, Layer::InfType::NAIVE);
            layerTimer.stop();
            layerTimes.push_back(layerTimer.milliseconds);
        }

        logInfo("----- Profiling Results -----");

        float total = 0.0f;
        for (size_t i = 0; i < layerTimes.size(); ++i)
        {
            total += layerTimes[i];
        }

        printf("\n---- Indivisual Layer Times -----\n");
        for (size_t i = 0; i < layerTimes.size(); ++i)
        {
            float percentage = (layerTimes[i] / total) * 100.0f;
            std::cout << "Layer " << i << ": "
                      << layerTimes[i] << " ms ("
                      << percentage << "%)\n";
        }

        std::cout << "Total Time: " << total << " ms (" << total / 1000.0f << " s)\n";
    }


    void inspectQuantizedLayer(const Path& basePath, const std::string& layerName, const dimVec& weightDims, const dimVec& biasDims) {
        printf("Inspecting quantized layer: %s", layerName.c_str());
        Path quantizedModelPath = basePath / "model" / "quantized_model_binaries"; 
        Path weightsPath = quantizedModelPath / (layerName + "_quantized_weights.bin");
        Path biasPath = quantizedModelPath / (layerName + "_quantized_biases.bin");
        
        try {

            // Weights: 
            LayerParams qWeightsParams{sizeof(int8_t), weightDims, weightsPath};
            LayerData quantizedWeightsData(qWeightsParams);
            quantizedWeightsData.loadData();
            const int8_t* weightsPointer = static_cast<const int8_t*>(quantizedWeightsData.raw());
            
            printf("First 10 weights: [");
            for (int i = 0; i<10; i++) {
                printf("%d", (int) weightsPointer[i]);
                if (i < 9) {
                    printf(", ");
                }   
            }
            printf("\n");

            // Biases:
            LayerParams qBiasesParams{sizeof(int32_t), biasDims, biasPath};
            LayerData quantizedBiasesData(qBiasesParams);
            quantizedBiasesData.loadData();

            const int32_t* biasesPtr = static_cast<const int32_t*>(quantizedBiasesData.raw());

            printf("  Biases: [");
            for (size_t i = 0; i < 10; ++i) {
                printf("%d", (int)biasesPtr[i]);
                if (i < 9) {
                    printf(", ");
                }
            }
            printf("]\n\n");


        } catch (const std::exception& e) {
            printf("\n[ERROR] Failed to load or process weights or biases: %s\n", weightsPath.c_str());
            std::cerr << "  Reason: " << e.what() << '\n';
        }
    }

    void compareQuantizedData(const LayerData& actual, const LayerData& expected) {
        size_t mismatches = 0;
        const auto& dims = actual.getParams().dims;
        size_t elements = 1;
        for (auto d : dims) {
            elements *= d;
        }
        const int8_t* actual_ptr = static_cast<const int8_t*>(actual.raw());
        const int8_t* expected_ptr = static_cast<const int8_t*>(expected.raw());

        for (size_t i = 0; i < elements; ++i) {
            if (actual_ptr[i] != expected_ptr[i]) {
                mismatches++;
            }
        }

        if (mismatches == 0) {
            printf("     - Outputs match perfectly!\n");
        } else {
            printf("     - Outputs do not match. Mismatches: %zu / %zu (%.2f%%)\n",
                mismatches, elements, (double)mismatches / elements * 100.0);
        }
    }

    void checkLayerAccelerated(
        const Path& basePath,
        const std::string& layerName,
        const LayerParams& inParams,
        const LayerParams& outParams,
        const LayerParams& weightParams,
        const LayerParams& biasParams)
    {
        logInfo("Verifying Accelerated Layer: " + layerName);

        ConvolutionalLayer layer(inParams, outParams, weightParams, biasParams);
        layer.allocLayer();

        // Load the quantized input data
        Path quantizedModelPath = basePath / "model" / "quantized_model_binaries";
        Path input_file_path = quantizedModelPath / "quantized_image_0.bin";
        LayerData inputData(inParams, input_file_path);
        inputData.loadData();

        // Run accelerated
        Timer timer(layerName + " Accelerated Inference");
        timer.start();
        #ifdef ZEDBOARD
        layer.computeAccelerated(inputData);
        #endif
        timer.stop();

        // Load the quantized output reference
        const LayerData& actual_output = layer.getOutputData();
        Path expected_output_path = quantizedModelPath / ("quantized_" + layerName + "_output.bin");
        LayerData expected_output(outParams, expected_output_path);
        expected_output.loadData();

        // Compare results
        log("Comparing C++ hardware output against Python quantized output...");
        compareQuantizedData(actual_output, expected_output);

        layer.freeLayer();
    }

    void checkDenseLayerAccelerated(
        const Path& basePath,
        const std::string& layerName,
        const LayerParams& inParams,
        const LayerParams& outParams,
        const LayerParams& weightParams,
        const LayerParams& biasParams,
        bool useRelu)
    {
        logInfo("Verifying Accelerated Dense Layer: " + layerName);

        DenseLayer layer(inParams, outParams, weightParams, biasParams, useRelu);
        layer.allocLayer();

        // Load the quantized input data
        Path quantizedModelPath = basePath / "model" / "quantized_model_binaries";
        Path input_file_path = quantizedModelPath / ("quantized_" + layerName + "_input.bin");
        LayerData inputData(inParams, input_file_path);
        inputData.loadData();

        // Run accelerated
        Timer timer(layerName + " Accelerated Inference");
        timer.start();
        #ifdef ZEDBOARD
        layer.computeAccelerated(inputData);
        #endif
        timer.stop();

        // Load quantized output reference (from python)
        const LayerData& actual_output = layer.getOutputData();
        Path expected_output_path = quantizedModelPath / ("quantized_" + layerName + "_output.bin");
        LayerData expected_output(outParams, expected_output_path);
        expected_output.loadData();

        // Compare results
        log("Comparing C++ hardware output against Python quantized output...");
        compareQuantizedData(actual_output, expected_output);

// I used gemeni 2.5 to help add debug print statements as the dense output was not matching the one 
// from the python code. The result is the following
#if 0 // Set to 0 to disable these debug prints
    printf("\n--- DEBUG: Inspecting Inputs for Layer '%s' ---\n", layerName.c_str());

    // --- 1. Get pointers to all relevant data ---
    const int8_t* input_ptr = static_cast<const int8_t*>(inputData.raw());
    const int8_t* weight_ptr = static_cast<const int8_t*>(layer.getWeightData().raw());
    const int32_t* bias_ptr = static_cast<const int32_t*>(layer.getBiasData().raw());
    const int8_t* actual_output_ptr = static_cast<const int8_t*>(actual_output.raw());
    const int8_t* expected_output_ptr = static_cast<const int8_t*>(expected_output.raw());
    
    // Get dimensions
    const size_t inputWidth = layer.getInputParams().dims[0];
    const size_t nOutputChannels = layer.getOutputParams().dims[0];

    // --- 2. Print the first few INPUT values ---
    // These are the values that will be multiplied.
    printf("  - First 10 Input Activations: [");
    for (int i = 0; i < 10; ++i) {
        printf("%d", (int)input_ptr[i]);
        if (i < 9) printf(", ");
    }
    printf("]\n");

    // --- 3. Print the Bias and Weights for the FIRST output neuron (index 0) ---
    // This will tell you if your weight indexing is correct.
    printf("  - Bias for Output Neuron 0: %d\n", (int)bias_ptr[0]);
    printf("  - First 10 Weights for Output Neuron 0: [");
    for (int i = 0; i < 10; ++i) {
        // This uses the EXACT SAME indexing formula as your computeAccelerated function
        size_t filterIdx = 0 * inputWidth + i; // outputPixelIdx * inputWidth + inputPixelIdx
        printf("%d", (int)weight_ptr[filterIdx]);
        if (i < 9) printf(", ");
    }
    printf("]\n");

    printf("\n--- DEBUG: Inspecting Outputs for Layer '%s' ---\n", layerName.c_str());

    // --- 4. Print the first few OUTPUT values ---
    // Compare these two lines. They should be identical if everything is working.
    printf("  - First 10 ACTUAL (C++/FPGA) Outputs:   [");
    for (int i = 0; i < 10; ++i) {
        printf("%d", (int)actual_output_ptr[i]);
        if (i < 9) printf(", ");
    }
    printf("]\n");

    printf("  - First 10 EXPECTED (Python) Outputs: [");
    for (int i = 0; i < 10; ++i) {
        printf("%d", (int)expected_output_ptr[i]);
        if (i < 9) printf(", ");
    }
    printf("]\n\n");

#endif

        layer.freeLayer();
    }

// (In main.cpp, inside the ML namespace)

#include <fstream> // Required for std::ifstream

/**
 * @brief Manually reads a binary file into an int8_t vector to verify file integrity.
 * 
 * This function bypasses the LayerData class to isolate potential file-loading bugs.
 */
void manualFileReadTest(const Path& basePath, const std::string& layerName)
{
    logInfo("--- Running Manual File Read Test for: " + layerName + " ---");
    
    Path quantizedModelPath = basePath / "model" / "quantized_model_binaries";
    Path weights_filepath = quantizedModelPath / (layerName + "_quantized_weights.bin");

    std::ifstream file(weights_filepath.c_str(), std::ios::binary | std::ios::ate);
    if (!file.is_open()) {
        printf("  [ERROR] Could not open file: %s\n", weights_filepath.c_str());
        return;
    }

    std::streamsize size = file.tellg();
    file.seekg(0, std::ios::beg);

    std::vector<int8_t> buffer(size);
    // IMPORTANT: We read into a char* because that's what the API requires,
    // but we cast our int8_t vector's data pointer. This is safer.
    if (file.read(reinterpret_cast<char*>(buffer.data()), size)) {
        printf("  Successfully read %ld bytes from the file.\n", (long)size);
        printf("  First 10 values read directly from file: [");
        for (int i = 0; i < 10; ++i) {
            printf("%d", (int)buffer[i]);
            if (i < 9) {
                printf(", ");
            }
        }
        printf("]\n");
    } else {
        printf("  [ERROR] Failed to read from file.\n");
    }
}

    void runTests()
    {
        #ifdef BRUH
        testFPGAMac();
    
        Path basePath("/data"); // May need to be altered for zedboards loading from SD Cards

        inspectQuantizedLayer(basePath, "conv2d", {5, 5, 3, 32}, {32});
        inspectQuantizedLayer(basePath, "dense", {2048, 256}, {256});

        Path modelPath = basePath / "model";
        Path quantizedModelPath = modelPath / "quantized_model_binaries";

        checkLayerAccelerated(
            basePath,
            "conv2d",
            LayerParams{sizeof(int8_t), {64, 64, 3}},
            LayerParams{sizeof(int8_t), {60, 60, 32}},
            LayerParams{sizeof(int8_t), {5, 5, 3, 32}, quantizedModelPath / "conv2d_quantized_weights.bin"},
            LayerParams{sizeof(int32_t), {32}, quantizedModelPath / "conv2d_quantized_biases.bin"}
        );

        checkDenseLayerAccelerated(
            basePath, "dense",
            LayerParams{sizeof(int8_t), {2048}},
            LayerParams{sizeof(int8_t), {256}},
            LayerParams{sizeof(int8_t), {2048, 256}, quantizedModelPath / "dense_quantized_weights.bin"},
            LayerParams{sizeof(int32_t), {256}, quantizedModelPath / "dense_quantized_biases.bin"},
            true // first dense layer uses relu
        );


        #endif
        // // Base input data path (determined from current directory of where you are running the command)
        // Path basePath("data"); // May need to be altered for zedboards loading from SD Cards
        // Path modelPath = basePath / "model";


        // ConvolutionalLayer layer(LayerParams{sizeof(i8), {64,64,3}}, LayerParams{sizeof(i8), {60, 60, 32}}, LayerParams{sizeof(i8), {5, 5, 3, 32}, "quant/param_layer_0/weights_8q.bin"}, LayerParams{sizeof(i16), {32}, "quant/param_layer_0/biases_8q.bin"});
        // layer.allocLayer();

        Path input_file_path = "data/quant/given_image0_8q.bin";
        LayerData inputData(LayerParams{sizeof(i8), {64,64,3}}, input_file_path);
        inputData.loadData();

        // layer.computeQuantized(inputData, {player0outputscaler, 226, 419, Zp_macced_player0, -3, true});

        // const LayerData &actual_output = layer.getOutputData();

        // ConvolutionalLayer layer2(LayerParams{sizeof(i8), {60,60,32}}, LayerParams{sizeof(i8), {56, 56, 32}}, LayerParams{sizeof(i8), {5, 5, 32, 32}, "quant/param_layer_1/weights_8q.bin"}, LayerParams{sizeof(i16), {32}, "quant/param_layer_1/biases_8q.bin"});
        // layer2.allocLayer();
        // layer2.computeQuantized(actual_output, {player1outputscaler, 78, 261, Zp_macced_player1, -2, true});

        // const LayerData &next_actual_output = layer2.getOutputData();

        // MaxPoolingLayer poolLayer(LayerParams{sizeof(i8), {56, 56, 32}}, LayerParams{sizeof(i8), {28, 28, 32}});
        // poolLayer.allocLayer();
        // poolLayer.computeQuantized(next_actual_output, {0, 0, 0, 0, 0, true});
        // const LayerData& pool_actual_output = poolLayer.getOutputData();

        // ConvolutionalLayer layer3(LayerParams{sizeof(i8), {28,28,32}}, LayerParams{sizeof(fp32), {26, 26, 64}}, LayerParams{sizeof(i8), {3, 3, 32, 64}, "quant/param_layer_2/weights_8q.bin"}, LayerParams{sizeof(i16), {64}, "quant/param_layer_2/biases_8q.bin"});
        // layer3.allocLayer();
        // layer3.computeQuantized(pool_actual_output, {player2outputscaler, 30, 183, Zp_macced_player2, -1, false});
        // const LayerData& layer3_actual_output = layer3.getOutputData();

        // std::string expected_output_filename = "layer_" + std::to_string(3) + "_output.bin";
        // LayerData expected_output(LayerParams{sizeof(fp32), {26, 26, 64}}, basePath / "image_0_data" / expected_output_filename.c_str());
        // expected_output.loadData();

        // log("Comparing C++ output against TensorFlow output...");
        // layer3_actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);


        // layer3.freeLayer();
        // poolLayer.freeLayer();
        // layer2.freeLayer();
        // layer.freeLayer();

        // Model model8q = build8QModel(); 
        // model8q.allocLayers();
        Model model4q = build4QModel();
        model4q.allocLayers();

        // std::string expected_output_filename = "layer_" + std::to_string(11) + "_output.bin";
        // runInfTestQuant(model8q, "quant/given_image0_8q.bin", 163, modelQParams_8q);

        size_t imageIdx;
        int successes = 0;
        for (imageIdx = 0; imageIdx < 1000; imageIdx++) {
            // bool predictedAccurately = runInfTestQuant(model8q, "data/quant/images_1000_8b/" + std::to_string(imageIdx) + ".bin", images_8q_classes[imageIdx], modelQParams_8q);
            bool predictedAccurately = runInfTestQuant(model4q, "data/quant/images_1000_4b/" + std::to_string(imageIdx) + ".bin", images_4q_classes[imageIdx], modelQParams_4q);
            if (predictedAccurately)
                successes += 1;
        }
        fp32 accuracy = ((float) successes) / 1000.0f;
        std::cout << "4q accuracy: " << std::endl;
        std::cout << accuracy << std::endl;
        model4q.freeLayers();


        // const LayerData& output = model8q.inference(inputData, Layer::InfType::QUANTIZED, modelQParams_8q);

        // LayerData expected_output(LayerParams{sizeof(fp32), {200}}, basePath / "image_0_data" / expected_output_filename.c_str());
        // expected_output.loadData();

        // output.compareWithinPrint<fp32>(expected_output, 1e-4);
        // fp32 max = 0;
        // fp32 maxIdx = 0;
        // fp32 sMax = 0;
        // fp32 sMaxIdx = 0;
        // fp32 tMax = 0;
        // fp32 tMaxIdx = 0;
        // for (int i = 0; i < 200; i ++) {
        //     if (output.get<fp32>(i) > max) {
        //         max = output.get<fp32>(i);
        //         maxIdx = i;
        //     } else if (output.get<fp32>(i) > sMax) {
        //         sMax = output.get<fp32>(i);
        //         sMaxIdx = i;
        //     } else if (output.get<fp32>(i) > tMax) {
        //         tMax = output.get<fp32>(i);
        //         tMaxIdx = i;
        //     }
        // }
        // std::cout << max << std::endl;
        // std::cout << maxIdx << std::endl;
        // std::cout << sMax << std::endl;
        // std::cout << sMaxIdx << std::endl;
        // std::cout << tMax << std::endl;
        // std::cout << tMaxIdx << std::endl;
        // model8q.freeLayers();

        // // TODO: TEST EACH LAYER INDIVISUALLY
        // // Test first layer
        // checkConvLayer(
        //     basePath, 0,
        //     LayerParams{sizeof(i8), {64, 64, 3}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {60, 60, 32}},                                   // Output Data
        //     LayerParams{sizeof(i8), {5, 5, 3, 32}, modelPath / "conv1_weights.bin"}, // Weights
        //     LayerParams{sizeof(i16), {32}, modelPath / "conv1_biases.bin"}            // Bias
        // );

        // // Test second layer
        // checkConvLayer(
        //     basePath, 1,
        //     LayerParams{sizeof(fp32), {60, 60, 32}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {56, 56, 32}},                                    // Output Data
        //     LayerParams{sizeof(fp32), {5, 5, 32, 32}, modelPath / "conv2_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {32}, modelPath / "conv2_biases.bin"}             // Bias
        // );

        // // --- MPL 1: L3 ---
        // // Input shape: 56x56x32
        // // Output shape: 28x28x32
        // checkMaxPoolingLayer(
        //     basePath, 2,
        //     LayerParams{sizeof(fp32), {56, 56, 32}}, // Input
        //     LayerParams{sizeof(fp32), {28, 28, 32}}  // Output
        // );

        // // --- Conv 3: L4 ---
        // // Input shape: 28x28x32
        // // Output shape: 26x26x64
        // checkConvLayer(
        //     basePath, 3,
        //     LayerParams{sizeof(fp32), {28, 28, 32}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Output Data
        //     LayerParams{sizeof(fp32), {3, 3, 32, 64}, modelPath / "conv3_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {64}, modelPath / "conv3_biases.bin"}             // Bias
        // );

        // // --- Conv 4: L5 ---
        // // Input shape: 26x26x64
        // // Output shape: 24x24x64
        // checkConvLayer(
        //     basePath, 4,
        //     LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {24, 24, 64}},                                    // Output Data
        //     LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv4_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {64}, modelPath / "conv4_biases.bin"}             // Bias
        // );

        // // --- MPL 2: L6 ---
        // // Input shape: 24x24x64
        // // Output shape: 12x12x64
        // checkMaxPoolingLayer(
        //     basePath, 5,
        //     LayerParams{sizeof(fp32), {24, 24, 64}}, // Input
        //     LayerParams{sizeof(fp32), {12, 12, 64}}  // Output
        // );

        // // --- Conv 5: L7 ---
        // // Input shape: 12x12x64
        // // Output shape: 10x10x64
        // checkConvLayer(
        //     basePath, 6,
        //     LayerParams{sizeof(fp32), {12, 12, 64}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {10, 10, 64}},                                    // Output Data
        //     LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv5_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {64}, modelPath / "conv5_biases.bin"}             // Bias
        // );

        // // --- Conv 6: L8 ---
        // // Input shape: 10x10x64
        // // Output shape: 8x8x128
        // checkConvLayer(
        //     basePath, 7,
        //     LayerParams{sizeof(fp32), {10, 10, 64}},                                     // Input Data
        //     LayerParams{sizeof(fp32), {8, 8, 128}},                                      // Output Data
        //     LayerParams{sizeof(fp32), {3, 3, 64, 128}, modelPath / "conv6_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {128}, modelPath / "conv6_biases.bin"}             // Bias
        // );

        // // --- MPL 3: L9 ---
        // // Input shape: 8x8x128
        // // Output shape: 4x4x128
        // checkMaxPoolingLayer(
        //     basePath, 8,
        //     LayerParams{sizeof(fp32), {8, 8, 128}}, // Input
        //     LayerParams{sizeof(fp32), {4, 4, 128}}  // Output
        // );

        // // --- Flatten 1: L10 ---
        // // Input shape: 4x4x128
        // // Output shape: 2048
        // checkFlattenLayer(
        //     basePath, 9,
        //     LayerParams{sizeof(fp32), {4, 4, 128}}, // Input
        //     LayerParams{sizeof(fp32), {2048}}       // Output
        // );

        // // --- Dense 1: L11 ---
        // // Input shape: 2048
        // // Output shape: 256
        // checkDenseLayer(
        //     basePath, 10,
        //     LayerParams{sizeof(fp32), {2048}},                                        // Input
        //     LayerParams{sizeof(fp32), {256}},                                         // Output
        //     LayerParams{sizeof(fp32), {2048, 256}, modelPath / "dense1_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {256}, modelPath / "dense1_biases.bin"},        // Biases,
        //     true                                                                      // Use relu
        // );

        // // --- Dense 2: L12 ---
        // // Input shape: 256
        // // Output shape: 200
        // // --- Softmax 1: L13 ---
        // // Input shape: 200
        // // Output shape: 200
        // checkDenseWithSoftmaxLayer(
        //     basePath, 11,
        //     LayerParams{sizeof(fp32), {256}},                                        // Input
        //     LayerParams{sizeof(fp32), {200}},                                        // Output
        //     LayerParams{sizeof(fp32), {256, 200}, modelPath / "dense2_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {200}, modelPath / "dense2_biases.bin"},       // Biases
        //     basePath, 12,
        //     LayerParams{sizeof(fp32), {200}}, // Input
        //     LayerParams{sizeof(fp32), {200}}  // Output
        // );

        // // Build the model and allocate the buffers
        // Model model = buildToyModel(modelPath);
        // model.allocLayers();

        // // Run some framework tests as an example of loading data
        // runBasicTest(model, basePath);

        // // Run a layer inference test
        // runLayerTest(0, model, basePath);

        // // Run an end-to-end inference test
        // runInferenceTest(model, basePath);

        // // Run a profiling test to time the model
        // runProfilingTest(model, basePath);

        // // Clean up
        // model.freeLayers();
        std::cout << "\n\n----- ML::runTests() COMPLETE -----\n";
    }

} // namespace ML

#ifdef ZEDBOARD
extern "C" int main()
{
    try
    {
        static FATFS fatfs;
        if (f_mount(&fatfs, "/", 1) != FR_OK)
        {
            throw std::runtime_error("Failed to mount SD card. Is it plugged in?");
        }
        ML::runTests();
    }
    catch (const std::exception &e)
    {
        std::cerr << "\n\n----- EXCEPTION THROWN -----\n"
                  << e.what() << '\n';
    }
    std::cout << "\n\n----- STARTING FILE TRANSFER SERVER -----\n";
    FileServer::start_file_transfer_server();
}
#else
int main()
{
    ML::runTests();
}
#endif
