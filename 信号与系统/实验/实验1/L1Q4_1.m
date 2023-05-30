% Lab 1 Question 4
%Part 1
clc;clear;
x1 = [1 zeros(1,10)];
x2 = [2 zeros(1,10)];
x3 = x1+x2;
y1 = sin(pi*x1/2);
y2 = sin(pi*x2/2);
y3 = sin(pi*x3/2);
subplot(2,1,1);
stem(0:10,y1+y2);
title('Output y1[n]+y2[n]')
subplot(2,1,2);
stem(0:10,y3);
title('Output y3[n]')