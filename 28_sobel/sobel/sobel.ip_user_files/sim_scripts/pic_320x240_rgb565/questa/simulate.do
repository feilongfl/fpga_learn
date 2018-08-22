onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pic_320x240_rgb565_opt

do {wave.do}

view wave
view structure
view signals

do {pic_320x240_rgb565.udo}

run -all

quit -force
