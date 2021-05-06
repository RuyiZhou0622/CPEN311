onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_Flash_handle/DUT/clk50M
add wave -noupdate /tb_Flash_handle/DUT/syncclk22K
add wave -noupdate /tb_Flash_handle/DUT/direction
add wave -noupdate /tb_Flash_handle/DUT/done_signal
add wave -noupdate /tb_Flash_handle/DUT/kbd_start
add wave -noupdate /tb_Flash_handle/DUT/flash_mem_readdata
add wave -noupdate /tb_Flash_handle/DUT/flash_mem_read
add wave -noupdate /tb_Flash_handle/DUT/address
add wave -noupdate /tb_Flash_handle/DUT/audio_out
add wave -noupdate /tb_Flash_handle/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2982101 ps} 0}
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
WaveRestoreZoom {0 ps} {64 ns}
