clear; clc; close all

A = [0 1 0 0;
     0 0 0 0;
     0 0 0 1;
     0 0 48.3 0];

B = [0;
     1;
     0;
     4.9];

C = [1 0 0 0;
     0 0 1 0];

D = [0;
     0];

Cr = [1 0 0 0];

t = 0:0.001:5;
r = 0.1;

p0 = [-10 -12 -14 -16];

K0 = place(A,B,p0);
Acl0 = A - B*K0;
Nbar0 = -1/(Cr*(Acl0\B));

sys0 = ss(Acl0,B*Nbar0,C,D);

[y0,t0] = step(r*sys0,t);
y0 = squeeze(y0);

x0 = y0(:,1);
phi0 = y0(:,2);

info_x0 = stepinfo(x0,t0,r);
ess0 = abs(r - x0(end));
phi0_max = max(abs(phi0));

disp('================ 修改前极点配置结果 ================')
disp('期望闭环极点 p0 = ')
disp(p0)

disp('反馈增益矩阵 K0 = ')
disp(K0)

fprintf('前置补偿系数 Nbar0 = %.4f\n',Nbar0)

disp('实际闭环极点 eig(A-BK0) = ')
disp(eig(Acl0))

fprintf('小车位移超调量 Mp0 = %.4f %%\n',info_x0.Overshoot)
fprintf('小车位移调节时间 ts0 = %.4f s\n',info_x0.SettlingTime)
fprintf('小车位移稳态误差 ess0 = %.6f m\n',ess0)
fprintf('摆杆最大偏角 phi0_max = %.4f rad\n',phi0_max)

figure(1)
plot(t0,x0,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('修改前极点配置后小车位移阶跃响应')

figure(2)
plot(t0,phi0,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('修改前极点配置后摆杆角度响应')

p1 = [-8 -13 -18 -23];

K1 = place(A,B,p1);
Acl1 = A - B*K1;
Nbar1 = -1/(Cr*(Acl1\B));

sys1 = ss(Acl1,B*Nbar1,C,D);

[y1,t1] = step(r*sys1,t);
y1 = squeeze(y1);

x1 = y1(:,1);
phi1 = y1(:,2);

info_x1 = stepinfo(x1,t1,r);
ess1 = abs(r - x1(end));
phi1_max = max(abs(phi1));

disp('================ 修改后极点配置结果 ================')
disp('期望闭环极点 p1 = ')
disp(p1)

disp('反馈增益矩阵 K1 = ')
disp(K1)

fprintf('前置补偿系数 Nbar1 = %.4f\n',Nbar1)

disp('实际闭环极点 eig(A-BK1) = ')
disp(eig(Acl1))

fprintf('小车位移超调量 Mp1 = %.4f %%\n',info_x1.Overshoot)
fprintf('小车位移调节时间 ts1 = %.4f s\n',info_x1.SettlingTime)
fprintf('小车位移稳态误差 ess1 = %.6f m\n',ess1)
fprintf('摆杆最大偏角 phi1_max = %.4f rad\n',phi1_max)

figure(3)
plot(t1,x1,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('修改后极点配置后小车位移阶跃响应')

figure(4)
plot(t1,phi1,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('修改后极点配置后摆杆角度响应')

figure(5)
plot(t0,x0,'LineWidth',1.5)
hold on
plot(t1,x1,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('修改前后小车位移响应对比')
legend('修改前','修改后')

figure(6)
plot(t0,phi0,'LineWidth',1.5)
hold on
plot(t1,phi1,'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('修改前后摆杆角度响应对比')
legend('修改前','修改后')