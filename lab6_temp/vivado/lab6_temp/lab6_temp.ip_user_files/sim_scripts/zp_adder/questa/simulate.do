onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib zp_adder_opt

do {wave.do}

view wave
view structure
view signals

do {zp_adder.udo}

run -all

quit -force
