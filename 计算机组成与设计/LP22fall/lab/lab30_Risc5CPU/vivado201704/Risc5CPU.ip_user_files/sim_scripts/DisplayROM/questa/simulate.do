onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DisplayROM_opt

do {wave.do}

view wave
view structure
view signals

do {DisplayROM.udo}

run -all

quit -force
