%% 2.1.2 直线一级倒立摆系统根轨迹分析
%% 程序1：绘制未校正前系统开环根轨迹

clc;
clear;
close all;

s = tf('s');

% 直线一级倒立摆摆杆角度传递函数
G = 4.9/(s^2 - 48.3);

figure;
rlocus(G);
grid on;

title('未校正前直线一级倒立摆系统根轨迹');
xlabel('Real Axis');
ylabel('Imaginary Axis');

% 显示开环极点
p = pole(G);
disp('未校正前系统的开环极点为：');
disp(p);
