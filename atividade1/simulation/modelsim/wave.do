onerror {resume}
quietly virtual signal -install sim:/atividade1 { sim:/atividade1/SW[7:0]} data
quietly virtual signal -install sim:/atividade1 { sim:/atividade1/SW[12:8]} address
quietly virtual signal -install sim:/atividade1 {sim:/atividade1/SW[17]  } clock
quietly virtual signal -install sim:/atividade1 {sim:/atividade1/SW[16]  } wren
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /atividade1/data
add wave -noupdate -radix decimal /atividade1/address
add wave -noupdate -radix decimal /atividade1/clock
add wave -noupdate -radix decimal /atividade1/wren
add wave -noupdate -radix decimal /atividade1/saida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {420 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern repeater -initialvalue 010000000100000100 -period 50ps -sequence { 010000000100000100 110000000100000100 010000001100000110 110000001100000110 000000000100000000 100000000100000000 000000001100000000 100000001100000000  } -repeat never -range 17 0 -starttime 0ps -endtime 1000ps sim:/atividade1/SW 
WaveCollapseAll -1
wave clipboard restore
