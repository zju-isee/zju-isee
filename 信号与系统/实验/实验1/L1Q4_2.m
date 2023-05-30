% Lab 1 Question 4
clc;clear;
%Part 2
x=[zeros(1,6),ones(1,11)];
for n=1:1:16
y(n) = x(n)+x(n+1);
end
x = -5:1:9;
x_out = -6:1:9;
y1 = [zeros(1,5),ones(1,10)];
y2 = [zeros(1,4),ones(1,11)];
subplot(3,1,1);
stem(x_out,y);
title('y[n]=x[n]+x[n+1]');
xlabel('n')
ylabel('y[n]')
subplot(3,1,2);
stem(x,y1);
title('x1=x[n]');
xlabel('n')
ylabel('x1[n]')
subplot(3,1,3);
stem(x,y2);
title('x2=x[n+1]');
xlabel('n')
ylabel('x2[n]')
