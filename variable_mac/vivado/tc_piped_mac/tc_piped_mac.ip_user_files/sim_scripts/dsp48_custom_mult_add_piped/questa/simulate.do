onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib dsp48_custom_mult_add_piped_opt

do {wave.do}

view wave
view structure
view signals

do {dsp48_custom_mult_add_piped.udo}

run -all

quit -force
