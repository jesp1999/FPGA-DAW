onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib instrument_text_image_rom_opt

do {wave.do}

view wave
view structure
view signals

do {instrument_text_image_rom.udo}

run -all

quit -force
