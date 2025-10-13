onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib multer_opt

do {wave.do}

view wave
view structure
view signals

do {multer.udo}

run -all

quit -force
