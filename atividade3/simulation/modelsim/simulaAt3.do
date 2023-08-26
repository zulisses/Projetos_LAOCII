view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/atividade3/clock_in 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/atividade3/wren_in 
wave create -driver freeze -pattern repeater -initialvalue 10100 -period 50ps -sequence { 10100 10110 11001 10101  } -repeat forever -range 4 0 -starttime 0ps -endtime 1000ps sim:/atividade3/endereco_in 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -range 7 0 -starttime 0ps -endtime 1000ps sim:/atividade3/data_in 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
