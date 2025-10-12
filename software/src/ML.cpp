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

#ifdef ZEDBOARD
#include <file_transfer/file_transfer.h>
#include "Acc.h"
#endif

namespace ML
{

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

    void runTests()
    {
        #ifdef ZEDBOARD
        testFPGAMac();
        #endif
        // // Base input data path (determined from current directory of where you are running the command)
        // Path basePath("data"); // May need to be altered for zedboards loading from SD Cards
        // Path modelPath = basePath / "model";

        // // TODO: TEST EACH LAYER INDIVISUALLY
        // // Test first layer
        // checkConvLayer(
        //     basePath, 0,
        //     LayerParams{sizeof(fp32), {64, 64, 3}},                                    // Input Data
        //     LayerParams{sizeof(fp32), {60, 60, 32}},                                   // Output Data
        //     LayerParams{sizeof(fp32), {5, 5, 3, 32}, modelPath / "conv1_weights.bin"}, // Weights
        //     LayerParams{sizeof(fp32), {32}, modelPath / "conv1_biases.bin"}            // Bias
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
