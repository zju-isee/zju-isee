function [encData, re, genmat] = channel_encode(x, n, k)
%%% input
% x: 信源编码后的结果
% n: 编码长度
% k: 信息长度
%%% output:
% encData: 线性分组码编码结果
% re: 余数
% genmat: 生成多项式

len = length(x);
data = zeros(ceil(len/k)*k, 1);
data(1:len) = x;
re = rem(len, k);
data = reshape(data, k, length(data)/k)';

pol = cyclpoly(n,k);
[h, g] = cyclgen(n,pol);
genmat = gen2par(h);
encData = encode(data,n,k,'linear/binary',genmat);
encData = reshape(encData', [], 1);

fprintf('-------- channel encode --------\n');
fprintf('生成多项式系数为\n');
disp(pol)
fprintf('监督矩阵H = \n');
disp(h)
fprintf('生成矩阵G = \n');
disp(g)
fprintf('genmat = \n');
disp(genmat)

fprintf('信源编码后码长 : %d\n', len);
fprintf('信道编码后码长 : %d\n', length(encData));
fprintf('编码结果 : ');
fprintf('%d', encData);
end