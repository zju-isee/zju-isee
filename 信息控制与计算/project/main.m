clc;
clear;
close all;

%% set arguments
N = 8; %set number of quantization bits
n = 7;
k = 4;
snr_array = [-20:20];
snr = 10;

%% command create
[cmd, fs] = commandCreate();

%% quantize
[q_out, q] = quantize(cmd, fs, N);

%% souce encode with Huffman code
[senc_out, dict] = source_encode(q_out, N);

%% channel encode with linear block code
[cenc_out, re, genmat] = channel_encode(senc_out, n, k);

%% multiple snr test
% err = zeros(length(snr_array), 1);
% ber = zeros(length(snr_array), 1);
% for i=1:length(snr_array)
%     m_out = modulation(cenc_out, snr_array(i));
%     dem_out = demodulation(m_out);
%     cdec_out = channel_decode(dem_out, genmat, n, k, re);
%     [err(i), ber(i)] = biterr(senc_out, cdec_out);
% end
% figure;
% subplot(121);
% plot(snr_array, err, 'b');xlabel('SNR(dB)');ylabel('error number');title('不同信噪比下bit出错数');
% subplot(122);
% plot(snr_array, ber, 'b');xlabel('SNR(dB)');ylabel('bit error rate');title('不同信噪比下误码率');
%% modulation with BPSK and AWGN
m_out = modulation(cenc_out, snr);

%% demodulation
dem_out = demodulation(m_out);

%% error compute
[err, ber] = biterr(dem_out, cenc_out);
fprintf('出错数 : %d\n', err);
fprintf('误码率 : %f\n', ber);

%% channel decode
cdec_out = channel_decode(dem_out, genmat, n, k, re);

%% error compute
[err, ber] = biterr(senc_out, cdec_out);
fprintf('出错数 : %d\n', err);
fprintf('误码率 : %f\n', ber);

%% souce decode
sdec_out = source_decode(cdec_out, dict);

%% error compute
[err, ber] = biterr(q_out, sdec_out);
fprintf('出错数 : %d\n', err);
fprintf('误码率 : %f\n', ber);

%% restore the sound
[r_out] = restore(sdec_out, q);

%% error compute
fprintf('均方误差为 : %f\n', mse(r_out-cmd));
len = length(cmd);
ts = (0:len-1)/fs;

% 时域图
figure(1);
subplot(211);
plot(ts, cmd, 'b')
title('原始语音信号');xlabel('time(s)');ylabel('amplitude(V)');
subplot(212);
plot(ts, r_out, 'b')
title('重建后的语音信号');xlabel('time(s)');ylabel('amplitude(V)');

% 频域图
figure(2);
fft_cmd = fft(cmd, fs);
f = fs*(0:fs/2-1)/fs;
subplot(211);
plot(f, abs(fft_cmd(1:fs/2)), 'b');
title('原始语音信号频谱');
xlabel('frequency(Hz)');ylabel('amplitude');
fft_r = fft(r_out, fs);
subplot(212);
plot(f, abs(fft_r(1:fs/2)), 'b');
title('重建语音信号频谱');
xlabel('frequency(Hz)');ylabel('amplitude');

%% recognize
command = recognize(r_out, fs);