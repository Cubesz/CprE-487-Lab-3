

import numpy as np

dense_weights = np.fromfile("data/quant/param_layer_6/weights_8q.bin", dtype=np.int8).reshape((4, 4, 128, 256))

# 1x1x256
# 1x1x256x200
# 1x1x200

dense_weights_2 = np.fromfile("data/quant/param_layer_7/weights_8q.bin", dtype=np.int8).reshape((1, 1, 256, 200))
transposed_dense_weights_2 = np.transpose(dense_weights_2, (3, 2, 0, 1))
transposed_dense_weights_2.astype(np.int8).tofile("data/quant_t_new/layer7_dense_weights_8q_t_new.bin")


transposed_dense_weights = np.transpose(dense_weights, (3, 2, 0, 1))

#transposed_dense_weights.astype(np.int8).tofile("data/quant_t_new/layer6_dense_weights_8q_t_new.bin")

opened = np.fromfile("data/quant_t_new/layer6_weights_8q_t_new.bin", dtype=np.int8).reshape((256, 128, 4, 4))

if (np.array_equal(transposed_dense_weights, opened)):
        print("SSame")

filters_1 = np.fromfile("data/quant/param_layer_1/weights_8q.bin", dtype=np.int8).reshape((5, 5, 32, 32))

filters_2 = np.fromfile("data/quant_t_new/layer1_weights_8q_t_new.bin", dtype=np.int8).reshape((32, 32, 5, 5))

new_filters = np.transpose(filters_1, (3, 2, 0, 1))
#new_filters.astype(np.int8).tofile("data/exp.bin")

#new_weights_loaded = np.fromfile("data/exp.bin", dtype=np.int8).reshape((32, 32, 5, 5))

transposed_filters_2 = np.transpose(filters_2, (2, 3, 1, 0))

filters_1_flat = filters_1.flatten()
filters_2_flat = filters_2.flatten()

if (np.array_equal(filters_1,transposed_filters_2)):
    print("Same")

for filt in range(0, 32):
    for chan in range(0, 32):
        for row in range(0, 5):
            for col in range(0, 5):

                #if (new_weights_loaded[filt][chan][row][col] != filters_1[col][row][chan][filt]):
                    #print("not same")

                w0 = filters_1[col][row][chan][filt]
                w1 = filters_2[filt][chan][row][col]
                #if (w0 != w1):
                    #print("not same")

                w0_f = filters_1_flat[col* 5 * 32 * 32 + row* 32 * 32 + chan * 32 + filt]
                w1_f = filters_2_flat[filt * 32 * 5 * 5 + chan * 5 * 5 + row * 5 + col]
                #if (w0_f != w1_f):
                    #print("not index same")

