onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_divider/clkin
add wave -noupdate /testbench_divider/Do
add wave -noupdate /testbench_divider/Re
add wave -noupdate /testbench_divider/Mi
add wave -noupdate /testbench_divider/Fa
add wave -noupdate /testbench_divider/So
add wave -noupdate /testbench_divider/La
add wave -noupdate /testbench_divider/Si
add wave -noupdate /testbench_divider/Do2
add wave -noupdate /testbench_divider/oneHz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1822175 ps} 0}
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
WaveRestoreZoom {0 ps} {2048 ns}
