clc
clear
close all

s=tf('s');

G=4.9/(s^2-48.3);

figure(1)
bode(G)
grid on
title('直线一级倒立摆系统Bode图')

figure(2)
nyquist(G)
grid on
title('直线一级倒立摆系统Nyquist图')

p=pole(G);
z=zero(G);

disp('开环系统零点：')
disp(z)

disp('开环系统极点：')
disp(p)

[GM,PM,Wcg,Wcp]=margin(G);

if isinf(GM)
    GM_dB=Inf;
else
    GM_dB=20*log10(GM);
end

fprintf('幅值裕度 GM = %.4f\n',GM)
fprintf('幅值裕度 GM_dB = %.4f dB\n',GM_dB)
fprintf('相角裕度 PM = %.4f deg\n',PM)
fprintf('相角穿越频率 Wcg = %.4f rad/s\n',Wcg)
fprintf('幅值穿越频率 Wcp = %.4f rad/s\n',Wcp)

T=feedback(G,1);

figure(3)
step(T)
grid on
title('单位负反馈闭环系统阶跃响应')

disp('单位负反馈闭环系统极点：')
disp(pole(T))