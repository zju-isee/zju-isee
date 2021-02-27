function [out] = demodulation(x)
out = pskdemod(x,2);
out = double(out > 0.5);
end