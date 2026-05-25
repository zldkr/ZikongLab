clc
clear
close all

model='freq_response_pendulum';
new_system(model)
open_system(model)

add_block('simulink/Sources/Step',[model '/Step'],'Position',[30 100 60 130])
add_block('simulink/Math Operations/Sum',[model '/Sum'],'Inputs','+-','Position',[110 95 135 135])
add_block('simulink/Math Operations/Gain',[model '/Gain'],'Gain','98.57','Position',[180 100 230 130])
add_block('simulink/Continuous/Transfer Fcn',[model '/Gc'],'Numerator','[0.0817065 1]','Denominator','[0.00813 1]','Position',[280 95 390 135])
add_block('simulink/Continuous/Transfer Fcn',[model '/G'],'Numerator','[4.9]','Denominator','[1 0 -48.3]','Position',[440 95 550 135])
add_block('simulink/Sinks/Scope',[model '/Scope'],'Position',[620 95 650 125])

add_line(model,'Step/1','Sum/1')
add_line(model,'Sum/1','Gain/1')
add_line(model,'Gain/1','Gc/1')
add_line(model,'Gc/1','G/1')
add_line(model,'G/1','Scope/1')
add_line(model,'G/1','Sum/2','autorouting','on')

set_param(model,'StopTime','2')
set_param(model,'Solver','ode45')

save_system(model)
open_system(model)