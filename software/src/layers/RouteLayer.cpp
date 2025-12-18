#include "RouteLayer.h"
#include <cstring>

// YOLO has 2 detection heads, one for smaller and another for larger object.s

namespace ML
{

    void RouteLayer::computeQuantized(const LayerData &ignored, QParams qparam) const
    {

        i8 *out_ptr = (i8 *)getOutputData().raw();

        // Dimensions
        size_t H = getOutputParams().dims[1];
        size_t W = getOutputParams().dims[0];

        // Single Source (Pass-through)
        if (sources.size() == 1)
        {
            const LayerData &src = sources[0]->getOutputData();
            size_t bytes = src.getParams().byte_size();
            std::memcpy(out_ptr, src.raw(), bytes);
            return;
        }

        // Multi-Source
        // We assume H and W match, and concat channels.
        size_t out_offset = 0;

        // Get pointers and channel counts for sources
        const i8 *src0_ptr = (const i8 *)sources[0]->getOutputData().raw();
        size_t c0 = sources[0]->getOutputParams().dims[2];

        const i8 *src1_ptr = (const i8 *)sources[1]->getOutputData().raw();
        size_t c1 = sources[1]->getOutputParams().dims[2];

        // For every pixel, write src0 channels then src1 channels
        for (size_t i = 0; i < H * W; ++i)
        {
            // Copy chunk from Source 0
            std::memcpy(out_ptr + out_offset, src0_ptr + i * c0, c0);
            out_offset += c0;

            // Copy chunk from Source 1
            std::memcpy(out_ptr + out_offset, src1_ptr + i * c1, c1);
            out_offset += c1;
        }
    }

}