% Lab 1 Question 3
clear;clc;
%x1
n = 0:31;
x1 = sin(pi*n/4).*cos(pi*n/4);
subplot(3,1,1);
stem(n,x1);
title('x1=sin(pi*n/4)*cos(pi*n/4)信号基本周期为4');
xlabel('n')
ylabel('x1[n]')
%x2
%x2 = cos(pi*n/4).*cos(pi*n/4);
x2 = cos(pi*n/4).^2;
subplot(3,1,2);
stem(n,x2);
title('x2=cos^2(pi*n/4)信号基本周期为4');
xlabel('n')
ylabel('x2[n]')
%x3
x3 = sin(pi*n/4).*cos(pi*n/8);
subplot(3,1,3);
stem(n,x3);
title('x3=sin(pi*n/4)*cos(pi*n/8)信号基本周期为16');
xlabel('n')
ylabel('x3[n]')