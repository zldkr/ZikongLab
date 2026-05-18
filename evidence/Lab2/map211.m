clc;
clear;
close all;

s = tf('s');

% 开环传递函数，不写K，rlocus会自动把K作为可变根轨迹增益
G = 1 / ((s + 14)*(s^2 + 2*s + 1));

figure;
rlocus(G);
grid on;
title('G(s)=K/[(s+14)(s^2+2s+1)] 的根轨迹');
xlabel('Real Axis');
ylabel('Imaginary Axis');

Kcrit = 450;
disp('系统稳定时根轨迹增益范围为：');
disp('0 < K < 450');

K = 100;
sys_cl = feedback(K*G, 1);

disp('K=100时闭环极点为：');
disp(pole(sys_cl));

figure;
step(sys_cl);
grid on;
title('K=100时闭环系统单位阶跃响应');
xlabel('Time / s');
ylabel('Amplitude');