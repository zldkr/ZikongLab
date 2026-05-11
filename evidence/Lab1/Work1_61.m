% 定义开环传递函数的分子和分母
num_open = [12.25, 147, 0];
den_open = [1, 0, -48.3, 0];
sys_open = tf(num_open, den_open);

% 求取单位负反馈的闭环传递函数
sys_closed = feedback(sys_open, 1);

% 绘制闭环系统的单位阶跃响应
figure;
step(sys_closed);
title('校正后摆杆角度单闭环系统单位阶跃响应');
grid on;


