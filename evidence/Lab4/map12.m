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

Wc = ctrb(A,B);
rankWc = rank(Wc);
detWc = det(Wc);
eigA = eig(A);

disp('系统开环特征根为：')
disp(eigA)

disp('可控性矩阵 Wc 为：')
disp(Wc)

fprintf('可控性矩阵秩 rank(Wc) = %d\n',rankWc)
fprintf('可控性矩阵行列式 det(Wc) = %.4f\n',detWc)

if rankWc == size(A,1)
    disp('系统完全可控，可以进行状态空间极点配置。')
else
    disp('系统不完全可控，不能任意配置全部闭环极点。')
end