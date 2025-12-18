#pragma once

#include <vector>
#include <string>
#include <iostream>
#include <algorithm>
#include <cmath>
#include "layers/Layer.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

namespace ML
{

    // Bilinear Resize to 416x416 for YOLO
    inline std::vector<uint8_t> resize_bilinear(const uint8_t *src, int w, int h, int target_w, int target_h)
    {
        std::vector<uint8_t> out(target_w * target_h * 3);
        float x_ratio = (float)(w - 1) / target_w;
        float y_ratio = (float)(h - 1) / target_h;

        for (int y = 0; y < target_h; y++)
        {
            for (int x = 0; x < target_w; x++)
            {
                int x_l = (int)(x_ratio * x);
                int y_l = (int)(y_ratio * y);
                int x_h = std::min(x_l + 1, w - 1);
                int y_h = std::min(y_l + 1, h - 1);

                float x_weight = (x_ratio * x) - x_l;
                float y_weight = (y_ratio * y) - y_l;

                for (int c = 0; c < 3; c++)
                {
                    uint8_t a = src[(y_l * w + x_l) * 3 + c];
                    uint8_t b = src[(y_l * w + x_h) * 3 + c];
                    uint8_t c_val = src[(y_h * w + x_l) * 3 + c];
                    uint8_t d = src[(y_h * w + x_h) * 3 + c];

                    float pixel = a * (1 - x_weight) * (1 - y_weight) +
                                  b * x_weight * (1 - y_weight) +
                                  c_val * y_weight * (1 - x_weight) +
                                  d * x_weight * y_weight;

                    out[(y * target_w + x) * 3 + c] = (uint8_t)pixel;
                }
            }
        }
        return out;
    }

    // Convert RGB bytes to Int8 Input Format
    // 1. Normalize (0..255 -> 0.0..1.0)
    // 2. Quantize ( (val/255.0) * Si + Zi )
    inline void image_to_input(const std::vector<uint8_t> &img, LayerData &layerData, float Si, int Zi)
    {
        int8_t *dst = (int8_t *)layerData.raw();
        size_t count = layerData.getParams().flat_count(); // 416*416*3

        if (img.size() != count)
        {
            std::cerr << "Image size mismatch!" << std::endl;
            return;
        }

        for (size_t i = 0; i < count; ++i)
        {
            float norm = img[i] / 255.0f;
            int32_t q;
            if (Si < 1.0f && Si > 0.0f)
                q = (int32_t)std::round(norm / Si) + Zi;
            else
                q = (int32_t)std::round(norm * Si) + Zi;

            if (q > 127)
                q = 127;
            if (q < -128)
                q = -128;
            dst[i] = (int8_t)q;
        }
    }

    // Draw a box
    inline void draw_box(std::vector<uint8_t> &img, int w, int h, int bx, int by, int bw, int bh, int r, int g, int b)
    {
        int x1 = std::max(0, bx - bw / 2);
        int y1 = std::max(0, by - bh / 2);
        int x2 = std::min(w - 1, bx + bw / 2);
        int y2 = std::min(h - 1, by + bh / 2);

        int thickness = 2;
        for (int t = 0; t < thickness; t++)
        {
            int lx1 = std::max(0, x1 - t), rx2 = std::min(w - 1, x2 + t);
            int ty1 = std::max(0, y1 - t), by2 = std::min(h - 1, y2 + t);

            for (int x = lx1; x <= rx2; x++)
            {
                if (ty1 < h)
                {
                    img[(ty1 * w + x) * 3] = r;
                    img[(ty1 * w + x) * 3 + 1] = g;
                    img[(ty1 * w + x) * 3 + 2] = b;
                }
                if (by2 < h)
                {
                    img[(by2 * w + x) * 3] = r;
                    img[(by2 * w + x) * 3 + 1] = g;
                    img[(by2 * w + x) * 3 + 2] = b;
                }
            }
            for (int y = ty1; y <= by2; y++)
            {
                if (lx1 < w)
                {
                    img[(y * w + lx1) * 3] = r;
                    img[(y * w + lx1) * 3 + 1] = g;
                    img[(y * w + lx1) * 3 + 2] = b;
                }
                if (rx2 < w)
                {
                    img[(y * w + rx2) * 3] = r;
                    img[(y * w + rx2) * 3 + 1] = g;
                    img[(y * w + rx2) * 3 + 2] = b;
                }
            }
        }
    }

}