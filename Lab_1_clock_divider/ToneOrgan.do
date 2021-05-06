onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_ToneOrgan/CLOCK_50
add wave -noupdate /testbench_ToneOrgan/SW
add wave -noupdate /testbench_ToneOrgan/Sample_Clk_Signal
add wave -noupdate /testbench_ToneOrgan/Do_clock
add wave -noupdate /testbench_ToneOrgan/Re_clock
add wave -noupdate /testbench_ToneOrgan/Mi_clock
add wave -noupdate /testbench_ToneOrgan/Fa_clock
add wave -noupdate /testbench_ToneOrgan/So_clock
add wave -noupdate /testbench_ToneOrgan/La_clock
add wave -noupdate /testbench_ToneOrgan/Si_clock
add wave -noupdate /testbench_ToneOrgan/Do2_clock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1600243 ps} 0}
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
