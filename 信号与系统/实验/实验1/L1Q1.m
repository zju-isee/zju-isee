% Lab 1 Question 1

clc;clear;
k = [1,2,4,6];
wk = 2*pi*k/5;
% n = 0:1:9;
n = [0:9];
x = sin(wk'*n);
% k = 1;
subplot(4,1,1);
stem(n, x(1,:))
title('x1 = sin(w1*n)');
xlabel('n')
ylabel('x1[n]')
% k = 2;
subplot(4,1,2);
stem(n, x(2,:))
title('x2 = sin(w2*n)');
xlabel('n')
ylabel('x2[n]')
% k = 4;
subplot(4,1,3);
stem(n, x(3,:))
title('x4 = sin(w4*n)');
xlabel('n')
ylabel('x4[n]')
% k = 6;
subplot(4,1,4);
stem(n, x(4,:))
title('x6 = sin(w6*n)');
xlabel('n')
ylabel('x6[n]')
