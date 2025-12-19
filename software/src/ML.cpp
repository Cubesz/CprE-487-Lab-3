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
#include "MLP.h"

#ifdef ZEDBOARD
#include <file_transfer/file_transfer.h>
#include "Acc.h"
#endif

namespace ML
{
    Model build4QModel()
    {
        Model model;

        std::cout << "Adding Layer 1: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},                                              // Input Data
            LayerParams{sizeof(i8), {60, 60, 32}},                                             // Output Data
            LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_4q.bin"}           // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32

        std::cout << "Adding Layer 2: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {60, 60, 32}},                                              // Input Data
            LayerParams{sizeof(i8), {56, 56, 32}},                                              // Output Data
            LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_4q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {28, 28, 32}},                                              // Input Data
            LayerParams{sizeof(i8), {26, 26, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_4q.bin"}            // Bias
        );

        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        std::cout << "Adding Layer 5: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {26, 26, 64}},                                              // Input Data
            LayerParams{sizeof(i8), {24, 24, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_4q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {12, 12, 64}},                                              // Input Data
            LayerParams{sizeof(i8), {10, 10, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_4q.bin"}            // Bias
        );

        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        std::cout << "Adding Layer 8: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {10, 10, 64}},                                               // Input Data
            LayerParams{sizeof(i8), {8, 8, 128}},                                                // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_4q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {2048}},                                                 // Input
            LayerParams{sizeof(i8), {256}},                                                  // Output
            LayerParams{sizeof(i8), {2048, 256}, "data/quant/param_layer_6/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {256}, "data/quant/param_layer_6/biases_4q.bin"},       // Biases,
            true);

        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200

        std::cout << "Adding Layer 12: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {256}},                                                 // Input
            LayerParams{sizeof(fp32), {200}},                                               // Output
            LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_4q.bin"}, // Weights
            LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_4q.bin"},      // Biases
            false                                                                           // Enable Relu
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

    Model build8QModel()
    {
        Model model;

        std::cout << "Adding Layer 1: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},                                              // Input Data
            LayerParams{sizeof(i8), {60, 60, 32}},                                             // Output Data
            LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"}           // Bias
        );

        // --- Conv 2: L2 ---
        // Input shape: 60x60x32
        // Output shape: 56x56x32

        std::cout << "Adding Layer 2: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {60, 60, 32}},                                              // Input Data
            LayerParams{sizeof(i8), {56, 56, 32}},                                              // Output Data
            LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_8q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {28, 28, 32}},                                              // Input Data
            LayerParams{sizeof(i8), {26, 26, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_8q.bin"}            // Bias
        );

        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        std::cout << "Adding Layer 5: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {26, 26, 64}},                                              // Input Data
            LayerParams{sizeof(i8), {24, 24, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_8q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {12, 12, 64}},                                              // Input Data
            LayerParams{sizeof(i8), {10, 10, 64}},                                              // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_8q.bin"}            // Bias
        );

        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        std::cout << "Adding Layer 8: Convolutional" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {10, 10, 64}},                                               // Input Data
            LayerParams{sizeof(i8), {8, 8, 128}},                                                // Output Data
            LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_8q.bin"}            // Bias
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
            LayerParams{sizeof(i8), {2048}},                                                 // Input
            LayerParams{sizeof(i8), {256}},                                                  // Output
            LayerParams{sizeof(i8), {2048, 256}, "data/quant/param_layer_6/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {256}, "data/quant/param_layer_6/biases_8q.bin"},       // Biases,
            true);

        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200

        std::cout << "Adding Layer 12: Dense" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {256}},                                                 // Input
            LayerParams{sizeof(fp32), {200}},                                               // Output
            LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_8q.bin"}, // Weights
            LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_8q.bin"},      // Biases
            false                                                                           // Enable Relu
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

    bool runInfTestQuant(const Model &model, Path inputPath, int actualClass, const QParams *qparams)
    {
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

        struct ClassPrediction
        {
            size_t classIdx;
            fp32 confidence;
        };
        ClassPrediction top10[10] = {0};
        for (size_t i = 0; i < output.getParams().dims[0]; i++)
        {
            fp32 confidence = output.get<fp32>(i);
            for (size_t j = 0; j < 10; j++)
            {
                if (confidence > top10[j].confidence)
                {
                    top10[j] = {i, confidence};
                    break;
                }
            }
        }

        // printf("Top10:\n");
        // for (size_t i = 0; i < 10; i++) {
        //     printf("Class: %ld, Confidence: %f\n", top10[i].classIdx, top10[i].confidence);
        // }

        return top10[0].classIdx == (size_t)actualClass;
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

        struct ClassPrediction
        {
            size_t classIdx;
            fp32 confidence;
        };
        ClassPrediction top10[10] = {0};
        for (size_t i = 0; i < output.getParams().dims[0]; i++)
        {
            fp32 confidence = output.get<fp32>(i);
            for (size_t j = 0; j < 10; j++)
            {
                if (confidence > top10[j].confidence)
                {
                    top10[j] = {i, confidence};
                    break;
                }
            }
        }

        printf("Top10:\n");
        for (size_t i = 0; i < 10; i++)
        {
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

    void inspectQuantizedLayer(const Path &basePath, const std::string &layerName, const dimVec &weightDims, const dimVec &biasDims)
    {
        printf("Inspecting quantized layer: %s", layerName.c_str());
        Path quantizedModelPath = basePath / "model" / "quantized_model_binaries";
        Path weightsPath = quantizedModelPath / (layerName + "_quantized_weights.bin");
        Path biasPath = quantizedModelPath / (layerName + "_quantized_biases.bin");

        try
        {

            // Weights:
            LayerParams qWeightsParams{sizeof(int8_t), weightDims, weightsPath};
            LayerData quantizedWeightsData(qWeightsParams);
            quantizedWeightsData.loadData();
            const int8_t *weightsPointer = static_cast<const int8_t *>(quantizedWeightsData.raw());

            printf("First 10 weights: [");
            for (int i = 0; i < 10; i++)
            {
                printf("%d", (int)weightsPointer[i]);
                if (i < 9)
                {
                    printf(", ");
                }
            }
            printf("\n");

            // Biases:
            LayerParams qBiasesParams{sizeof(int32_t), biasDims, biasPath};
            LayerData quantizedBiasesData(qBiasesParams);
            quantizedBiasesData.loadData();

            const int32_t *biasesPtr = static_cast<const int32_t *>(quantizedBiasesData.raw());

            printf("  Biases: [");
            for (size_t i = 0; i < 10; ++i)
            {
                printf("%d", (int)biasesPtr[i]);
                if (i < 9)
                {
                    printf(", ");
                }
            }
            printf("]\n\n");
        }
        catch (const std::exception &e)
        {
            printf("\n[ERROR] Failed to load or process weights or biases: %s\n", weightsPath.c_str());
            std::cerr << "  Reason: " << e.what() << '\n';
        }
    }

    void compareQuantizedData(const LayerData &actual, const LayerData &expected)
    {
        size_t mismatches = 0;
        const auto &dims = actual.getParams().dims;
        size_t elements = 1;
        for (auto d : dims)
        {
            elements *= d;
        }
        const int8_t *actual_ptr = static_cast<const int8_t *>(actual.raw());
        const int8_t *expected_ptr = static_cast<const int8_t *>(expected.raw());

        for (size_t i = 0; i < elements; ++i)
        {
            if (actual_ptr[i] != expected_ptr[i])
            {
                mismatches++;
            }
        }

        if (mismatches == 0)
        {
            printf("     - Outputs match perfectly!\n");
        }
        else
        {
            printf("     - Outputs do not match. Mismatches: %zu / %zu (%.2f%%)\n",
                   mismatches, elements, (double)mismatches / elements * 100.0);
        }
    }

    void checkLayerAccelerated(
        const Path &basePath,
        const std::string &layerName,
        const LayerParams &inParams,
        const LayerParams &outParams,
        const LayerParams &weightParams,
        const LayerParams &biasParams)
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
        const LayerData &actual_output = layer.getOutputData();
        Path expected_output_path = quantizedModelPath / ("quantized_" + layerName + "_output.bin");
        LayerData expected_output(outParams, expected_output_path);
        expected_output.loadData();

        // Compare results
        log("Comparing C++ hardware output against Python quantized output...");
        compareQuantizedData(actual_output, expected_output);

        layer.freeLayer();
    }

    void checkDenseLayerAccelerated(
        const Path &basePath,
        const std::string &layerName,
        const LayerParams &inParams,
        const LayerParams &outParams,
        const LayerParams &weightParams,
        const LayerParams &biasParams,
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
        const LayerData &actual_output = layer.getOutputData();
        Path expected_output_path = quantizedModelPath / ("quantized_" + layerName + "_output.bin");
        LayerData expected_output(outParams, expected_output_path);
        expected_output.loadData();

        // Compare results
        log("Comparing C++ hardware output against Python quantized output...");
        compareQuantizedData(actual_output, expected_output);

        layer.freeLayer();
    }

    void profileFp32Model(const Model &model, const Path &basePath, int numInferences)
    {
        logInfo("--- Running FP32 Multi-Inference Profiling Test ---");

        if (numInferences < 1)
        {
            printf("Error: Number of inferences must be at least 1.");
            return;
        }

        // Vector to accumulate the total time for each layer over all inferences.
        std::vector<double> totalLayerMilliseconds(model.getNumLayers(), 0.0);

        // Get the input parameters from the model's first layer to correctly load images.
        const LayerParams &inputParams = model[0].getInputParams();

        std::cout << "Starting profiling for " << numInferences << " inferences..." << std::endl;

        // Main loop to run inference N times.
        for (int i = 0; i < numInferences; ++i)
        {
            // Construct the path to the current float32 image file.
            Path imagePath = basePath / "unquant" / "images_1000_fp32" / (std::to_string(i) + ".bin");
            LayerData img(inputParams, imagePath);
            img.loadData();

            const LayerData *currentData = &img;

            // Loop through each layer of the model and time its inference.
            for (size_t layerIdx = 0; layerIdx < model.getNumLayers(); ++layerIdx)
            {
                Timer layerTimer("Layer_" + std::to_string(layerIdx)); // temporary timer
                layerTimer.start();
                currentData = &model.inferenceLayer(*currentData, layerIdx, Layer::InfType::NAIVE);
                layerTimer.stop();
                totalLayerMilliseconds[layerIdx] += layerTimer.milliseconds;
            }

            // Print progress
            if ((i + 1) % 10 == 0 || (i + 1) == numInferences)
            {
                std::cout << "  ...completed " << (i + 1) << "/" << numInferences << " inferences." << std::endl;
            }
        }

        logInfo("--- FP32 Profiling Results ---");

        double totalAverageTimeMs = 0.0;

        std::cout << "\n--- Average Individual Layer Times (" << numInferences << " inferences) ---\n";

        for (size_t i = 0; i < totalLayerMilliseconds.size(); ++i)
        {
            // Calculate the average time in milliseconds.
            double avgMilliseconds = totalLayerMilliseconds[i] / numInferences;
            totalAverageTimeMs += avgMilliseconds;

            std::cout << "Layer " << i << ": " << avgMilliseconds << " ms" << std::endl;
        }

        std::cout << "\nTotal Average Inference Time: " << totalAverageTimeMs << " ms ("
                  << totalAverageTimeMs / 1000.0 << " s)\n"
                  << std::endl;
    }

#include <fstream> // Required for std::ifstream

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
            LayerParams{sizeof(int32_t), {32}, quantizedModelPath / "conv2d_quantized_biases.bin"});

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
        Path basePath("data"); // May need to be altered for zedboards loading from SD Cards
        Path modelPath = basePath / "model";

        // ConvolutionalLayer layer(LayerParams{sizeof(i8), {64,64,3}}, LayerParams{sizeof(i8), {60, 60, 32}}, LayerParams{sizeof(i8), {5, 5, 3, 32}, "quant/param_layer_0/weights_8q.bin"}, LayerParams{sizeof(i16), {32}, "quant/param_layer_0/biases_8q.bin"});
        // layer.allocLayer();

        Path input_file_path = "data/quant/given_image0_8q.bin";
        LayerData inputData(LayerParams{sizeof(i8), {64, 64, 3}}, input_file_path);
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
        // Model model4q = build4QModel();
        // model4q.allocLayers();
        // // std::string expected_output_filename = "layer_" + std::to_string(11) + "_output.bin";
        // // runInfTestQuant(model8q, "quant/given_image0_8q.bin", 163, modelQParams_8q);
        // size_t imageIdx;
        // int successes = 0;
        // for (imageIdx = 0; imageIdx < 1000; imageIdx++) {
        //     // bool predictedAccurately = runInfTestQuant(model8q, "data/quant/images_1000_8b/" + std::to_string(imageIdx) + ".bin", images_8q_classes[imageIdx], modelQParams_8q);
        //     bool predictedAccurately = runInfTestQuant(model4q, "data/quant/images_1000_4b/" + std::to_string(imageIdx) + ".bin", images_4q_classes[imageIdx], modelQParams_4q);
        //     if (predictedAccurately)
        //         successes += 1;
        // }
        // fp32 accuracy = ((float) successes) / 1000.0f;
        // std::cout << "4q accuracy: " << std::endl;
        // std::cout << accuracy << std::endl;
        // model4q.freeLayers();
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
        // )
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
        Model model = buildToyModel(modelPath);
        model.allocLayers();

        // // Run some framework tests as an example of loading data
        // runBasicTest(model, basePath);

        // // Run a layer inference test
        runLayerTest(0, model, basePath);

        // // Run an end-to-end inference test
        // runInferenceTest(model, basePath);

        // // Run a profiling test to time the model
        runProfilingTest(model, basePath);

        int numInferences = 100;
        profileFp32Model(model, basePath, numInferences);

        // Clean up
        model.freeLayers();
        std::cout << "\n\n----- ML::runTests() COMPLETE -----\n";
    }

