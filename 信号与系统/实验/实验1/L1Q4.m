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
title('y1+y2')
subplot(2,1,2);
stem(0:10,y3);
title('y3')
%Part 2
x=[zeros(1,5),ones(1,11)];
for n=1:1:15
y(n) = x(n)+x(n+1)
end
x = -5:1:9;
y1 = [zeros(1,5),ones(1,10)];
subplot(2,1,1);
scatter(x,y1);
title('x[n]=u[n]');
subplot(2,1,2);
scatter(x,y);
title('y[n]');