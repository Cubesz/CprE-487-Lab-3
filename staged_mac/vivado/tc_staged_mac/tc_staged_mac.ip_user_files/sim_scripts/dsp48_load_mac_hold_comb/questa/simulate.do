onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib dsp48_load_mac_hold_comb_opt

do {wave.do}

view wave
view structure
view signals

do {dsp48_load_mac_hold_comb.udo}

run -all

quit -force
