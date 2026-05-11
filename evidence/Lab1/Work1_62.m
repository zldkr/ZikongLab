% 利用 stepinfo 函数获取时域性能指标
info = stepinfo(sys_closed);

% 打印输出
disp(['超调量 (Overshoot): ', num2str(info.Overshoot), ' %']);
disp(['峰值时间 (Peak Time): ', num2str(info.PeakTime), ' s']);
disp(['调节时间 (Settling Time): ', num2str(info.SettlingTime), ' s']);