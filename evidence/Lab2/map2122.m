%% 2.1.2 直线一级倒立摆系统根轨迹分析
%% 程序2：绘制未校正前系统单位阶跃响应曲线

clc;
clear;
close all;

s = tf('s');

% 直线一级倒立摆摆杆角度传递函数
G = 4.9/(s^2 - 48.3);

% 绘制单位阶跃响应
figure;
step(G);
grid on;

title('未校正前直线一级倒立摆系统单位阶跃响应');
xlabel('Time / s');
ylabel('Amplitude');

% 判断稳定性
disp('由于系统存在右半平面极点，单位阶跃响应发散，系统不稳定。');