onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib mult_q32d0_q0d18_opt

do {wave.do}

view wave
view structure
view signals

do {mult_q32d0_q0d18.udo}

run -all

quit -force
