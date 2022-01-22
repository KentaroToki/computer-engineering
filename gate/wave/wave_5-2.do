onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim/pr
add wave -noupdate /sim/mar
add wave -noupdate /sim/ir
add wave -noupdate /sim/gr
add wave -noupdate /sim/sc
add wave -noupdate /sim/ram20
add wave -noupdate /sim/ram21
add wave -noupdate /sim/ram22
add wave -noupdate /sim/ram23
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {78862661 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {5250 us}
