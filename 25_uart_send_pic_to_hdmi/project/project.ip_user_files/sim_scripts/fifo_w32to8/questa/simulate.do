onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_w32to8_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_w32to8.udo}

run -all

quit -force