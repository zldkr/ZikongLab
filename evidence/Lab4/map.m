clear; clc; close all

A = [0 1 0 0;
     0 0 0 0;
     0 0 0 1;
     0 0 48.3 0];
B = [0;1;0;4.9];
C = [1 0 0 0;
     0 0 1 0];
D = [0;0];

Wc = ctrb(A,B);
disp('rank(Wc)=')
disp(rank(Wc))
disp('eig(A)=')
disp(eig(A))

r = 0.1;
Cr = [1 0 0 0];

zeta = 0.7;
wn = 4;
sigma = zeta*wn;
wd = wn*sqrt(1-zeta^2);
p = [-sigma+1i*wd, -sigma-1i*wd, -8, -10];
K = place(A,B,p);
Acl = A - B*K;
Nbar = -1/(Cr*(Acl\B));
sys_cl = ss(Acl,B*Nbar,C,D);

t = 0:0.001:5;
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

disp('初始方案 K=')
disp(K)
disp('初始方案 Nbar=')
disp(Nbar)
disp('初始方案闭环极点=')
disp(eig(Acl))
disp(info_x)
disp('phi_max=')
disp(phi_max)

zeta2 = 0.8;
wn2 = 6;
sigma2 = zeta2*wn2;
wd2 = wn2*sqrt(1-zeta2^2);
p_new = [-sigma2+1i*wd2, -sigma2-1i*wd2, -14, -16];
K_new = place(A,B,p_new);
Acl_new = A - B*K_new;
Nbar_new = -1/(Cr*(Acl_new\B));
sys_new = ss(Acl_new,B*Nbar_new,C,D);

t2 = 0:0.001:4;
[y_new,t2] = step(r*sys_new,t2);
info_x_new = stepinfo(y_new(:,1),t2,r);
phi_max_new = max(abs(y_new(:,2)));

figure(3)
plot(t2,y_new(:,1),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('小车位移 x/m')
title('修改指标后小车位移阶跃响应')

figure(4)
plot(t2,y_new(:,2),'LineWidth',1.5)
grid on
xlabel('时间/s')
ylabel('摆杆角度 phi/rad')
title('修改指标后摆杆角度响应')

disp('修改后方案 K_new=')
disp(K_new)
disp('修改后方案 Nbar_new=')
disp(Nbar_new)
disp('修改后方案闭环极点=')
disp(eig(Acl_new))
disp(info_x_new)
disp('phi_max_new=')
disp(phi_max_new)