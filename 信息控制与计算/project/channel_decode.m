function [out] = channel_decode(encData, genmat, n, k, re)
encData = reshape(encData, n, length(encData)/n)';
decData = decode(encData,n,k,'linear/binary',genmat);
decData = reshape(decData', [], 1);
out = decData(1:(length(decData)-k+re));
end