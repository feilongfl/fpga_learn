onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L blk_mem_gen_v8_4_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.pic_320x240_rgb565 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {pic_320x240_rgb565.udo}

run -all

quit -force
