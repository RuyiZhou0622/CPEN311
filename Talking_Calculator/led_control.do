onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_led_control/DUT/clk
add wave -noupdate -radix decimal /tb_led_control/DUT/audio_data
add wave -noupdate /tb_led_control/DUT/led_out
add wave -noupdate -radix decimal /tb_led_control/DUT/abs_data
add wave -noupdate -radix binary /tb_led_control/DUT/counter
add wave -noupdate -radix decimal /tb_led_control/DUT/sum
add wave -noupdate -radix decimal /tb_led_control/DUT/result
add wave -noupdate /tb_led_control/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5124 ps} 0}
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
WaveRestoreZoom {5097 ps} {5347 ps}
