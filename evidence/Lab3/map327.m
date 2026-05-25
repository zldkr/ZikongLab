clc
clear
close all

s=tf('s');
K=98.57;
a=10.05;
T=0.00813;

G=4.9/(s^2-48.3);
G0=K*G;
Gc=(a*T*s+1)/(T*s+1);
Gk=Gc*G0;
Phi=feedback(Gk,1);

figure(1)
margin(Gk)
grid on
title('校正后系统Bode图')

figure(2)
nyquist(Gk)
grid on
title('校正后系统Nyquist图')

figure(3)
step(Phi)
grid on
title('校正后系统单位阶跃响应')

[GM,PM,Wcg,Wcp]=margin(Gk);
GM_dB=20*log10(GM);
info=stepinfo(Phi);

fprintf('幅值裕度 GM = %.4f\n',GM)
fprintf('幅值裕度 GM_dB = %.4f dB\n',GM_dB)
fprintf('相角裕度 PM = %.4f deg\n',PM)
fprintf('相角穿越频率 Wcg = %.4f rad/s\n',Wcg)
fprintf('幅值穿越频率 Wcp = %.4f rad/s\n',Wcp)

disp('闭环阶跃响应指标：')
disp(info)

disp('校正后开环传递函数：')
Gk

disp('校正后闭环传递函数：')
Phi

disp('校正后闭环极点：')
pole(Phi)