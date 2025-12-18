#include <fstream>
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
#include "layers/UpsampleLayer.h"
#include "layers/YoloConvLayer.h"
#include "layers/RouteLayer.h"
#include "YoloLoader.h"
#include "image_classes.h"
#include "ImageUtils.h"

#ifdef ZEDBOARD
#include <file_transfer/file_transfer.h>
#include "Acc.h"
#endif

namespace ML
{

    Model buildMixedModel()
    {
        Model model;
        logInfo("--- Building Mixed-Precision Model (8/4/2-bit) ---");

        std::cout << "Adding Layer 1: Convolutional (8-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {64, 64, 3}},
            LayerParams{sizeof(i8), {60, 60, 32}},
            LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant/param_layer_0/weights_8q.bin"},
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"});

        std::cout << "Adding Layer 2: Convolutional (8-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {60, 60, 32}},
            LayerParams{sizeof(i8), {56, 56, 32}},
            LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant/param_layer_1/weights_8q.bin"},
            LayerParams{sizeof(i16), {32}, "data/quant/param_layer_1/biases_8q.bin"});

        std::cout << "Adding Layer 3: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {56, 56, 32}},
            LayerParams{sizeof(i8), {28, 28, 32}});

        std::cout << "Adding Layer 4: Convolutional (4-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {28, 28, 32}},
            LayerParams{sizeof(i8), {26, 26, 64}},
            LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant/param_layer_2/weights_4q.bin"},
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_2/biases_4q.bin"});

        std::cout << "Adding Layer 5: Convolutional (4-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {26, 26, 64}},
            LayerParams{sizeof(i8), {24, 24, 64}},
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_3/weights_4q.bin"},
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_3/biases_4q.bin"});

        std::cout << "Adding Layer 6: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {24, 24, 64}},
            LayerParams{sizeof(i8), {12, 12, 64}});

        std::cout << "Adding Layer 7: Convolutional (4-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {12, 12, 64}},
            LayerParams{sizeof(i8), {10, 10, 64}},
            LayerParams{sizeof(i8), {3, 3, 64, 64}, "data/quant/param_layer_4/weights_4q.bin"},
            LayerParams{sizeof(i16), {64}, "data/quant/param_layer_4/biases_4q.bin"});

        std::cout << "Adding Layer 8: Convolutional (2-bit)" << std::endl;
        model.addLayer<ConvolutionalLayer>(
            LayerParams{sizeof(i8), {10, 10, 64}},
            LayerParams{sizeof(i8), {8, 8, 128}},
            LayerParams{sizeof(i8), {3, 3, 64, 128}, "data/quant/param_layer_5/weights_4q.bin"},
            LayerParams{sizeof(i16), {128}, "data/quant/param_layer_5/biases_4q.bin"});

        std::cout << "Adding Layer 9: MaxPooling" << std::endl;
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {8, 8, 128}},
            LayerParams{sizeof(i8), {4, 4, 128}});

        std::cout << "Adding Layer 10: Flatten" << std::endl;
        model.addLayer<FlattenLayer>(
            LayerParams{sizeof(i8), {4, 4, 128}},
            LayerParams{sizeof(i8), {2048}});

        std::cout << "Adding Layer 11: Dense (8-bit)" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {2048}},
            LayerParams{sizeof(i8), {256}},
            LayerParams{sizeof(i8), {2048, 256}, "data/quant/param_layer_6/weights_8q.bin"},
            LayerParams{sizeof(i16), {256}, "data/quant/param_layer_6/biases_8q.bin"},
            true);

        std::cout << "Adding Layer 12: Dense (8-bit)" << std::endl;
        model.addLayer<DenseLayer>(
            LayerParams{sizeof(i8), {256}},
            LayerParams{sizeof(fp32), {200}},
            LayerParams{sizeof(i8), {256, 200}, "data/quant/param_layer_7/weights_8q.bin"},
            LayerParams{sizeof(i16), {200}, "data/quant/param_layer_7/biases_8q.bin"},
            false);

        std::cout << "Adding Layer 13: Softmax" << std::endl;
        model.addLayer<SoftmaxLayer>(
            LayerParams{sizeof(fp32), {200}},
            LayerParams{sizeof(fp32), {200}});

        return model;
    }

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
        const LayerParams &biasParams,
        const std::string &mode)
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

        if (mode == "computeNaive")
        {
            layer.computeNaive(inputData);
        }
        else if (mode == "computeTiled")
        {
            layer.computeTiled(inputData);
        }
        else if (mode == "computeThreaded")
        {
            layer.computeThreaded(inputData);
        }
        else if (mode == "computeSIMD")
        {
            layer.computeSIMD(inputData);
        }
        else
        { // Run naive by default
            layer.computeNaive(inputData);
        }

        timer.stop();

        const LayerData &actual_output = layer.getOutputData();
        std::string expected_output_filename = "layer_" + std::to_string(layer_idx) + "_output.bin";
        LayerData expected_output(outParams, basePath / "image_0_data" / expected_output_filename.c_str());
        expected_output.loadData();

        log("Comparing C++ output against TensorFlow output...");
        actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

        layer.freeLayer();
    }

    void checkMaxPoolingLayer(
        const Path &basePath,
        int layer_idx,
        const LayerParams &inParams,
        const LayerParams &outParams)
    {
        std::string layer_name = "Layer " + std::to_string(layer_idx) + ": MaxPooling";
        logInfo("----- Verifying " + layer_name + " -----");

        MaxPoolingLayer layer(inParams, outParams);
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

    void checkFlattenLayer(
        const Path &basePath,
        int layer_idx,
        const LayerParams &inParams,
        const LayerParams &outParams)
    {
        std::string layer_name = "Layer " + std::to_string(layer_idx) + ": Flatten";
        logInfo("----- Verifying " + layer_name + " -----");

        FlattenLayer layer(inParams, outParams);
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

    std::string formatDims(const ML::dimVec &dims)
    {
        std::stringstream ss;
        ss << "[";
        for (size_t i = 0; i < dims.size(); ++i)
        {
            ss << dims[i];
            if (i < dims.size() - 1)
            {
                ss << ", ";
            }
        }
        ss << "]";
        return ss.str();
    }

    void checkDenseLayer(
        const Path &basePath,
        int layer_idx,
        const LayerParams &inParams,
        const LayerParams &outParams,
        const LayerParams &weightParams,
        const LayerParams &biasParams,
        bool useRelu)
    {
        std::string layer_name = "Layer " + std::to_string(layer_idx) + ": Dense";
        logInfo("----- Verifying " + layer_name + " -----");

        DenseLayer layer(inParams, outParams, weightParams, biasParams, useRelu);
        layer.allocLayer();

        std::cout << "Layer " << layer_idx << " Input Shape:  " << formatDims(inParams.dims) << std::endl;
        std::cout << "Layer " << layer_idx << " Output Shape: " << formatDims(outParams.dims) << std::endl;

        std::cout << "--- Inspecting Layer " << layer_idx << " Data ---" << std::endl;
        const float *weights = static_cast<const float *>(layer.getWeightData().raw());
        const float *biases = static_cast<const float *>(layer.getBiasData().raw());
        std::cout << "First 5 weights: ";
        for (int i = 0; i < 5; ++i)
            std::cout << weights[i] << " ";
        std::cout << std::endl;
        std::cout << "First 5 biases: ";
        for (int i = 0; i < 5; ++i)
            std::cout << biases[i] << " ";
        std::cout << std::endl;

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

    void checkDenseWithSoftmaxLayer(
        const Path &denseBasePath,
        int denseLayer_idx,
        const LayerParams &denseInParams,
        const LayerParams &denseOutParams,
        const LayerParams &denseWeightParams,
        const LayerParams &denseBiasParams,
        const Path &softmaxBasePath,
        int softmaxLayer_idx,
        const LayerParams &softmaxInParams,
        const LayerParams &softmaxOutParams)
    {

        std::string denseLayer_name = "Layer " + std::to_string(denseLayer_idx) + ": Dense";
        std::string softmaxLayer_name = "Layer " + std::to_string(softmaxLayer_idx) + ": Softmax";
        logInfo("----- Verifying " + denseLayer_name + " + " + softmaxLayer_name + " -----");

        DenseLayer denseLayer(denseInParams, denseOutParams, denseWeightParams, denseBiasParams, false);
        SoftmaxLayer softmaxLayer(softmaxInParams, softmaxOutParams);
        denseLayer.allocLayer();
        softmaxLayer.allocLayer();

        std::cout << "Dense Layer " << denseLayer_idx << " Input Shape:  " << formatDims(denseInParams.dims) << std::endl;
        std::cout << "Dense Layer " << denseLayer_idx << " Output Shape: " << formatDims(denseOutParams.dims) << std::endl;

        std::cout << "Softmax Layer " << denseLayer_idx << " Input Shape:  " << formatDims(denseInParams.dims) << std::endl;
        std::cout << "Softmax Layer " << denseLayer_idx << " Output Shape: " << formatDims(denseOutParams.dims) << std::endl;

        Path dense_input_file_path = getLayerInputPath(denseBasePath, denseLayer_idx);
        LayerData denseInputData(denseInParams, dense_input_file_path);
        denseInputData.loadData();

        Timer denseTimer(denseLayer_name + " Inference");
        denseTimer.start();
        denseLayer.computeNaive(denseInputData);
        denseTimer.stop();
        Timer softmaxTimer(softmaxLayer_name + " Inference");
        softmaxTimer.start();
        softmaxLayer.computeNaive(denseLayer.getOutputData());
        softmaxTimer.stop();

        const LayerData &actual_output = softmaxLayer.getOutputData();
        std::string expected_output_filename = "layer_" + std::to_string(denseLayer_idx) + "_output.bin";
        LayerData expected_output(denseOutParams, denseBasePath / "image_0_data" / expected_output_filename.c_str());
        expected_output.loadData();

        log("Comparing C++ output against TensorFlow output...");
        actual_output.compareWithinPrint<fp32>(expected_output, 1e-4);

        denseLayer.freeLayer();
    }

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

        // Get the input parameters from the model's first layer to load images.
        const LayerParams &inputParams = model[0].getInputParams();

        std::cout << "Starting profiling for " << numInferences << " inferences..." << std::endl;

        for (int i = 0; i < numInferences; ++i)
        {
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

    void profileModelWithTiling(const Model &model, const Path &basePath, int numInferences)
    {
        logInfo("--- Running FP32 Tiling Multi-Inference Profiling Test ---");

        const std::vector<size_t> tileSizesToTest = {2, 4, 8, 16, 32};

        for (size_t tileSize : tileSizesToTest)
        {
            logInfo("--- Profiling with Tile Size: " + std::to_string(tileSize) + " ---");

            if (numInferences < 1)
            {
                printf("Error: Number of inferences must be at least 1.");
                return;
            }

            // Vector to accumulate the total time for each layer over all inferences.
            std::vector<double> totalLayerMilliseconds(model.getNumLayers(), 0.0);

            const LayerParams &inputParams = model[0].getInputParams();

            std::cout << "Starting profiling for " << numInferences << " inferences..." << std::endl;

            for (int i = 0; i < numInferences; ++i)
            {
                Path imagePath = basePath / "unquant" / "images_1000_fp32" / (std::to_string(i) + ".bin");
                LayerData img(inputParams, imagePath);
                img.loadData();

                const LayerData *currentData = &img;

                // Loop through each layer of the model and time its inference.
                for (size_t layerIdx = 0; layerIdx < model.getNumLayers(); ++layerIdx)
                {
                    Timer layerTimer("Layer_" + std::to_string(layerIdx));
                    layerTimer.start();

                    // Apply tiling to the bottleneck layer, and naive to the rest
                    if (dynamic_cast<const ConvolutionalLayer *>(&model[layerIdx]))
                    {
                        currentData = &model.inferenceLayer(*currentData, layerIdx, Layer::InfType::TILED, {}, tileSize);
                    }
                    else
                    {
                        currentData = &model.inferenceLayer(*currentData, layerIdx, Layer::InfType::NAIVE);
                    }

                    layerTimer.stop();
                    totalLayerMilliseconds[layerIdx] += layerTimer.milliseconds;
                }

                if ((i + 1) % 10 == 0 || (i + 1) == numInferences)
                {
                    std::cout << "  ...completed " << (i + 1) << "/" << numInferences << " inferences." << std::endl;
                }
            }

            logInfo("--- FP32 Tiling Profiling Results (Tile Size: " + std::to_string(tileSize) + ") ---");

            double totalAverageTimeMs = 0.0;

            std::cout << "\n--- Average Individual Layer Times (" << numInferences << " inferences) ---\n";

            for (size_t i = 0; i < totalLayerMilliseconds.size(); ++i)
            {
                double avgMilliseconds = totalLayerMilliseconds[i] / numInferences;
                totalAverageTimeMs += avgMilliseconds;

                std::cout << "Layer " << i << ": " << avgMilliseconds << " ms" << std::endl;
            }

            std::cout << "\nTotal Average Inference Time: " << totalAverageTimeMs << " ms ("
                      << totalAverageTimeMs / 1000.0 << " s)\n"
                      << std::endl;
        }
    }

    void profileModelWithThreading(const Model &model, const Path &basePath, int numInferences)
    {
        logInfo("--- Running FP32 Multi-Threaded Profiling Test ---");

        const std::vector<size_t> threadCounts = {1, 2, 4, 8, 16, 32, 64};
        // const std::vector<size_t> threadCounts = {16};

        for (size_t numThreads : threadCounts)
        {
            logInfo("--- Profiling with Thread Count: " + std::to_string(numThreads) + " ---");

            if (numInferences < 1)
            {
                printf("Error: Number of inferences must be at least 1.");
                return;
            }

            // Vector to accumulate the total time for each layer over all inferences.
            std::vector<double> totalLayerMilliseconds(model.getNumLayers(), 0.0);

            const LayerParams &inputParams = model[0].getInputParams();

            std::cout << "Starting profiling for " << numInferences << " inferences..." << std::endl;

            for (int i = 0; i < numInferences; ++i)
            {
                Path imagePath = basePath / "unquant" / "images_1000_fp32" / (std::to_string(i) + ".bin");
                LayerData img(inputParams, imagePath);
                img.loadData();

                const LayerData *currentData = &img;

                // Loop through each layer of the model and time its inference.
                for (size_t layerIdx = 0; layerIdx < model.getNumLayers(); ++layerIdx)
                {
                    Timer layerTimer("Layer_" + std::to_string(layerIdx));
                    layerTimer.start();

                    // Apply threading only to Conv Layers
                    if (dynamic_cast<const ConvolutionalLayer *>(&model[layerIdx]))
                    {
                        currentData = &model.inferenceLayer(*currentData, layerIdx, Layer::InfType::THREADED, {}, 0, numThreads);
                    }
                    else
                    {
                        currentData = &model.inferenceLayer(*currentData, layerIdx, Layer::InfType::NAIVE);
                    }

                    layerTimer.stop();
                    totalLayerMilliseconds[layerIdx] += layerTimer.milliseconds;
                }

                if ((i + 1) % 100 == 0 || (i + 1) == numInferences)
                {
                    std::cout << "  ...completed " << (i + 1) << "/" << numInferences << " inferences." << std::endl;
                }
            }

            logInfo("--- FP32 Threading Profiling Results (Threads: " + std::to_string(numThreads) + ") ---");

            double totalAverageTimeMs = 0.0;

            std::cout << "\n--- Average Individual Layer Times (" << numInferences << " inferences) ---\n";

            for (size_t i = 0; i < totalLayerMilliseconds.size(); ++i)
            {
                double avgMilliseconds = totalLayerMilliseconds[i] / numInferences;
                totalAverageTimeMs += avgMilliseconds;

                std::cout << "Layer " << i << ": " << avgMilliseconds << " ms" << std::endl;
            }

            std::cout << "\nTotal Average Inference Time: " << totalAverageTimeMs << " ms ("
                      << totalAverageTimeMs / 1000.0 << " s)\n"
                      << std::endl;
        }
    }

    void individualLayerTest(const Path &basePath, const std::string &mode)
    {
        Path modelPath = basePath / "model";
        // Test first layer
        checkConvLayer(
            basePath, 0,
            LayerParams{sizeof(fp32), {64, 64, 3}},                                    // Input Data
            LayerParams{sizeof(fp32), {60, 60, 32}},                                   // Output Data
            LayerParams{sizeof(fp32), {5, 5, 3, 32}, modelPath / "conv1_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {32}, modelPath / "conv1_biases.bin"},           // Bias
            mode);
        // Test second layer
        checkConvLayer(
            basePath, 1,
            LayerParams{sizeof(fp32), {60, 60, 32}},                                    // Input Data
            LayerParams{sizeof(fp32), {56, 56, 32}},                                    // Output Data
            LayerParams{sizeof(fp32), {5, 5, 32, 32}, modelPath / "conv2_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {32}, modelPath / "conv2_biases.bin"},            // Bias
            mode);
        // --- MPL 1: L3 ---
        // Input shape: 56x56x32
        // Output shape: 28x28x32
        checkMaxPoolingLayer(
            basePath, 2,
            LayerParams{sizeof(fp32), {56, 56, 32}}, // Input
            LayerParams{sizeof(fp32), {28, 28, 32}}  // Output
        );
        // --- Conv 3: L4 ---
        // Input shape: 28x28x32
        // Output shape: 26x26x64
        checkConvLayer(
            basePath, 3,
            LayerParams{sizeof(fp32), {28, 28, 32}},                                    // Input Data
            LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 32, 64}, modelPath / "conv3_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv3_biases.bin"},            // Bias
            mode);
        // --- Conv 4: L5 ---
        // Input shape: 26x26x64
        // Output shape: 24x24x64
        checkConvLayer(
            basePath, 4,
            LayerParams{sizeof(fp32), {26, 26, 64}},                                    // Input Data
            LayerParams{sizeof(fp32), {24, 24, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv4_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv4_biases.bin"},            // Bias
            mode);
        // --- MPL 2: L6 ---
        // Input shape: 24x24x64
        // Output shape: 12x12x64
        checkMaxPoolingLayer(
            basePath, 5,
            LayerParams{sizeof(fp32), {24, 24, 64}}, // Input
            LayerParams{sizeof(fp32), {12, 12, 64}}  // Output
        );
        // --- Conv 5: L7 ---
        // Input shape: 12x12x64
        // Output shape: 10x10x64
        checkConvLayer(
            basePath, 6,
            LayerParams{sizeof(fp32), {12, 12, 64}},                                    // Input Data
            LayerParams{sizeof(fp32), {10, 10, 64}},                                    // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 64}, modelPath / "conv5_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {64}, modelPath / "conv5_biases.bin"},            // Bias
            mode);
        // --- Conv 6: L8 ---
        // Input shape: 10x10x64
        // Output shape: 8x8x128
        checkConvLayer(
            basePath, 7,
            LayerParams{sizeof(fp32), {10, 10, 64}},                                     // Input Data
            LayerParams{sizeof(fp32), {8, 8, 128}},                                      // Output Data
            LayerParams{sizeof(fp32), {3, 3, 64, 128}, modelPath / "conv6_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {128}, modelPath / "conv6_biases.bin"},            // Bias
            mode);
        // --- MPL 3: L9 ---
        // Input shape: 8x8x128
        // Output shape: 4x4x128
        checkMaxPoolingLayer(
            basePath, 8,
            LayerParams{sizeof(fp32), {8, 8, 128}}, // Input
            LayerParams{sizeof(fp32), {4, 4, 128}}  // Output
        );
        // --- Flatten 1: L10 ---
        // Input shape: 4x4x128
        // Output shape: 2048
        checkFlattenLayer(
            basePath, 9,
            LayerParams{sizeof(fp32), {4, 4, 128}}, // Input
            LayerParams{sizeof(fp32), {2048}}       // Output
        );
        // --- Dense 1: L11 ---
        // Input shape: 2048
        // Output shape: 256
        checkDenseLayer(
            basePath, 10,
            LayerParams{sizeof(fp32), {2048}},                                        // Input
            LayerParams{sizeof(fp32), {256}},                                         // Output
            LayerParams{sizeof(fp32), {2048, 256}, modelPath / "dense1_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {256}, modelPath / "dense1_biases.bin"},        // Biases,
            true                                                                      // Use relu
        );
        // --- Dense 2: L12 ---
        // Input shape: 256
        // Output shape: 200
        // --- Softmax 1: L13 ---
        // Input shape: 200
        // Output shape: 200
        checkDenseWithSoftmaxLayer(
            basePath, 11,
            LayerParams{sizeof(fp32), {256}},                                        // Input
            LayerParams{sizeof(fp32), {200}},                                        // Output
            LayerParams{sizeof(fp32), {256, 200}, modelPath / "dense2_weights.bin"}, // Weights
            LayerParams{sizeof(fp32), {200}, modelPath / "dense2_biases.bin"},       // Biases
            basePath, 12,
            LayerParams{sizeof(fp32), {200}}, // Input
            LayerParams{sizeof(fp32), {200}}  // Output
        );
    }

    void test8BitAccuracy()
    {
        logInfo("--- Measuring 8-Bit Model Accuracy ---");

        // Build and Allocate
        Model model = build8QModel();
        model.allocLayers();

        int successes = 0;
        int numImages = 1000;

        std::cout << "Running inference on " << numImages << " images..." << std::endl;

        for (int i = 0; i < numImages; i++)
        {
            // Construct path to 8-bit input image
            std::string path = "data/quant/images_1000_8b/" + std::to_string(i) + ".bin";

            // Run inference and check against ground truth class
            // Note: images_8q_classes needs to be defined in your image_classes.h
            bool isCorrect = runInfTestQuant(model, path.c_str(), images_8q_classes[i], modelQParams_8q);

            if (isCorrect)
            {
                successes++;
            }

            // Progress indicator every 100 images
            if ((i + 1) % 100 == 0)
            {
                std::cout << "Processed " << (i + 1) << " images. Current Acc: "
                          << ((float)successes / (i + 1) * 100.0f) << "%" << std::endl;
            }
        }

        fp32 accuracy = ((float)successes) / (float)numImages * 100.0f;
        std::cout << "\n--------------------------------------------" << std::endl;
        std::cout << "FINAL 8-BIT ACCURACY: " << accuracy << "% (" << successes << "/" << numImages << ")" << std::endl;
        std::cout << "--------------------------------------------\n"
                  << std::endl;

        // Cleanup
        model.freeLayers();
    }

    void test4BitAccuracy()
    {
        logInfo("--- Measuring 4-Bit Model Accuracy ---");

        // Build and Allocate
        Model model = build4QModel();
        model.allocLayers();

        int successes = 0;
        int numImages = 1000;

        std::cout << "Running inference on " << numImages << " images..." << std::endl;

        for (int i = 0; i < numImages; i++)
        {
            std::string path = "data/quant/images_1000_4b/" + std::to_string(i) + ".bin";

            bool isCorrect = runInfTestQuant(model, path.c_str(), images_4q_classes[i], modelQParams_4q);

            if (isCorrect)
            {
                successes++;
            }

            if ((i + 1) % 100 == 0)
            {
                std::cout << "Processed " << (i + 1) << " images. Current Acc: "
                          << ((float)successes / (i + 1) * 100.0f) << "%" << std::endl;
            }
        }

        fp32 accuracy = ((float)successes) / (float)numImages * 100.0f;
        std::cout << "\n--------------------------------------------" << std::endl;
        std::cout << "FINAL 4-BIT ACCURACY: " << accuracy << "% (" << successes << "/" << numImages << ")" << std::endl;
        std::cout << "--------------------------------------------\n"
                  << std::endl;

        // Cleanup
        model.freeLayers();
    }

    void testMixedAccuracy()
    {
        logInfo("--- Measuring Mixed-Precision Model Accuracy ---");

        // Build and Allocate the Mixed Model
        Model model = buildMixedModel();
        model.allocLayers();

        // Construct the Mixed QParams Array
        // We need a non-const array so we can assign specific params to it
        static QParams mixedParams[13];

        // L0, L1 (Conv): 8-bit
        mixedParams[0] = modelQParams_8q[0];
        mixedParams[1] = modelQParams_8q[1];

        // L2 (Pool)
        mixedParams[2] = modelQParams_8q[2];

        // L3, L4 (Conv): 4-bit
        mixedParams[3] = modelQParams_4q[3];
        mixedParams[4] = modelQParams_4q[4];

        // L5 (Pool)
        mixedParams[5] = modelQParams_4q[5];

        mixedParams[6] = modelQParams_4q[6];
        mixedParams[7] = modelQParams_4q[7];

        // L8, L9 (Pool, Flatten)
        mixedParams[8] = modelQParams_8q[8];
        mixedParams[9] = modelQParams_8q[9];

        // L10, L11 (Dense): 8-bit
        mixedParams[10] = modelQParams_8q[10];
        mixedParams[11] = modelQParams_8q[11];

        // L12 (Softmax)
        mixedParams[12] = modelQParams_8q[12];

        int successes = 0;
        int numImages = 1000;

        std::cout << "Running mixed inference on " << numImages << " images..." << std::endl;

        for (int i = 0; i < numImages; i++)
        {
            std::string path = "data/quant/images_1000_8b/" + std::to_string(i) + ".bin";

            bool isCorrect = runInfTestQuant(model, path.c_str(), images_8q_classes[i], mixedParams);

            if (isCorrect)
                successes++;

            if ((i + 1) % 100 == 0)
            {
                std::cout << "Processed " << (i + 1) << " images. Current Acc: "
                          << ((float)successes / (i + 1) * 100.0f) << "%" << std::endl;
            }
        }

        fp32 accuracy = ((float)successes) / (float)numImages * 100.0f;
        std::cout << "\n--------------------------------------------" << std::endl;
        std::cout << "FINAL MIXED MODEL ACCURACY: " << accuracy << "% (" << successes << "/" << numImages << ")" << std::endl;
        std::cout << "--------------------------------------------\n"
                  << std::endl;

        model.freeLayers();
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
        // Base input data path (determined from current directory of where you are running the command)
        Path basePath("data"); // May need to be altered for zedboards loading from SD Cards
        Path modelPath = basePath / "model";

        // ConvolutionalLayer layer(LayerParams{sizeof(i8), {64,64,3}}, LayerParams{sizeof(i8), {60, 60, 32}}, LayerParams{sizeof(i8), {5, 5, 3, 32}, "data/quant2/param_layer_0/weights_8q.bin"}, LayerParams{sizeof(i16), {32}, "data/quant/param_layer_0/biases_8q.bin"});
        // layer.allocLayer();

        Path input_file_path = "data/quant/given_image0_8q.bin";
        LayerData inputData(LayerParams{sizeof(i8), {64, 64, 3}}, input_file_path);
        inputData.loadData();

        // layer.computeQuantized(inputData, {player0outputscaler, 226, 419, Zp_macced_player0, -3, true});
        // const LayerData &actual_output = layer.getOutputData();
        // ConvolutionalLayer layer2(LayerParams{sizeof(i8), {60,60,32}}, LayerParams{sizeof(i8), {56, 56, 32}}, LayerParams{sizeof(i8), {5, 5, 32, 32}, "data/quant2/param_layer_1/weights_8q.bin"}, LayerParams{sizeof(i16), {32}, "data/quant2/param_layer_1/biases_8q.bin"});
        // layer2.allocLayer();
        // layer2.computeQuantized(actual_output, {player1outputscaler, 78, 261, Zp_macced_player1, -2, true});
        // const LayerData &next_actual_output = layer2.getOutputData();
        // MaxPoolingLayer poolLayer(LayerParams{sizeof(i8), {56, 56, 32}}, LayerParams{sizeof(i8), {28, 28, 32}});
        // poolLayer.allocLayer();
        // poolLayer.computeQuantized(next_actual_output, {0, 0, 0, 0, 0, true});
        // const LayerData& pool_actual_output = poolLayer.getOutputData();
        // ConvolutionalLayer layer3(LayerParams{sizeof(i8), {28,28,32}}, LayerParams{sizeof(fp32), {26, 26, 64}}, LayerParams{sizeof(i8), {3, 3, 32, 64}, "data/quant2/param_layer_2/weights_8q.bin"}, LayerParams{sizeof(i16), {64}, "data/quant2/param_layer_2/biases_8q.bin"});
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

        // Quantized test stuff
        // testMixedAccuracy();
        // test4BitAccuracy();
        // test8BitAccuracy();

        // Model model8q = build8QModel();
        // model8q.allocLayers();
        // // Model model4q = build4QModel();
        // // model4q.allocLayers();
        // std::string expected_output_filename = "layer_" + std::to_string(11) + "_output.bin";
        // runInfTestQuant(model8q, "data/quant/given_image0_8q.bin", 163, modelQParams_8q);
        // size_t imageIdx;
        // int successes = 0;
        // for (imageIdx = 0; imageIdx < 1000; imageIdx++) {
        //     bool predictedAccurately = runInfTestQuant(model8q, "data/quant/images_1000_8b/" + std::to_string(imageIdx) + ".bin", images_8q_classes[imageIdx], modelQParams_8q);
        //     // bool predictedAccurately = runInfTestQuant(model4q, "data/quant/images_1000_4b/" + std::to_string(imageIdx) + ".bin", images_4q_classes[imageIdx], modelQParams_4q);
        //     if (predictedAccurately)
        //         successes += 1;
        // }
        // fp32 accuracy = ((float) successes) / 1000.0f;
        // std::cout << "8q accuracy: " << std::endl;
        // std::cout << accuracy << std::endl;
        // model8q.freeLayers();
        // model4q.freeLayers();
        // const LayerData& output = model8q.inference(inputData, Layer::InfType::QUANTIZED, modelQParams_8q);
        // LayerData expected_output2(LayerParams{sizeof(fp32), {200}}, basePath / "image_0_data" / expected_output_filename.c_str());
        // expected_output2.loadData();
        // output.compareWithinPrint<fp32>(expected_output2, 1e-4);
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

        // Build the model and allocate the buffers
        Model model = buildToyModel(modelPath);
        model.allocLayers();

        // Run some framework tests as an example of loading data
        // runBasicTest(model, basePath);

        // Run a layer inference test
        // runLayerTest(0, model, basePath);

        // Run an end-to-end inference test
        // runInferenceTest(model, basePath);

        int numInferences = 1000;
        // profileFp32Model(model, basePath, numInferences);
        // profileModelWithTiling(model, basePath, numInferences);
        profileModelWithThreading(model, basePath, numInferences);

        // generateAccessTraces(model, basePath);

        // Run a profiling test to time the model
        // runProfilingTest(model, basePath);
        // individualLayerTest(basePath, "computeThreaded");

        // Clean up
        // model.freeLayers();
        std::cout << "\n\n----- ML::runTests() COMPLETE -----\n";
    }

    // YOLO CODE

    const int NUM_CLASSES = 80;
    const float ANCHORS_ALL[6][2] = {
        {10, 14}, {23, 27}, {37, 58}, {81, 82}, {135, 169}, {344, 319}};
    const int MASK_13[] = {3, 4, 5};
    const int MASK_26[] = {0, 1, 2};

    struct Box
    {
        float x, y, w, h, score;
        int class_id;
    };

    struct Anchor
    {
        float w, h;
    };

    inline float sigmoid(float x) { return 1.0f / (1.0f + std::exp(-x)); }

    inline float iou(const Box &a, const Box &b)
    {
        float x1 = std::max(a.x - a.w / 2, b.x - b.w / 2);
        float y1 = std::max(a.y - a.h / 2, b.y - b.h / 2);
        float x2 = std::min(a.x + a.w / 2, b.x + b.w / 2);
        float y2 = std::min(a.y + a.h / 2, b.y + b.h / 2);
        float inter_w = std::max(0.0f, x2 - x1);
        float inter_h = std::max(0.0f, y2 - y1);
        float inter_area = inter_w * inter_h;
        float area_a = a.w * a.h;
        float area_b = b.w * b.h;
        return inter_area / (area_a + area_b - inter_area + 1e-6f);
    }

    //  MODEL BUILDER

    std::vector<QParams> yolo_qparams_store;

    // Helper to calc multiplier with Reciprocal Scales
    // Mult = So / (Si * Sw)
    void calcYoloMult(float Si, float Sw, float So, QParams &q)
    {
        q.S_i = Si;
        q.S_w = Sw;

        double acc_scale = (double)Si * (double)Sw;
        double real_mult = 0.0;

        if (acc_scale > 1e-9)
        {
            real_mult = (double)So / acc_scale;
        }

        int shift;
        const double d_q = std::frexp(real_mult, &shift);
        auto q_fixed = (int64_t)std::round(d_q * (1LL << 31));
        if (q_fixed == (1LL << 31))
        {
            q_fixed /= 2;
            shift += 1;
        }

        q.output_multiplier = (int32_t)q_fixed;
        q.output_shift = 31 - shift;
    }

    float getScale(const YoloLoader &loader, const std::string &name)
    {
        auto *l = loader.getLayerByName(name);
        return l ? l->Si : 1.0f;
    }

    void addYoloConv(Model &model, const YoloLoader &loader, std::string name, std::string next_name, size_t inW, size_t inH, bool isHead = false)
    {
        auto *conf = loader.getLayerByName(name);
        if (!conf)
            throw std::runtime_error("Missing layer config: " + name);

        size_t outW = inW / conf->stride;
        size_t outH = inH / conf->stride;

        size_t outElemSize = isHead ? sizeof(fp32) : sizeof(i8);

        model.addLayer<YoloConvLayer>(
            LayerParams{sizeof(i8), {inW, inH, (size_t)conf->in_ch}},
            LayerParams{outElemSize, {outW, outH, (size_t)conf->out_ch}},
            LayerParams{sizeof(i8), {(size_t)conf->k_w, (size_t)conf->k_h, (size_t)conf->in_ch, (size_t)conf->out_ch}, conf->weightsPath},
            LayerParams{sizeof(i32), {(size_t)conf->out_ch}, conf->biasPath});

        QParams q = {0};
        q.Z_i = conf->zi;

        float S_next = 1.0f;
        if (!isHead)
        {
            S_next = getScale(loader, next_name);
            q.quantedOutput = true;
            auto *next = loader.getLayerByName(next_name);
            if (next)
                q.Z_i_next = next->zi;
        }
        else
        {
            q.quantedOutput = false;
        }

        calcYoloMult(conf->Si, conf->Sw, S_next, q);
        yolo_qparams_store.push_back(q);
    }

    void addYoloPool(Model &model, size_t W, size_t H, size_t C)
    {
        model.addLayer<MaxPoolingLayer>(
            LayerParams{sizeof(i8), {W, H, C}},
            LayerParams{sizeof(i8), {W / 2, H / 2, C}});
        QParams q = {0};
        q.quantedOutput = true;
        yolo_qparams_store.push_back(q);
    }

    Model buildYoloV3Tiny(const std::string &configPath, const std::string &dataDir)
    {
        Model model;
        YoloLoader loader;
        if (!loader.load(configPath, dataDir))
            throw std::runtime_error("Load failed");
        yolo_qparams_store.clear();

        addYoloConv(model, loader, "layer0.0", "layer2.0", 416, 416);
        addYoloPool(model, 416, 416, 16);
        addYoloConv(model, loader, "layer2.0", "layer4.0", 208, 208);
        addYoloPool(model, 208, 208, 32);
        addYoloConv(model, loader, "layer4.0", "layer6.0", 104, 104);
        addYoloPool(model, 104, 104, 64);
        addYoloConv(model, loader, "layer6.0", "layer8.0", 52, 52);
        addYoloPool(model, 52, 52, 128);
        addYoloConv(model, loader, "layer8.0", "layer10.0", 26, 26);
        const Layer *ptr_layer8 = &model.getOutputLayer();

        addYoloPool(model, 26, 26, 256);
        addYoloConv(model, loader, "layer10.0", "layer12.0", 13, 13);
        addYoloConv(model, loader, "layer12.0", "layer13.0", 13, 13);
        addYoloConv(model, loader, "layer13.0", "layer14.0", 13, 13);
        const Layer *ptr_layer13 = &model.getOutputLayer();

        // Head 1
        addYoloConv(model, loader, "layer14.0", "layer15", 13, 13);
        addYoloConv(model, loader, "layer15", "", 13, 13, true);

        // Head 2 Branch
        model.addLayer<RouteLayer>(
            model.getOutputLayer().getOutputParams(),
            ptr_layer13->getOutputParams(),
            std::vector<const Layer *>{ptr_layer13});
        yolo_qparams_store.push_back({0});

        addYoloConv(model, loader, "layer18.0", "layer21.0", 13, 13);

        const LayerParams &prevOut = model.getOutputLayer().getOutputParams();
        std::vector<size_t> upDims = prevOut.dims;
        upDims[0] *= 2;
        upDims[1] *= 2;
        LayerParams upOut(prevOut.elementSize, upDims);
        model.addLayer<UpsampleLayer>(prevOut, upOut, 2);
        yolo_qparams_store.push_back({0});

        std::vector<size_t> concatDims = upDims;
        concatDims[2] = upDims[2] + ptr_layer8->getOutputParams().dims[2];
        LayerParams concatOut(upOut.elementSize, concatDims);
        model.addLayer<RouteLayer>(
            model.getOutputLayer().getOutputParams(),
            concatOut,
            std::vector<const Layer *>{&model.getOutputLayer(), ptr_layer8});
        yolo_qparams_store.push_back({0});

        addYoloConv(model, loader, "layer21.0", "layer22", 26, 26);
        addYoloConv(model, loader, "layer22", "", 26, 26, true);

        return model;
    }

    //  POST PROCESSING
    void process_output(const LayerData &feature_map, const int *mask, int stride,
                        std::vector<Box> &boxes, float conf_thresh = 0.4)
    {
        const float *data = (const float *)feature_map.raw();
        const auto &dims = feature_map.getParams().dims;
        int grid_w = dims[0];
        int grid_h = dims[1];
        int channels = dims[2];

        for (int a = 0; a < 3; a++)
        {
            Anchor anchor = {ANCHORS_ALL[mask[a]][0], ANCHORS_ALL[mask[a]][1]};
            int box_ch_start = a * (5 + NUM_CLASSES);

            for (int y = 0; y < grid_h; y++)
            {
                for (int x = 0; x < grid_w; x++)
                {

                    auto get_val = [&](int ch_offset)
                    {
                        return data[(y * grid_w + x) * channels + box_ch_start + ch_offset];
                    };

                    float obj_logit = get_val(4);
                    float obj_score = sigmoid(obj_logit);

                    if (obj_score > conf_thresh)
                    {
                        float max_cls_score = 0;
                        int cls_id = -1;
                        for (int c = 0; c < NUM_CLASSES; c++)
                        {
                            float cls_score = sigmoid(get_val(5 + c));
                            if (cls_score > max_cls_score)
                            {
                                max_cls_score = cls_score;
                                cls_id = c;
                            }
                        }

                        float final_score = obj_score * max_cls_score;
                        if (final_score > conf_thresh)
                        {
                            float bx = (sigmoid(get_val(0)) + x) * stride;
                            float by = (sigmoid(get_val(1)) + y) * stride;
                            float bw = std::exp(get_val(2)) * anchor.w;
                            float bh = std::exp(get_val(3)) * anchor.h;
                            boxes.push_back({bx, by, bw, bh, final_score, cls_id});
                        }
                    }
                }
            }
        }
    }

    // Helper to trim whitespace/CR from strings
    std::string trim_name(const std::string &str)
    {
        size_t first = str.find_first_not_of(" \t\r\n");
        if (std::string::npos == first)
            return "";
        size_t last = str.find_last_not_of(" \t\r\n");
        return str.substr(first, (last - first + 1));
    }

    std::vector<std::string> load_coco_names(const std::string &path)
    {
        std::vector<std::string> names;
        std::ifstream f(path);
        if (!f.is_open())
        {
            std::cerr << "Warning: Could not open " << path << std::endl;
            return names;
        }
        std::string line;
        while (std::getline(f, line))
        {
            std::string clean = trim_name(line);
            if (clean.length() > 0)
                names.push_back(clean);
        }
        return names;
    }

    void loadDebugInput(LayerData &img, const std::string &filename)
    {
        std::ifstream file(filename);
        if (!file.is_open())
            throw std::runtime_error("Cannot open " + filename);
        std::string line;
        std::vector<int> values;
        while (std::getline(file, line))
        {
            if (line.find("SHAPE") != std::string::npos)
                continue;
            std::stringstream ss(line);
            int val;
            while (ss >> val)
                values.push_back(val);
        }
        i8 *dst = (i8 *)img.raw();
        for (int c = 0; c < 3; ++c)
            for (int i = 0; i < 416 * 416; ++i)
                dst[i * 3 + c] = (i8)values[c * 416 * 416 + i];
    }

    void runYolo()
    {
        try
        {
            std::cout << "--- Building YOLOv3-Tiny Model ---" << std::endl;
            Model model = buildYoloV3Tiny("yolov3_tiny_manual_int8.txt", "yolo_data");
            model.allocLayers();

            std::cout << "Model built with " << model.getNumLayers() << " layers." << std::endl;

            LayerParams inputParams{sizeof(i8), {416, 416, 3}};
            LayerData img(inputParams);
            img.allocData();

            std::vector<uint8_t> resized_img;
            bool has_image = false;

            // Try Loading Real Image
            int iw, ih, ch;
            // std::string imgPath = "zf.png";
            std::string imgPath = "giraffe.jpg";
            std::cout << "Loading image: " << imgPath << std::endl;
            uint8_t *raw_img = stbi_load(imgPath.c_str(), &iw, &ih, &ch, 3);

            if (raw_img)
            {
                has_image = true;
                std::cout << "Loaded " << imgPath << " (" << iw << "x" << ih << ")" << std::endl;
                resized_img = resize_bilinear(raw_img, iw, ih, 416, 416);
                stbi_image_free(raw_img);

                // Quantize for model input
                // Get params from first layer
                float Si = yolo_qparams_store[0].S_i;
                int Zi = yolo_qparams_store[0].Z_i;
                image_to_input(resized_img, img, Si, Zi);
            }
            else
            {
                std::cout << "Image not found. Falling back to input_int8.txt..." << std::endl;
                loadDebugInput(img, "input_int8.txt");
                // Create fake resized image for drawing (black) so code doesn't crash
                resized_img.resize(416 * 416 * 3, 0);
            }

            // Inference
            std::cout << "Running Inference..." << std::endl;
            model.inference(img, Layer::InfType::QUANTIZED, yolo_qparams_store.data());

            // Decode
            std::cout << "Decoding detections..." << std::endl;
            if (model.getNumLayers() <= 20)
                throw std::runtime_error("Indices 14/20 invalid.");

            const LayerData &head1 = model.getLayer(14).getOutputData();
            const LayerData &head2 = model.getLayer(20).getOutputData();

            std::vector<Box> detections;
            process_output(head1, MASK_13, 32, detections, 0.4f);
            process_output(head2, MASK_26, 16, detections, 0.4f);

            std::cout << "Total candidates before NMS: " << detections.size() << std::endl;

            // NMS
            std::sort(detections.begin(), detections.end(), [](const Box &a, const Box &b)
                      { return a.score > b.score; });
            std::vector<Box> final_boxes;
            for (auto &b : detections)
            {
                bool keep = true;
                for (auto &f : final_boxes)
                {
                    if (b.class_id == f.class_id && iou(b, f) > 0.4)
                    {
                        keep = false;
                        break;
                    }
                }
                if (keep)
                    final_boxes.push_back(b);
            }

            // Draw & Save
            auto classes = load_coco_names("coco.names");
            std::cout << "Found " << final_boxes.size() << " objects:" << std::endl;

            for (auto &b : final_boxes)
            {
                std::string name = (b.class_id >= 0 && b.class_id < (int)classes.size()) ? classes[b.class_id] : "Unknown";

                std::cout << " - " << name << " (" << (int)(b.score * 100) << "%) "
                          << "at [x=" << (int)b.x << ", y=" << (int)b.y
                          << ", w=" << (int)b.w << ", h=" << (int)b.h << "]" << std::endl;

                // Draw Box
                draw_box(resized_img, 416, 416, (int)b.x, (int)b.y, (int)b.w, (int)b.h, 0, 255, 0);
            }

            if (has_image)
            {
                stbi_write_jpg("prediction.jpg", 416, 416, 3, resized_img.data(), 90);
                std::cout << "Saved visualization to 'prediction.jpg'" << std::endl;
            }

            model.freeLayers();
        }
        catch (std::exception &e)
        {
            std::cerr << "YOLO Error: " << e.what() << std::endl;
        }
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
    ML::runYolo();
    // ML::runTests();
}
#endif
