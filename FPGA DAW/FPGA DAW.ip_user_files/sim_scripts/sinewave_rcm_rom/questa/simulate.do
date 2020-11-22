onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib sinewave_rcm_rom_opt

do {wave.do}

view wave
view structure
view signals

do {sinewave_rcm_rom.udo}

run -all

quit -force
