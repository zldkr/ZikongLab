clc
clear
close all

s=tf('s');
K=98.57;
G=4.9/(s^2-48.3);
G0=K*G;

figure(1)
bode(G0)
grid on
title('增加开环增益后系统Bode图')

figure(2)
nyquist(G0)
grid on
title('增加开环增益后系统Nyquist图')

[GM,PM,Wcg,Wcp]=margin(G0);
GM_dB=20*log10(GM);

fprintf('幅值裕度 GM = %.4f\n',GM)
fprintf('幅值裕度 GM_dB = %.4f dB\n',GM_dB)
fprintf('相角裕度 PM = %.4f deg\n',PM)
fprintf('相角穿越频率 Wcg = %.4f rad/s\n',Wcg)
fprintf('幅值穿越频率 Wcp = %.4f rad/s\n',Wcp)