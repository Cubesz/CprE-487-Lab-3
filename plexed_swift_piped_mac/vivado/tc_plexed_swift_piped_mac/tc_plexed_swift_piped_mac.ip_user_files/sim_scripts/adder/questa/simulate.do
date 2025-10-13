onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib adder_opt

do {wave.do}

view wave
view structure
view signals

do {adder.udo}

run -all

quit -force
