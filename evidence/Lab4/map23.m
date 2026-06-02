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

zeta = 0.7;
wn = 4;
sigma = zeta*wn;
wd = wn*sqrt(1-zeta^2);

p = [-sigma+1i*wd, -sigma-1i*wd, -8, -10];

K = place(A,B,p);
Acl = A - B*K;
Cr = [1 0 0 0];
Nbar = -1/(Cr*(Acl\B));

sys_cl = ss(Acl,B*Nbar,C,D);

t = 0:0.001:5;
r = 0.1;
[y,t] = step(r*sys_cl,t);

info_x = stepinfo(y(:,1),t,r);
phi_max = max(abs(y(:,2)));

figure(1)
plot(t,y(:,1),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('极点配置后小车位移阶跃响应')

figure(2)
plot(t,y(:,2),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('极点配置后摆杆角度响应')

disp('期望闭环极点为：')
disp(p)

disp('反馈增益矩阵 K 为：')
disp(K)

fprintf('前置补偿系数 Nbar = %.4f\n',Nbar)

disp('实际闭环极点为：')
disp(eig(Acl))

disp('小车位移阶跃响应指标为：')
disp(info_x)

fprintf('摆杆角度最大绝对值 phi_max = %.4f rad\n',phi_max)
