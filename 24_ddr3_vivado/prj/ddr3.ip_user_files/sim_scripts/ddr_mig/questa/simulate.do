onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ddr_mig_opt

do {wave.do}

view wave
view structure
view signals

do {ddr_mig.udo}

run -all

quit -force
