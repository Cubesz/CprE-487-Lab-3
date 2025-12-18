#include "YoloLoader.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <cmath>
#include <vector>

#ifdef _WIN32
#include <direct.h>
#define MKDIR(path) _mkdir(path)
#else
#include <sys/stat.h>
#define MKDIR(path) mkdir(path, 0777)
#endif

namespace ML
{

    static std::string trim(const std::string &str)
    {
        size_t first = str.find_first_not_of(" \t\r\n");
        if (std::string::npos == first)
            return "";
        size_t last = str.find_last_not_of(" \t\r\n");
        return str.substr(first, (last - first + 1));
    }

    bool YoloLoader::load(const std::string &filename, const std::string &outputDir)
    {
        std::cout << "[YoloLoader] Opening config file: " << filename << std::endl;
        std::ifstream file(filename);
        if (!file.is_open())
        {
            std::cerr << "[YoloLoader] Error: Failed to open " << filename << std::endl;
            return false;
        }

        MKDIR(outputDir.c_str());

        std::string line;
        YoloLayerConfig current;
        bool in_layer = false;
        int layer_idx = 0;

        try
        {
            while (std::getline(file, line))
            {
                std::string trimmed = trim(line);
                if (trimmed.empty() || trimmed[0] == '#')
                    continue;

                if (trimmed.find("[LAYER]") != std::string::npos)
                {
                    in_layer = true;
                    current = YoloLayerConfig();
                }
                else if (trimmed.find("[/LAYER]") != std::string::npos)
                {
                    if (in_layer)
                    {
                        if (current.stride == 0)
                            current.stride = 1;
                        layers.push_back(current);
                        layer_idx++;
                        in_layer = false;
                    }
                }
                else if (in_layer)
                {
                    size_t sep_pos = trimmed.find(':');
                    if (sep_pos == std::string::npos)
                        continue;

                    std::string key = trim(trimmed.substr(0, sep_pos));
                    std::string val_str = trim(trimmed.substr(sep_pos + 1));

                    if (key == "NAME")
                        current.name = val_str;
                    else if (key == "TYPE")
                        current.type = val_str;
                    else if (key == "INPUT_SCALE_Si")
                        current.Si = std::stof(val_str);
                    else if (key == "INPUT_ZERO_POINT_zi")
                        current.zi = std::stoi(val_str);
                    else if (key == "WEIGHT_SCALE_Sw")
                        current.Sw = std::stof(val_str);
                    else if (key == "STRIDE")
                        current.stride = std::stoi(val_str);
                    else if (key == "WEIGHTS_SHAPE")
                    {
                        for (char &c : val_str)
                            if (c == '[' || c == ']' || c == ',')
                                c = ' ';
                        std::stringstream sss(val_str);
                        sss >> current.out_ch >> current.in_ch >> current.k_h >> current.k_w;
                    }
                    else if (key == "WEIGHTS_INT8")
                    {
                        std::cout << "[YoloLoader] Layer " << layer_idx << " weights... ";
                        std::flush(std::cout);

                        std::vector<int8_t> src_weights;
                        src_weights.reserve(val_str.length() / 3);
                        std::stringstream w_ss(val_str);
                        int val;
                        while (w_ss >> val)
                            src_weights.push_back((int8_t)val);

                        // Text Format: OC, IC, KH, KW
                        // Engine Format: KW, KH, IC, OC

                        int OC = current.out_ch;
                        int IC = current.in_ch;
                        int KH = current.k_h;
                        int KW = current.k_w;

                        std::vector<int8_t> dst_weights(src_weights.size());

                        for (int oc = 0; oc < OC; ++oc)
                        {
                            for (int ic = 0; ic < IC; ++ic)
                            {
                                for (int kh = 0; kh < KH; ++kh)
                                {
                                    for (int kw = 0; kw < KW; ++kw)
                                    {
                                        // Source Index (OC, IC, KH, KW)
                                        int src_idx = oc * (IC * KH * KW) + ic * (KH * KW) + kh * KW + kw;

                                        // Destination Index (OC, IC, KH, KW)
                                        int dst_idx = oc * (IC * KH * KW) + ic * (KH * KW) + kh * KW + kw;

                                        dst_weights[dst_idx] = src_weights[src_idx];
                                    }
                                }
                            }
                        }

                        std::string binPath = outputDir + "/layer_" + std::to_string(layer_idx) + "_weights.bin";
                        std::ofstream binFile(binPath, std::ios::binary);
                        binFile.write((char *)dst_weights.data(), dst_weights.size() * sizeof(int8_t));
                        current.weightsPath = binPath;
                        std::cout << "Done (Transposed)." << std::endl;
                    }
                    else if (key == "BIAS_FLOAT")
                    {
                        if (val_str != "NONE")
                        {
                            std::stringstream b_ss(val_str);
                            std::vector<int32_t> biases;
                            float b;

                            // Reciprocal Scale Logic
                            double scale_acc = (double)current.Si * (double)current.Sw;

                            while (b_ss >> b)
                            {
                                biases.push_back((int32_t)std::round(b * scale_acc));
                            }

                            std::string binPath = outputDir + "/layer_" + std::to_string(layer_idx) + "_biases.bin";
                            std::ofstream binFile(binPath, std::ios::binary);
                            binFile.write((char *)biases.data(), biases.size() * sizeof(int32_t));
                            current.biasPath = binPath;
                        }
                    }
                }
            }
        }
        catch (const std::exception &e)
        {
            std::cerr << "\n[YoloLoader] EXCEPTION: " << e.what() << std::endl;
            return false;
        }
        std::cout << "[YoloLoader] Loaded " << layers.size() << " layers." << std::endl;
        return true;
    }

}