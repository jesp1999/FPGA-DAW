onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib track0_text_image_rom_opt

do {wave.do}

view wave
view structure
view signals

do {track0_text_image_rom.udo}

run -all

quit -force
