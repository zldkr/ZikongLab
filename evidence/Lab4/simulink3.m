model = 'pendulum_poleplace_sim';
if bdIsLoaded(model)
    close_system(model,0)
end
new_system(model)
open_system(model)

assignin('base','A',A)
assignin('base','B',B)
assignin('base','K',K)
assignin('base','Nbar',Nbar)

add_block('simulink/Sources/Step',[model '/Step'])
set_param([model '/Step'],'Time','0','Before','0','After','0.1','Position',[40 90 70 120])

add_block('simulink/Math Operations/Gain',[model '/Nbar'])
set_param([model '/Nbar'],'Gain','Nbar','Position',[120 85 175 125])

add_block('simulink/Math Operations/Sum',[model '/Sum'])
set_param([model '/Sum'],'Inputs','++','Position',[230 95 255 125])

add_block('simulink/Continuous/State-Space',[model '/Plant'])
set_param([model '/Plant'],'A','A','B','B','C','eye(4)','D','zeros(4,1)','Position',[320 70 430 150])

add_block('simulink/Math Operations/Gain',[model '/-K'])
set_param([model '/-K'],'Gain','-K','Multiplication','Matrix(K*u)','Position',[500 185 580 225])

add_block('simulink/Signal Routing/Demux',[model '/Demux'])
set_param([model '/Demux'],'Outputs','4','Position',[500 65 505 155])

add_block('simulink/Sinks/Scope',[model '/x Scope'])
set_param([model '/x Scope'],'Position',[610 50 660 90])

add_block('simulink/Sinks/Scope',[model '/phi Scope'])
set_param([model '/phi Scope'],'Position',[610 120 660 160])

add_block('simulink/Sinks/To Workspace',[model '/x_to_workspace'])
set_param([model '/x_to_workspace'],'VariableName','x_sim','SaveFormat','StructureWithTime','Position',[610 85 700 115])

add_block('simulink/Sinks/To Workspace',[model '/phi_to_workspace'])
set_param([model '/phi_to_workspace'],'VariableName','phi_sim','SaveFormat','StructureWithTime','Position',[610 155 710 185])

add_line(model,'Step/1','Nbar/1')
add_line(model,'Nbar/1','Sum/1')
add_line(model,'Sum/1','Plant/1')
add_line(model,'Plant/1','Demux/1')
add_line(model,'Plant/1','-K/1','autorouting','on')
add_line(model,'-K/1','Sum/2','autorouting','on')
add_line(model,'Demux/1','x Scope/1')
add_line(model,'Demux/1','x_to_workspace/1')
add_line(model,'Demux/3','phi Scope/1')
add_line(model,'Demux/3','phi_to_workspace/1')

set_param(model,'StopTime','5')
save_system(model)
sim(model)
