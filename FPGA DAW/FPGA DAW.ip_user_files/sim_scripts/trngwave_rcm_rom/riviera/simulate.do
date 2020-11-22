onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+trngwave_rcm_rom -L xpm -L blk_mem_gen_v8_4_4 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.trngwave_rcm_rom xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {trngwave_rcm_rom.udo}

run -all

endsim

quit -force
