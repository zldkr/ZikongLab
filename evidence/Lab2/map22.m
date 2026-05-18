clc;
clear;
close all;

s = tf('s');

G = 4.9/(s^2 - 48.3);

K = 72.698;
Gc = K*(s + 7)/(s + 24);

Go = Gc * G;

figure(1);
rlocus(Go);
grid on;
title('校正后系统根轨迹');
xlabel('Real Axis');
ylabel('Imaginary Axis');

Gcl = feedback(Go, 1);

figure(2);
step(Gcl);
grid on;
title('校正后系统单位阶跃响应曲线');
xlabel('Time / s');
ylabel('Amplitude');

info = stepinfo(Gcl);

disp('校正后系统时域性能指标：');
disp(info);

fprintf('超调量 Mp = %.2f %%\n', info.Overshoot);
fprintf('调节时间 ts = %.3f s\n', info.SettlingTime);

yss = dcgain(Gcl);
ess = 1 - yss;

fprintf('稳态值 yss = %.4f\n', yss);
fprintf('稳态误差 ess = %.4f\n', ess);