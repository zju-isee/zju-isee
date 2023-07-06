% Lab 1 Question 2
clear;clc;

N = 6;
n = [0:24];
%x1
x1 = cos(2*pi*n/N)+2*cos(3*pi*n/N);
subplot(3,1,1);
stem(n,x1);
title('x1 = cos(2*pi*n/N)+2*cos(3*pi*n/N) 周期为12');
xlabel('n')
ylabel('x1[n]')
%x2
x2 = 2*cos(2*n/N)+2*cos(3*n/N);
subplot(3,1,2);
stem(n,x2);
title('x2 = 2*cos(2*n/N)+2*cos(3*n/N) 非周期信号');
xlabel('n')
ylabel('x2[n]')
%x3
nx3 = [0:48];
x3 = cos(2*pi*nx3/N)+3*sin(5*pi*nx3/(2*N));
subplot(3,1,3);
stem(nx3,x3);
title('x3 = cos(2*pi*nx3/N)+3*sin(5*pi*nx3/(2*N)) 周期为24');
xlabel('n')
ylabel('x3[n]')