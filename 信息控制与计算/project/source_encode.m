function [out, dict] = source_encode(x, N)
%%% input
% x: 量化后的信号
% N: 量化bit
%%% output
% out: 哈夫曼编码结果

len = length(x);
unique_x = unique(x);
unique_len = length(unique_x);

symbols = cell(1, unique_len);
p = zeros(1, unique_len);

% 计算符号概率
for i = 1:unique_len
    symbols{1,i} = unique_x(i);
    p(i) = numel(find(x==unique_x(i))) / len;
end

% 根据符号集symbols和概率数组p计算Huffman编码词典
[dict, avglen] = huffmandict(symbols, p);

fprintf('-------- source encode --------\n');

% 打印字典表
for i = 1:unique_len
    fprintf('%d : ', unique_x(i));
    fprintf('%d ', dict{i,2});
    fprintf('\n');
end

fprintf('平均码长 : %f\n', avglen );
fprintf('信源熵 : %f\n', sum(p.*(-log2(p))) );
fprintf('编码效率 : %f\n', 1/sum(p.*(-log2(p))) );

% 编码结果
out = huffmanenco(x, dict);

% 计算字符串最终编码长度
enc_len = length(out);

% 原始编码长度
len_before_enc = len*N;

fprintf('编码前字符串总长度 : %d\n', len_before_enc);
fprintf('编码后字符串二进制总长度 : %d\n', enc_len);
fprintf('压缩率 : %f\n', len_before_enc/enc_len);

% 打印最终编码
fprintf('编码结果 : ');
for i = 1:len
    %fprintf('%s : ', x(i));
    fprintf('%d', dict{unique_x==x(i),2});
%     fprintf(' ');
end
fprintf('\n');
end