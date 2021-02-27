function [cmd, fs] = commandCreate()
% fs = 16000; 
% R = audiorecorder(fs, 16 ,1) ;
% disp('Start speaking.')
% recordblocking(R,1);
% disp('End of Recording.');
% cmd = getaudiodata(R);
% audiowrite('cmd.flac', cmd, fs);

[cmd, fs] = audioread('cmd.flac');

% 原始信号
len = length(cmd);
ts = (0:len-1)/fs;
figure;
subplot(121);
plot(ts, cmd, 'b');
title('原始语音信号');
ylim([-1 1]);
xlabel('time(s)');ylabel('amplitude');

% 频域图
fft_cmd = fft(cmd, fs);
f = fs*(0:fs/2-1)/fs;
subplot('122');
plot(f, abs(fft_cmd(1:fs/2)), 'b');
title('原始语音信号频谱');
xlabel('frequency(Hz)');ylabel('amplitude');
end
