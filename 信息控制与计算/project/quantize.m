function [out, q] = quantize(cmd, fs, N)
%%% input
% N: 量化bit
% infile: 输入声音信号
%%% output
% out: 量化后的信号,0:2^N-1

q = (1-(-1))/2^N;
out = floor((cmd+1)/q);

% 量化和原始信号对比
len = length(cmd);
ts = (0:len-1)/fs;
figure;
plot(ts, cmd, 'b');
hold on;

restore = q*out-1;
plot(ts, restore, 'r');
title('原始语音信号');
ylim([-1 1]);
xlabel('time(s)');ylabel('amplitude');
legend('量化前','量化后');
end