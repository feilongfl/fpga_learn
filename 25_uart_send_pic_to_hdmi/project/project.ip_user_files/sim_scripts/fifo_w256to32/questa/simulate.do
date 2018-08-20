onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_w256to32_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_w256to32.udo}

run -all

quit -force
