onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_Flash_handle/DUT/syncclk72
add wave -noupdate /tb_Flash_handle/DUT/clk50M
add wave -noupdate /tb_Flash_handle/DUT/done_signal
add wave -noupdate /tb_Flash_handle/DUT/silent
add wave -noupdate /tb_Flash_handle/DUT/flash_mem_readdata
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/start_address
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/end_address
add wave -noupdate /tb_Flash_handle/DUT/done
add wave -noupdate /tb_Flash_handle/DUT/flash_mem_read
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/address
add wave -noupdate /tb_Flash_handle/DUT/audio_out
add wave -noupdate /tb_Flash_handle/DUT/interrupt
add wave -noupdate /tb_Flash_handle/DUT/start
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/reset
add wave -noupdate /tb_Flash_handle/DUT/state
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/start_word_addr
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/end_word_addr
add wave -noupdate /tb_Flash_handle/DUT/temp_data
add wave -noupdate -radix decimal /tb_Flash_handle/DUT/test_address
add wave -noupdate /tb_Flash_handle/DUT/hz_72
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {650005 ps} 0}
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
WaveRestoreZoom {649995 ps} {650059 ps}
