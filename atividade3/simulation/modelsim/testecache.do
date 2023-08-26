view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/cacheL1/clock_in 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/wren_in 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/hit_menPrin_in 
wave create -driver freeze -pattern repeater -initialvalue 10100 -period 50ps -sequence { 10100 10110 10101  } -repeat forever -range 4 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/endereco_in 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -range 7 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/data_in 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 0 -range 7 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/data_memPrin_in 
WaveExpandAll -1
wave modify -driver freeze -pattern repeater -initialvalue 10100 -period 50ps -sequence { 10100 10110 11001 10101  } -repeat forever -range 4 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/endereco_in 
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren_in 
wave modify -driver freeze -pattern random -initialvalue 00000000 -period 30ps -random_type Uniform -seed 5 -range 7 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/data_in 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren_in 
WaveCollapseAll -1
wave clipboard restore
