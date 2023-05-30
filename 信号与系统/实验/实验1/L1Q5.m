% Lab 1 Question 5
x = str2sym('exp(i*2*pi*t/16)+exp(i*2*pi*t/8)');
xr = sreal(x);
subplot(2,1,1);
fplot(xr,[0,32])
xr = simag(x);
subplot(2,1,2);
fplot(xr,[0,32])

function xr = sreal(~)
    xr = str2sym('cos(2*pi*t/16)+cos(2*pi*t/8)');
end
function xr = simag(~)
    xr = str2sym('sin(2*pi*t/16)+sin(2*pi*t/8)');
end