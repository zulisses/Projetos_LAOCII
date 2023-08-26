view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 2ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/cacheL1/clock 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/wren 
wave create -driver freeze -pattern repeater -initialvalue 1100100 -period 20ps -sequence { 1100100 1100110 1101001 1100101 0000000 1111111  } -repeat forever -range 6 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/endereco 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
wave modify -driver freeze -pattern clock -initialvalue (no value) -period 10ps -dutycycle 50 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
wave create -driver freeze -pattern counter -startvalue 0000000 -endvalue 1111111 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 6 0 -starttime 0ps -endtime 1000ps sim:/cacheL1/data 
WaveExpandAll -1
wave modify -driver freeze -pattern constant -value 1 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
wave modify -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 1000ps Edit:/cacheL1/wren 
WaveCollapseAll -1
wave clipboard restore
