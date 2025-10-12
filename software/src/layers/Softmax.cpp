#include "Softmax.h"
#include <vector>
#include <cmath>
#include <limits>
#include <algorithm>

namespace ML
{

    SoftmaxLayer::SoftmaxLayer(const LayerParams &inParams, const LayerParams &outParams)
        : Layer(inParams, outParams, LayerType::SOFTMAX) {}

    void SoftmaxLayer::computeNaive(const LayerData &dataIn) const
    {
        const auto &inParams = getInputParams();
        const size_t vectorSize = inParams.dims[0];

        const float *input = static_cast<const float *>(dataIn.raw());
        float *output = static_cast<float *>(this->getOutputData().raw());

        float max_logit = std::numeric_limits<float>::lowest();
        for (size_t i = 0; i < vectorSize; ++i)
        {
            max_logit = (max_logit > input[i]) ? max_logit : input[i];
        }

        std::vector<float> temp_exp(vectorSize);
        float sum_exp = 0.0f;

        for (size_t i = 0; i < vectorSize; ++i)
        {
            temp_exp[i] = std::exp(input[i] - max_logit);
            sum_exp += temp_exp[i];
        }

        for (size_t i = 0; i < vectorSize; ++i)
        {
            output[i] = temp_exp[i] / sum_exp;
        }
    }

} // namespace ML