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

zeta = 0.8;
wn = 6;
sigma = zeta*wn;
wd = wn*sqrt(1-zeta^2);

p_new = [-sigma+1i*wd, -sigma-1i*wd, -14, -16];

K_new = place(A,B,p_new);
Acl_new = A - B*K_new;
Cr = [1 0 0 0];
Nbar_new = -1/(Cr*(Acl_new\B));

sys_new = ss(Acl_new,B*Nbar_new,C,D);

t = 0:0.001:4;
r = 0.1;
[y_new,t] = step(r*sys_new,t);

info_x_new = stepinfo(y_new(:,1),t,r);
phi_max_new = max(abs(y_new(:,2)));

figure(1)
plot(t,y_new(:,1),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('修改指标后小车位移阶跃响应')

figure(2)
plot(t,y_new(:,2),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('修改指标后摆杆角度响应')

disp('修改后的期望闭环极点为：')
disp(p_new)

disp('修改后的反馈增益矩阵 K_new 为：')
disp(K_new)

fprintf('修改后的前置补偿系数 Nbar_new = %.4f\n',Nbar_new)

disp('修改后的实际闭环极点为：')
disp(eig(Acl_new))

disp('修改后小车位移阶跃响应指标为：')
disp(info_x_new)

fprintf('修改后摆杆角度最大绝对值 phi_max_new = %.4f rad\n',phi_max_new)
