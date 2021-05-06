onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/clk50M
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/kbd_input
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/equal_done
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/select_key
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/check_equal
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/state
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/num_1
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/num_2
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/sign
add wave -noupdate -radix hexadecimal /tb_keyboard/DUT/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33 ps} 0}
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
WaveRestoreZoom {0 ps} {252 ps}
