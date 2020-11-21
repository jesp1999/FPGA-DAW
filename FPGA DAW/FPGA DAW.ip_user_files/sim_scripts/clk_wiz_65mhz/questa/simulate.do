onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clk_wiz_65mhz_opt

do {wave.do}

view wave
view structure
view signals

do {clk_wiz_65mhz.udo}

run -all

quit -force
