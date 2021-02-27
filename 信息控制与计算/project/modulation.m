function [awgn_out] = modulation(x, snr)
%%% BPSK modulation and AWGN
bpsk_out = pskmod(x,2);
awgn_out = awgn(bpsk_out, snr);

% h = scatterplot(awgn_out);
% hold on
% scatterplot(bpsk_out,[],[],'r*',h)
% hold off
end

