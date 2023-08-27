view wave 
wave clipboard store
wave create -pattern clock -initialvalue StX -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/atividade3/clock_in 
wave modify -driver expectedOutput -pattern clock -initialvalue StX -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/atividade3/clock_in 
wave create -pattern clock -initialvalue StX -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/atividade3/wren_in 
wave modify -driver expectedOutput -pattern clock -initialvalue 1 -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/atividade3/wren_in 
wave create -pattern repeater -initialvalue 01100011 -period 50ps -sequence { 01100011 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000  } -repeat forever -range 7 0 -starttime 0ps -endtime 1000ps sim:/atividade3/data_in 
WaveExpandAll -1
wave create -pattern constant -value 10100 -range 4 0 -starttime 0ps -endtime 1000ps sim:/atividade3/endereco_in 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
