onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+dsp48_custom_mult_add_piped -L xbip_dsp48_wrapper_v3_0_4 -L xbip_utils_v3_0_10 -L xbip_pipe_v3_0_6 -L xbip_dsp48_macro_v3_0_17 -L xil_defaultlib -L secureip -O5 xil_defaultlib.dsp48_custom_mult_add_piped

do {wave.do}

view wave
view structure

do {dsp48_custom_mult_add_piped.udo}

run -all

endsim

quit -force
