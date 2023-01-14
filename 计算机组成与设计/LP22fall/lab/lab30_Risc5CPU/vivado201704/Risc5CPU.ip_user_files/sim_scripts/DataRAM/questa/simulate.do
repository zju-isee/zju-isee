onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DataRAM_opt

do {wave.do}

view wave
view structure
view signals

do {DataRAM.udo}

run -all

quit -force
