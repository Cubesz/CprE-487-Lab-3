#include "RouteLayer.h"
#include <cstring>

// YOLO has 2 detection heads, one for smaller and another for larger object.s

namespace ML
{

    void RouteLayer::computeQuantized(const LayerData &ignored, QParams qparam) const
    {
        i8 *out_ptr = (i8 *)getOutputData().raw();
        size_t out_offset = 0;

        for (const auto &src_layer : sources)
        {
            const LayerData &src_data = src_layer->getOutputData();
            size_t bytes = src_data.getParams().byte_size();

            std::memcpy(out_ptr + out_offset, src_data.raw(), bytes);
            out_offset += bytes;
        }
    }

}