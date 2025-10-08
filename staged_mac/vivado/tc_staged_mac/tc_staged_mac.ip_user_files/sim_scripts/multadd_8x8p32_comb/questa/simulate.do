onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib multadd_8x8p32_comb_opt

do {wave.do}

view wave
view structure
view signals

do {multadd_8x8p32_comb.udo}

run -all

quit -force
