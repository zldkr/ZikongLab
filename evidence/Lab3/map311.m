clc
clear
close all

s=tf('s');
G=2/(s*(0.3*s+2)*(0.2*s+1));

figure(1)
bode(G)
grid on
title('系统Bode图')

[GM,PM,Wcg,Wcp]=margin(G);
GM_dB=20*log10(GM);

fprintf('幅值裕度 GM = %.4f\n',GM)
fprintf('幅值裕度 GM_dB = %.4f dB\n',GM_dB)
fprintf('相角裕度 PM = %.4f deg\n',PM)
fprintf('相角穿越频率 Wcg = %.4f rad/s\n',Wcg)
fprintf('幅值穿越频率 Wcp = %.4f rad/s\n',Wcp)

T=feedback(G,1);

figure(2)
step(T)
grid on
title('闭环系统单位阶跃响应')

pole(T)