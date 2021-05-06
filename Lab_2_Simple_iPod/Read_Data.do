onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_Read_Data/DUT/clk50M
add wave -noupdate /tb_Read_Data/DUT/flash_mem_read
add wave -noupdate /tb_Read_Data/DUT/flash_mem_waitrequest
add wave -noupdate /tb_Read_Data/DUT/flash_mem_readdatavalid
add wave -noupdate /tb_Read_Data/DUT/state
add wave -noupdate /tb_Read_Data/DUT/done_signal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {122 ps}