    void smallRun()
    {
#ifdef ZEDBOARD
        int8_t inputs[2][3][4] = {
            {
                {127, -1, -128, 4},
                {5, 6, 7, 8},
                {9, 10, 11, 12},
            },
            {
                {13, 14, 15, 16},
                {17, 18, 19, 0},
                {21, 3, 2, 1},
            }};

        int8_t filters[4][2][2][3] = {
            {
                {
                    {127, -1, -128},
                    {4, 5, 6},
                },
                {
                    {7, 8, 9},
                    {10, 11, 12},
                },
            },
            {
                {
                    {-13, -14, -15},
                    {-16, -17, -18},
                },
                {
                    {-19, -20, -21},
                    {-22, -23, -24},
                },
            },
            {
                {
                    {25, 26, 27},
                    {28, 29, 30},
                },
                {
                    {31, 32, 33},
                    {34, 35, 36},
                },
            },
            {
                {
                    {37, 38, 39},
                    {40, 41, 42},
                },
                {
                    {43, 44, 45},
                    {46, 47, 48},
                },
            }

        };

        int32_t biases[] = {0, 1, 2, 3};
        uint32_t qscale = 0x04000000;
        uint32_t qzero = 0;

        Xil_Out32(MLP_CTRLB, 0); // Whatever filters you dma are going to the filters not in use
        // so, invert after when applicable
        memcpy_dma(MLP_INPUTS, inputs, sizeof(inputs));
        memcpy_dma(MLP_FILTER0, filters[0], sizeof(filters[0]));
        memcpy_dma(MLP_FILTER1, filters[1], sizeof(filters[1]));
        memcpy_dma(MLP_FILTER2, filters[2], sizeof(filters[2]));
        memcpy_dma(MLP_FILTER3, filters[3], sizeof(filters[3]));
        Xil_Out32(MLP_CTRLB, 1);

        Xil_Out32(MLP_FILTER_W, 3);
        Xil_Out32(MLP_FILTER_H, 2);
        Xil_Out32(MLP_FILTER_C, 2);
        Xil_Out32(MLP_OUTPUT_W, 2);
        Xil_Out32(MLP_OUTPUT_H, 2);
        Xil_Out32(MLP_INPUT_END_DIFF_FW, 2);
        Xil_Out32(MLP_INPUT_END_DIFF_FH, 6);
        Xil_Out32(MLP_INPUT_END_DIFF_FC, -17);
        Xil_Out32(MLP_INPUT_END_DIFF_OW, -15);
        Xil_Out32(MLP_OUTPUT_ELEMENTS_PER_CHANNEL, 4);
        Xil_Out32(MLP_OUTPUT_INITIAL_OFFSET, 0);
        Xil_Out32(MLP_MAC0_BIAS, biases[0]);
        Xil_Out32(MLP_MAC1_BIAS, biases[1]);
        Xil_Out32(MLP_MAC2_BIAS, biases[2]);
        Xil_Out32(MLP_MAC3_BIAS, biases[3]);
        Xil_Out32(MLP_Q_SCALE, qscale);
        Xil_Out32(MLP_Q_ZERO, qzero);

        Xil_Out32(MLP_CTRLA, 0);

        while (!(Xil_In32(MLP_CTRLA) & MLP_CTRLA_CONV_IDLE))
        {
            std::cout << "not idle..." << std::endl;
        }

        int8_t outputs[4][2][2] = {0};

        memcpy_dma(outputs, MLP_OUTPUTS, sizeof(outputs));

        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 2; j++)
            {
                std::cout << static_cast<int>(outputs[i][j][0]) << ", " << static_cast<int>(outputs[i][j][1]) << std::endl;
            }
        }
