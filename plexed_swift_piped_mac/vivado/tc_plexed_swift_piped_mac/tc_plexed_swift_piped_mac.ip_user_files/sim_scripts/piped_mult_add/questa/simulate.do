onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib piped_mult_add_opt

do {wave.do}

view wave
view structure
view signals

do {piped_mult_add.udo}

run -all

quit -force
