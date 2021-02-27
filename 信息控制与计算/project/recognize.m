function command = recognize(r_out, fs)
load('commandNet.mat');
auditorySpect = helperExtractAuditoryFeatures(r_out,fs);
command = classify(trainedNet,auditorySpect);
disp(command)

figure;
subplot(121);
plot(r_out, 'b');
axis tight;
title(string(command));

subplot(122);
pcolor(auditorySpect)
shading flat
end