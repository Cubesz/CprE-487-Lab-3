#pragma once
#include <string>
#include <vector>
#include <algorithm>
#include "Types.h"
#include "layers/QuantParams.h"
#include "layers/Layer.h"

namespace ML
{

    struct YoloLayerConfig
    {
        std::string name;
        std::string type = "CONV"; // Default to CONV

        float Si = 0.0f;
        int32_t zi = 0;
        float Sw = 0.0f;

        int out_ch = 0, in_ch = 0, k_h = 0, k_w = 0;
        int stride = 1;

        std::string weightsPath;
        std::string biasPath;
    };

    class YoloLoader
    {
    public:
        bool load(const std::string &filename, const std::string &outputDir);

        // Look up config by name
        const YoloLayerConfig *getLayerByName(const std::string &name) const
        {
            for (const auto &l : layers)
            {
                if (l.name == name)
                    return &l;
            }
            return nullptr;
        }

    private:
        std::vector<YoloLayerConfig> layers;
    };

}