#endif
    }

    uint32_t runAccLayer(AccelParams ap, const int8_t* weights, const int16_t* biases, int nOutputChannels, uint32_t preflags) {
        #define ZEDBOARD
        #ifdef ZEDBOARD

        uint32_t ctrlb_flags = preflags; // maintain given activations orientation
        ctrlb_flags = ap.relu ? ctrlb_flags | MLP_CTRLB_RELU : ctrlb_flags & ~MLP_CTRLB_RELU;
        ctrlb_flags = ap.maxpool ? ctrlb_flags | MLP_CTRLB_MAX_POOLING : ctrlb_flags & ~MLP_CTRLB_MAX_POOLING;
        Xil_Out32(MLP_CTRLB, ctrlb_flags);

        int8_t* filterDataPtr = (int8_t*) weights;
        memcpy_dma(MLP_FILTER0, filterDataPtr, ap.single_filter_size);
        filterDataPtr += ap.single_filter_size;

        memcpy_dma(MLP_FILTER1, filterDataPtr, ap.single_filter_size);
        filterDataPtr += ap.single_filter_size;

        memcpy_dma(MLP_FILTER2, filterDataPtr, ap.single_filter_size);
        filterDataPtr += ap.single_filter_size;

        memcpy_dma(MLP_FILTER3, filterDataPtr, ap.single_filter_size);
        filterDataPtr += ap.single_filter_size;

        // Register Config
        ctrlb_flags ^= MLP_CTRLB_SWAP_FILTERS;
        Xil_Out32(MLP_CTRLB, ctrlb_flags);
        Xil_Out32(MLP_FILTER_W, ap.filter_w);
        Xil_Out32(MLP_FILTER_H, ap.filter_h);
        Xil_Out32(MLP_FILTER_C, ap.filter_c);
        Xil_Out32(MLP_OUTPUT_W, ap.output_w);
        Xil_Out32(MLP_OUTPUT_H, ap.output_h);
        Xil_Out32(MLP_INPUT_END_DIFF_FW, ap.inp_diff_fw);
        Xil_Out32(MLP_INPUT_END_DIFF_FH, ap.inp_diff_fh);
        Xil_Out32(MLP_INPUT_END_DIFF_FC, ap.inp_diff_fc);
        Xil_Out32(MLP_INPUT_END_DIFF_OW, ap.inp_diff_ow);
        Xil_Out32(MLP_OUTPUT_ELEMENTS_PER_CHANNEL, ap.output_elements_per_channel);

        // Scale
        Xil_Out32(MLP_Q_SCALE, ap.q_scale_fx_pnt);
        Xil_Out32(MLP_Q_ZERO, ap.q_zero);

        // In batches of 4
        int outputOffset = 0;
        
        for (int i = 0; i < nOutputChannels; i += 4) {
            Xil_Out32(MLP_OUTPUT_INITIAL_OFFSET, outputOffset);
            outputOffset += 4 * ap.output_elements_per_channel;

            Xil_Out32(MLP_MAC0_BIAS, int(biases[i]) - ap.zp_macced[i]);
            Xil_Out32(MLP_MAC1_BIAS, int(biases[i + 1]) - ap.zp_macced[i + 1]);
            Xil_Out32(MLP_MAC2_BIAS, int(biases[i + 2]) - ap.zp_macced[i + 2]);
            Xil_Out32(MLP_MAC3_BIAS, int(biases[i + 3]) - ap.zp_macced[i + 3]);

            Xil_Out32(MLP_CTRLA, 0); // start
            // as it goes, load upcoming filters

            if (i < (nOutputChannels - 4))
            {
                memcpy_dma(MLP_FILTER0, filterDataPtr, ap.single_filter_size);
                filterDataPtr += ap.single_filter_size;
                memcpy_dma(MLP_FILTER1, filterDataPtr, ap.single_filter_size);
                filterDataPtr += ap.single_filter_size;
                memcpy_dma(MLP_FILTER2, filterDataPtr, ap.single_filter_size);
                filterDataPtr += ap.single_filter_size;
                memcpy_dma(MLP_FILTER3, filterDataPtr, ap.single_filter_size);
                filterDataPtr += ap.single_filter_size;
            }

            while (!(Xil_In32(MLP_CTRLA) & MLP_CTRLA_CONV_IDLE)); // wait for it to finish
            ctrlb_flags ^= MLP_CTRLB_SWAP_FILTERS;
            Xil_Out32(MLP_CTRLB, ctrlb_flags);
        }



        #endif
        return 0;
    }

    void lab6Inference(const LayerData& input, fp32* inference_result = 0) {
        static int first = 0;

        // Convolution layer 1
        static LayerData layer1W = LayerData{LayerParams{sizeof(i8), {32, 3, 5, 5}}, "data/quant_t_new/layer0_weights_8q_t_new.bin"};
        static LayerData layer1B = LayerData{LayerParams{sizeof(i16), {32}}, "data/quant/param_layer_0/biases_8q.bin"};
        if (first == 0) {
            layer1W.loadData();
            layer1B.loadData();
        }

        // Convolution layer 2 with max pooling
        static LayerData layer2W = LayerData{LayerParams{sizeof(i8), {32, 32, 5, 5}}, "data/quant_t_new/layer1_weights_8q_t_new.bin"};
        static LayerData layer2B = LayerData{LayerParams{sizeof(i16), {32}}, "data/quant/param_layer_1/biases_8q.bin"};
        if (first == 0) {
        layer2W.loadData();
        layer2B.loadData();
        }

        // Convolution layer 3
        static LayerData layer3W = LayerData{LayerParams{sizeof(i8), {64, 32, 3, 3}}, "data/quant_t_new/layer2_weights_8q_t_new.bin"};
        static LayerData layer3B = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_2/biases_8q.bin"};
        if (first == 0) {
        layer3W.loadData();
        layer3B.loadData();
        }

        // Convolution layer 4 with max pooling
        static LayerData layer4W = LayerData{LayerParams{sizeof(i8), {64, 64, 3, 3}}, "data/quant_t_new/layer3_weights_8q_t_new.bin"};
        static LayerData layer4B = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_3/biases_8q.bin"};
        if (first == 0) {
        layer4W.loadData();
        layer4B.loadData();
        }

        // Convolution layer 5
        static LayerData layer5W = LayerData{LayerParams{sizeof(i8), {64, 64, 3, 3}}, "data/quant_t_new/layer4_weights_8q_t_new.bin"};
        static LayerData layer5B = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_4/biases_8q.bin"};
        if (first == 0) {
        layer5W.loadData();
        layer5B.loadData();
        }

        // Convolution layer 6 with max pooling
        static LayerData layer6W = LayerData{LayerParams{sizeof(i8), {128, 64, 3, 3}}, "data/quant_t_new/layer5_weights_8q_t_new.bin"};
        static LayerData layer6B = LayerData{LayerParams{sizeof(i16), {128}}, "data/quant/param_layer_5/biases_8q.bin"};
        if (first == 0) {
        layer6W.loadData();
        layer6B.loadData();
        }

        // Convolution/Dense layer 7
        static LayerData layer7W = LayerData{LayerParams{sizeof(i8), {256, 128, 4, 4}}, "data/quant_t_new/layer6_dense_weights_8q_t_new.bin"};
        static LayerData layer7B = LayerData{LayerParams{sizeof(i16), {256}}, "data/quant/param_layer_6/biases_8q.bin"};
        if (first == 0) {
        layer7W.loadData();
        layer7B.loadData();
        }

        // Convolution/Dense layer 8
        static LayerData layer8W = LayerData{LayerParams{sizeof(i8), {200, 256, 1, 1}}, "data/quant_t_new/layer7_dense_weights_8q_t_new.bin"};
        static LayerData layer8B = LayerData{LayerParams{sizeof(i16), {200}}, "data/quant/param_layer_7/biases_8q.bin"};
        if (first == 0) {
        layer8W.loadData();
        layer8B.loadData();
        }

        i8 lastDenseOut[200];
        LayerData lastDenseUnscaled = LayerData{LayerParams{sizeof(fp32), {200}}};
        lastDenseUnscaled.allocData();

        Model softmaxModel;
        softmaxModel.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );
        softmaxModel.allocLayers();

        Timer tmr("Timer");
        // tmr.start();

        // Convolution layer 1
        uint32_t ctrlb_flags = 0;
        Xil_Out32(MLP_CTRLB, 0);
        memcpy_dma(MLP_INPUTS, input.raw(), aplayer0.input_size);

        runAccLayer(aplayer0, (int8_t*) layer1W.raw(), (int16_t*) layer1B.raw(), 32, ctrlb_flags);

        // Convolution layer 2 with max pooling
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer1, (int8_t*) layer2W.raw(), (int16_t*) layer2B.raw(), 32, ctrlb_flags);

        
        // Convolution layer 3
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer2, (int8_t*) layer3W.raw(), (int16_t*) layer3B.raw(), 64, ctrlb_flags);

        // Convolution layer 4 with max pooling
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer3, (int8_t*) layer4W.raw(), (int16_t*) layer4B.raw(), 64, ctrlb_flags);

        // Convolution layer 5
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer4, (int8_t*) layer5W.raw(), (int16_t*) layer5B.raw(), 64, ctrlb_flags);

        // Convolution layer 6 with max pooling
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer5, (int8_t*) layer6W.raw(), (int16_t*) layer6B.raw(), 128, ctrlb_flags);

        // Convolution/Dense layer 7
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer6, (int8_t*) layer7W.raw(), (int16_t*) layer7B.raw(), 256, ctrlb_flags);

        // Convolution/Dense layer 8
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer7, (int8_t*) layer8W.raw(), (int16_t*) layer8B.raw(), 200, ctrlb_flags);


        memcpy_dma(lastDenseOut, MLP_OUTPUTS, 200);
        for (int i = 0; i < 200; i++) {
            lastDenseUnscaled.get<fp32>(i) = float(lastDenseOut[i]) / 8.0f;
        }

        const LayerData& inference = softmaxModel.inferenceLayer(lastDenseUnscaled, 0, Layer::InfType::QUANTIZED);

        // tmr.stop();

        if (inference_result != 0) {
            memcpy(inference_result, inference.raw(), sizeof(fp32) * 200);
        }
        
        // for (int i = 0; i < 200; i++) {
        //     std::cout << inference.get<fp32>(i) << std::endl;
        // }



        softmaxModel.freeLayers();

        lastDenseUnscaled.freeData();

        // layer8W.freeData();
        // layer8B.freeData();

        // layer7W.freeData();
        // layer7B.freeData();

        // layer6W.freeData();
        // layer6B.freeData();

        // layer5W.freeData();
        // layer5B.freeData();

        // layer4W.freeData();
        // layer4B.freeData();

        // layer3W.freeData();
        // layer3B.freeData();

        // layer2W.freeData();
        // layer2B.freeData();

        // layer1W.freeData();
        // layer1B.freeData();
        first = 1;
    }

    void lab6Stuff()
    {
#define ZEDBOARD
#ifdef ZEDBOARD

        // WEIGHTS MUST BE FILTER x LAYERS x HEIGHT x WIDTH
        // INPUTS MUST BE LAYERS x HEIGHT x WIDTH

        // Layer 1
        LayerData ly0id = LayerData{LayerParams{sizeof(i8), {3, 64, 64}}, "data/quant_t_new/given_image0_8q_t_new.bin"};
        LayerData ly0wd = LayerData{LayerParams{sizeof(i8), {32, 3, 5, 5}}, "data/quant_t_new/layer0_weights_8q_t_new.bin"};
        LayerData ly0bd = LayerData{LayerParams{sizeof(i16), {32}}, "data/quant/param_layer_0/biases_8q.bin"};
        ly0id.loadData(); // first layer only
        ly0wd.loadData();
        ly0bd.loadData();

        lab6Inference(ly0id);

        int corrects = 0;
        for (int imgIdx = 0; imgIdx < 1000; imgIdx++) {
            LayerData inputImage = LayerData{LayerParams{sizeof(i8), {3, 64, 64}}, "data/quant_t_new/images_1000_8b_t_new/" + std::to_string(imgIdx) + "_t_new.bin"};
            inputImage.loadData();
            fp32 inference[200];
            lab6Inference(inputImage, inference);

            int correctClass = images_8q_classes[imgIdx];
            
            int maxIdx = 0;
            fp32 maxNum = 0;
            for (int i = 0; i < 200; i++) {
                if (inference[i] > maxNum) {
                    maxNum = inference[i];
                    maxIdx = i;
                }
            }

            if (correctClass == maxIdx) {
                std::cout << "correct" << std::endl;
                corrects++;
            }

            inputImage.freeData();
        }

        std::cout << "Top 1 accuracy: " << corrects << "/1000: " << float(corrects) / 1000.0f << std::endl;

        return;

        printf("Running Layer 1 (64x64x3 -> 60x60x32)...\n");

        // layer initialization
        uint32_t ctrlb_flags = 0;
        Xil_Out32(MLP_CTRLB, 0);
        memcpy_dma(MLP_INPUTS, ly0id.raw(), aplayer0.input_size);

        Timer tmr("inf");
        tmr.start();
        runAccLayer(aplayer0, (int8_t*) ly0wd.raw(), (int16_t*) ly0bd.raw(), 32, 0);

        ly0bd.freeData(); // maybe do later
        ly0wd.freeData();

        printf("Comparing Hardware Output vs Software Reference...\n");

        // Get Hardware Output
        // std::vector<int8_t> hw_out_l1(32 * 60 * 60);
        // memcpy_dma(hw_out_l1.data(), MLP_OUTPUTS, 32 * 60 * 60);

        // std::cout << "[";
        // int cnt = 0;
        // for (int i = 0; i < 32; i++) {
        //     std::cout << "[";
        //     for (int j = 0; j < 60; j++) {
        //         std::cout << "[";
        //         for (int k = 0; k < 60; k++) {
        //             if (k != 0)
        //                 std::cout << ",";

        //             std::cout << static_cast<int>(hw_out_l1[cnt++]);
        //         }
        //         std::cout << "]";
        //     }
        //     std::cout << "]";
        // }
        // std::cout << "]" << std::endl;

        // Run Software Layer 1
        // Model model_l1;
        // std::cout << "Adding Layer 1: Convolutional" << std::endl;

        // model_l1.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {64, 64, 3}},
        //     LayerParams{sizeof(i8), {60, 60, 32}},
        //     LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_8q.bin"},
        //     LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"});
        // model_l1.allocLayers();

        // LayerData inp_sw = LayerData{LayerParams{sizeof(i8), {64, 64, 3}}, "data/quant/given_image0_8q.bin"};
        // inp_sw.loadData();
        // const LayerData &l1_out_sw = model_l1.inferenceLayer(inp_sw, 0, Layer::InfType::QUANTIZED, modelQParams_8q[0]);

        // // Compare each pixel
        // int mismatches = 0;
        // int diff_of_one = 0;
        // int print_limit = 10;

        // for (int ch = 0; ch < 32; ch++)
        // {
        //     for (int r = 0; r < 60; r++)
        //     {
        //         for (int c = 0; c < 60; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l1[(ch * 60 * 60) + (r * 60) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l1_out_sw.get<i8>((r * 60 * 32) + (c * 32) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 32 * 60 * 60);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }


        // inp_sw.freeData();
        // model_l1.freeLayers();

        // std::cout << "stop" << std::endl;
        // for (int i = 0; i < 30000000; i++) {
        //     Xil_Out32(MLP_CTRLB, i);
        // }
        // std::cout << "begin" << std::endl;


        // Layer 2
        LayerData ly1wd = LayerData{LayerParams{sizeof(i8), {32, 32, 5, 5}}, "data/quant_t_new/layer1_weights_8q_t_new.bin"};
        LayerData ly1bd = LayerData{LayerParams{sizeof(i16), {32}}, "data/quant/param_layer_1/biases_8q.bin"};
        ly1wd.loadData();
        ly1bd.loadData();

        // printf("Running Layer 2 (with max pooling) (60x60x32-> 28x28x32)...\n");

        // layer initialization
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer1, (int8_t*) ly1wd.raw(), (int16_t*) ly1bd.raw(), 32, ctrlb_flags);

        ly1bd.freeData(); // maybe do later
        ly1wd.freeData();

        // printf("Comparing Hardware Output vs Software Reference...\n");

        // Get Hardware Output
        // std::vector<int8_t> hw_out_l2(32 * 28 * 28);
        // memcpy_dma(hw_out_l2.data(), MLP_OUTPUTS, 32 * 28 * 28);

        // Run Software Layer 2
        // Model model_l2;

        // model_l2.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {60, 60, 32}},
        //     LayerParams{sizeof(i8), {56, 56, 32}},
        //     LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_8q.bin"},
        //     LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_8q.bin"});
        // model_l2.addLayer<MaxPoolingLayer>(
        //     LayerParams{sizeof(i8), {56, 56, 32}}, // Input
        //     LayerParams{sizeof(i8), {28, 28, 32}}  // Output
        // );
        
        // model_l2.allocLayers();


        // const LayerData &l2_out_sw_out = model_l2.inference(inp_sw_again, Layer::InfType::QUANTIZED, modelQParams_8q);
        // const LayerData &l2_out_sw_out = model_l2.inferenceLayer(l1_out_sw, 0, Layer::InfType::QUANTIZED, modelQParams_8q[1]);
        // const LayerData &l2_out_sw_out = model_l2.inference(l1_out_sw, Layer::InfType::QUANTIZED, (modelQParams_8q+1));

        // Compare each pixel
        // mismatches = 0;
        // diff_of_one = 0;
        // print_limit = 10;
        // bool channel_errs[64] = {0};

        // for (int ch = 0; ch < 32; ch++)
        // {
        //     for (int r = 0; r < 28; r++)
        //     {
        //         for (int c = 0; c < 28; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l2[(ch * 28 * 28) + (r * 28) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l2_out_sw_out.get<i8>((r * 28 * 32) + (c * 32) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 channel_errs[ch] = true;
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // for (int i = 0; i < 32; i++) {
        //     if (channel_errs[i])
        //         std::cout << "Error in channel: " << i << std::endl;
        // }
        // channel_errs[64] = {0};

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 32 * 56 * 56);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }


        // model_l1.freeLayers();

        LayerData ly2wd = LayerData{LayerParams{sizeof(i8), {64, 32, 3, 3}}, "data/quant_t_new/layer2_weights_8q_t_new.bin"};
        LayerData ly2bd = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_2/biases_8q.bin"};
        ly2wd.loadData();
        ly2bd.loadData();

        // printf("Running layer 3 (28x28x32 -> 26x26x64)...\n");
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer2, (int8_t*) ly2wd.raw(), (int16_t*) ly2bd.raw(), 64, ctrlb_flags);

        ly2wd.freeData();
        ly2bd.freeData();


        // printf("Comparing Hardware Output vs Software Reference...\n");

        // Get Hardware Output
        // std::vector<int8_t> hw_out_l3(64 * 26 * 26);
        // memcpy_dma(hw_out_l3.data(), MLP_OUTPUTS, 64 * 26 * 26);

        // Run Software Layer 2
        // Model moodel;

        // moodel.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {64, 64, 3}},                                              // Input Data
        //     LayerParams{sizeof(i8), {60, 60, 32}},                                             // Output Data
        //     LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"}           // Bias
        // );

        // moodel.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {60, 60, 32}},                                              // Input Data
        //     LayerParams{sizeof(i8), {56, 56, 32}},                                              // Output Data
        //     LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_8q.bin"}            // Bias
        // );

        // moodel.addLayer<MaxPoolingLayer>(
        //     LayerParams{sizeof(i8), {56, 56, 32}}, // Input
        //     LayerParams{sizeof(i8), {28, 28, 32}}  // Output
        // );

        // moodel.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {28, 28, 32}},                                              // Input Data
        //     LayerParams{sizeof(i8), {26, 26, 64}},                                              // Output Data
        //     LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_8q.bin"}            // Bias
        // );
        // moodel.allocLayers();

        // const LayerData &l3_out_sw_out = moodel.inference(inp_sw, Layer::InfType::QUANTIZED, modelQParams_8q);

        // const LayerData &l2_out_sw_out = model_l2.inference(inp_sw_again, Layer::InfType::QUANTIZED, modelQParams_8q);
        // const LayerData &l3_out_sw_out = model_l3.inferenceLayer(l2_out_sw_out, 0, Layer::InfType::QUANTIZED, modelQParams_8q[3]);



        // Compare each pixel
        // mismatches = 0;
        // diff_of_one = 0;
        // print_limit = 10;

        // for (int ch = 0; ch < 64; ch++)
        // {
        //     for (int r = 0; r < 26; r++)
        //     {
        //         for (int c = 0; c < 26; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l3[(ch * 26 * 26) + (r * 26) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l3_out_sw_out.get<i8>((r * 26 * 64) + (c * 64) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 channel_errs[ch] = true;
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // for (int i = 0; i < 64; i++) {
        //     if (channel_errs[i])
        //         std::cout << "Error in channel: " << i << std::endl;
        // }

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 64 * 26 * 26);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }

        LayerData ly3wd = LayerData{LayerParams{sizeof(i8), {64, 64, 3, 3}}, "data/quant_t_new/layer3_weights_8q_t_new.bin"};
        LayerData ly3bd = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_3/biases_8q.bin"};
        ly3wd.loadData();
        ly3bd.loadData();

        // printf("Running layer 4 (with max pooling) (26x26x64 -> 12x12x64)...\n");
        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer3, (int8_t*) ly3wd.raw(), (int16_t*) ly3bd.raw(), 64, ctrlb_flags);

        ly3wd.freeData();
        ly3bd.freeData();


        // printf("Comparing Hardware Output vs Software Reference...\n");

        // Get Hardware Output
        // std::vector<int8_t> hw_out_l4(64 * 12 * 12);
        // memcpy_dma(hw_out_l4.data(), MLP_OUTPUTS, 64 * 12 * 12);

        // Model amodel;

        // amodel.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {26, 26, 64}},                                              // Input Data
        //     LayerParams{sizeof(i8), {24, 24, 64}},                                              // Output Data
        //     LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_8q.bin"}            // Bias
        // );

        // amodel.addLayer<MaxPoolingLayer>(
        //     LayerParams{sizeof(i8), {24, 24, 64}}, // Input
        //     LayerParams{sizeof(i8), {12, 12, 64}}  // Output
        // );
        // amodel.allocLayers();

        // const LayerData &l4_out_sw_out = amodel.inference(l3_out_sw_out, Layer::InfType::QUANTIZED, modelQParams_8q + 4);

        // const LayerData &l2_out_sw_out = model_l2.inference(inp_sw_again, Layer::InfType::QUANTIZED, modelQParams_8q);
        // const LayerData &l3_out_sw_out = model_l3.inferenceLayer(l2_out_sw_out, 0, Layer::InfType::QUANTIZED, modelQParams_8q[3]);



        // Compare each pixel
        // mismatches = 0;
        // diff_of_one = 0;
        // print_limit = 10;

        // for (int ch = 0; ch < 64; ch++)
        // {
        //     for (int r = 0; r < 12; r++)
        //     {
        //         for (int c = 0; c < 12; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l4[(ch * 12 * 12) + (r * 12) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l4_out_sw_out.get<i8>((r * 12 * 64) + (c * 64) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 channel_errs[ch] = true;
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 64 * 12 * 12);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }


        // printf("Running layer 5 (12x12x64 -> 10x10x64)...\n");
        LayerData ly4wd = LayerData{LayerParams{sizeof(i8), {64, 64, 3, 3}}, "data/quant_t_new/layer4_weights_8q_t_new.bin"};
        LayerData ly4bd = LayerData{LayerParams{sizeof(i16), {64}}, "data/quant/param_layer_4/biases_8q.bin"};
        ly4wd.loadData();
        ly4bd.loadData();

        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer4, (int8_t*) ly4wd.raw(), (int16_t*) ly4bd.raw(), 64, ctrlb_flags);

        ly4wd.freeData();
        ly4bd.freeData();

        // printf("Running layer 6 (10x10x64 -> 4x4x128)...\n");

        LayerData ly5wd = LayerData{LayerParams{sizeof(i8), {128, 64, 3, 3}}, "data/quant_t_new/layer5_weights_8q_t_new.bin"};
        LayerData ly5bd = LayerData{LayerParams{sizeof(i16), {128}}, "data/quant/param_layer_5/biases_8q.bin"};
        ly5wd.loadData();
        ly5bd.loadData();

        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer5, (int8_t*) ly5wd.raw(), (int16_t*) ly5bd.raw(), 128, ctrlb_flags);

        std::vector<int8_t> hw_out_l6(128 * 4 * 4);
        memcpy_dma(hw_out_l6.data(), MLP_OUTPUTS, 128 * 4 * 4);

        ly5wd.freeData();
        ly5bd.freeData();

        // Model anotherM;
        // anotherM.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {12, 12, 64}},                                              // Input Data
        //     LayerParams{sizeof(i8), {10, 10, 64}},                                              // Output Data
        //     LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_8q.bin"}            // Bias
        // );

        // anotherM.addLayer<ConvolutionalLayer>(
        //     LayerParams{sizeof(i8), {10, 10, 64}},                                               // Input Data
        //     LayerParams{sizeof(i8), {8, 8, 128}},                                                // Output Data
        //     LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_8q.bin"}            // Bias
        // );

        // anotherM.addLayer<MaxPoolingLayer>(
        //     LayerParams{sizeof(i8), {8, 8, 128}}, // Input
        //     LayerParams{sizeof(i8), {4, 4, 128}}  // Output
        // );

        // anotherM.allocLayers();

        // const LayerData &l6_out_sw_out = anotherM.inference(l4_out_sw_out, Layer::InfType::QUANTIZED, modelQParams_8q + 6);


        // Compare each pixel
        // mismatches = 0;
        // diff_of_one = 0;
        // print_limit = 10;

        // for (int ch = 0; ch < 128; ch++)
        // {
        //     for (int r = 0; r < 4; r++)
        //     {
        //         for (int c = 0; c < 4; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l6[(ch * 4 * 4) + (r * 4) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l6_out_sw_out.get<i8>((r * 4 * 128) + (c * 128) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 channel_errs[ch] = true;
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 128 * 4 * 4);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }


        // printf("Running layer 7 (Dense) (4x4x128 -> 1x1x256)...\n");

        LayerData ly6wd = LayerData{LayerParams{sizeof(i8), {256, 128, 4, 4}}, "data/quant_t_new/layer6_dense_weights_8q_t_new.bin"};
        LayerData ly6bd = LayerData{LayerParams{sizeof(i16), {256}}, "data/quant/param_layer_6/biases_8q.bin"};
        ly6wd.loadData();
        ly6bd.loadData();

        // LayerData weighttest = LayerData{LayerParams{sizeof(i8), {4, 4, 128, 256}}, "data/quant/param_layer_6/weights_8q.bin"};
        // weighttest.loadData();


        // for (int filt = 0; filt < 256; filt++) {
        //     for (int chan = 0; chan < 128; chan++) {
        //         for (int row = 0; row < 4; row++) {
        //             for (int col = 0; col < 4; col++) {
        //                 int w0 = int(weighttest.get<i8>(row * 4 * 128 * 256 + col * 128 * 256 + chan * 256 + filt));
        //                 int w1 = int(ly6wd.get<i8>(filt * 128 * 4 * 4 + chan * 4 * 4 + row * 4 + col));
        //                 if (w0 != w1)
        //                     std::cout << "mismatch" << std::endl;
        //             }
        //         }
        //     }
        // }

        // weighttest.freeData();


        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer6, (int8_t*) ly6wd.raw(), (int16_t*) ly6bd.raw(), 256, ctrlb_flags);

        std::vector<int8_t> hw_out_l7(256);
        memcpy_dma(hw_out_l7.data(), MLP_OUTPUTS, 256);

        ly6wd.freeData();
        ly6bd.freeData();

        // Model d1Model;
        // d1Model.addLayer<FlattenLayer>(
        //     LayerParams{sizeof(i8), {4, 4, 128}}, // Input
        //     LayerParams{sizeof(i8), {2048}}       // Output
        // );
        // d1Model.addLayer<DenseLayer>(
        //     LayerParams{sizeof(i8), {2048}},                                                 // Input
        //     LayerParams{sizeof(i8), {256}},                                                  // Output
        //     LayerParams{sizeof(i8), {2048, 256}, "data/quant/param_layer_6/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {256}, "data/quant/param_layer_6/biases_8q.bin"},       // Biases,
        //     true);

        // d1Model.allocLayers();

        // const LayerData &l7_out_sw_out = d1Model.inference(l6_out_sw_out, Layer::InfType::QUANTIZED, modelQParams_8q + 9);



        // Compare each pixel
        // mismatches = 0;
        // diff_of_one = 0;
        // print_limit = 10;

        // for (int ch = 0; ch < 256; ch++)
        // {
        //     for (int r = 0; r < 1; r++)
        //     {
        //         for (int c = 0; c < 1; c++)
        //         {
        //             // HW Output is [Ch][Row][Col]
        //             int hw_val = (int)hw_out_l7[(ch * 1 * 1) + (r * 1) + c];

        //             // SW Output is [Row][Col][Ch]
        //             int sw_val = (int)l7_out_sw_out.get<i8>((r * 1 * 256) + (c * 256) + ch);

        //             int diff = abs(hw_val - sw_val);

        //             if (diff > 0)
        //             {
        //                 channel_errs[ch] = true;
        //                 if (diff == 1)
        //                 {
        //                     diff_of_one++;
        //                 }
        //                 else
        //                 {
        //                     if (mismatches < print_limit)
        //                     {
        //                         printf("FAIL: Ch%d R%d C%d -> HW:%d SW:%d (Diff: %d)\n", ch, r, c, hw_val, sw_val, diff);
        //                     }
        //                     mismatches++;
        //                 }
        //             }
        //         }
        //     }
        // }

        // printf("\n--- RESULTS ---\n");
        // printf("Total Pixels: %d\n", 256);
        // printf("Differences of exactly 1 (Ignored): %d\n", diff_of_one);

        // if (mismatches == 0)
        // {
        //     printf(">> SUCCESS: Layer 1 matches perfectly (within +/- 1 tolerance).\n");
        // }
        // else
        // {
        //     printf(">> FAILURE: %d mismatches found > 1.\n", mismatches);
        // }

        // printf("Running layer 8 (Dense) (1x1x256 -> 1x1x200)...\n");

        LayerData ly7wd = LayerData{LayerParams{sizeof(i8), {200, 256, 1, 1}}, "data/quant_t_new/layer7_dense_weights_8q_t_new.bin"};
        LayerData ly7bd = LayerData{LayerParams{sizeof(i16), {200}}, "data/quant/param_layer_7/biases_8q.bin"};
        ly7wd.loadData();
        ly7bd.loadData();



        ctrlb_flags ^= MLP_CTRLB_SWAP_ACTIVATIONS;
        runAccLayer(aplayer7, (int8_t*) ly7wd.raw(), (int16_t*) ly7bd.raw(), 200, ctrlb_flags);

        std::vector<int8_t> hw_out_l8(200);
        memcpy_dma(hw_out_l8.data(), MLP_OUTPUTS, 200);

        ly7wd.freeData();
        ly7bd.freeData();

        LayerData denseOut = LayerData{LayerParams{sizeof(fp32), {200}}};
        denseOut.allocData();
        for (int i = 0; i < 200; i++) {
            denseOut.get<fp32>(i) = float(hw_out_l8[i])/8.0;
        }


        // Model d2Model;
        // d2Model.addLayer<DenseLayer>(
        //     LayerParams{sizeof(i8), {256}},                                                 // Input
        //     LayerParams{sizeof(fp32), {200}},                                               // Output
        //     LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_8q.bin"}, // Weights
        //     LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_8q.bin"},      // Biases
        //     false                                                                           // Enable Relu
        // );

        // d2Model.allocLayers();

        // const LayerData &l8_out_sw_out = d2Model.inference(l7_out_sw_out, Layer::InfType::QUANTIZED, modelQParams_8q + 11);

        // for (int i = 0; i < 200; i++) {
        //     if (std::abs(denseOut.get<fp32>(i) - l8_out_sw_out.get<fp32>(i)) > 1 ) {
        //         std::cout << "mismatch" << std::endl;
        //     } else {
        //         std::cout << "HW: " << denseOut.get<fp32>(i) << " SW: " << l8_out_sw_out.get<fp32>(i) << std::endl;
        //     }
        // }

        Model softmaxModel;
        softmaxModel.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );
        softmaxModel.allocLayers();
        const LayerData& hw_inf = softmaxModel.inferenceLayer(denseOut, 0, Layer::InfType::QUANTIZED);
        tmr.stop();
        std::cout << tmr.milliseconds << std::endl;

        // Model softmaxModel2;
        // softmaxModel2.addLayer<SoftmaxLayer>(
        //     LayerParams{sizeof(fp32), {200}}, // Input
        //     LayerParams{sizeof(fp32), {200}}  // Output
        // );
        // softmaxModel2.allocLayers();
        // const LayerData& sw_inf = softmaxModel2.inferenceLayer(l8_out_sw_out, 0, Layer::InfType::QUANTIZED);


        // float max = 0;
        // for (int i = 0; i < 200; i++) {
        //     float o1 = hw_inf.get<fp32>(i);
        //     float o2 = sw_inf.get<fp32>(i);
        //     float diff = std::abs(o1 - o2);
        //     if (diff > max)
        //         max = diff;
        //     std::cout << "HW: " << hw_inf.get<fp32>(i) << " SW: " << sw_inf.get<fp32>(i) << std::endl;
        // }
        // std::cout << max << std::endl;


        for (int i = 0; i < 200; i++) {
            std::cout << hw_inf.get<fp32>(i) << std::endl;
        }


        // model_l2.freeLayers();
        // moodel.freeLayers();

#endif
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

        Xil_DCacheDisable();

        ML::lab6Stuff();
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
