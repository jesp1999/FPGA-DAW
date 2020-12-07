onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib octave_text_image_rom_opt

do {wave.do}

view wave
view structure
view signals

do {octave_text_image_rom.udo}

run -all

quit -force