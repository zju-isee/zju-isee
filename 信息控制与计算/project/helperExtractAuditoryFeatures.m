function features = helperExtractAuditoryFeatures(x,fs)
% helperExtractAuditoryFeatures Compute auditory spectrogram

% Copyright 2019 The MathWorks, Inc.

% segmentDuration is the duration of each speech clip (in seconds). 
% frameDuration is the duration of each frame for spectrum calculation.
% hopDuration is the time step between each spectrum. 
%  numBands is the number of filters in the auditory spectrogram.
segmentDuration = 1;
frameDuration = 0.025;
hopDuration = 0.010;
numBands = 50;

segmentSamples = round(segmentDuration*fs);
frameSamples = round(frameDuration*fs);
hopSamples = round(hopDuration*fs);
overlapSamples = frameSamples - hopSamples;

FFTLength = 512;

persistent afe
if isempty(afe)
    afe = audioFeatureExtractor( ...
        'SampleRate',fs, ...
        'FFTLength',FFTLength, ...
        'Window',hann(frameSamples,'periodic'), ...
        'OverlapLength',overlapSamples, ...
        'barkSpectrum',true);
    setExtractorParams(afe,'barkSpectrum','NumBands',numBands);
end

% Some files in the data set are less than 1 second long. Apply
% zero-padding to the front and back of the audio signal so that it is of
% length segmentSamples.

numSamples = size(x,1);

numToPadFront = floor( (segmentSamples - numSamples)/2 );
numToPadBack = ceil( (segmentSamples - numSamples)/2 );

xPadded = [zeros(numToPadFront,1,'like',x);x;zeros(numToPadBack,1,'like',x)];

% To extract audio features, call |extract|. The output is a Bark spectrum
% with time across rows.
features = extract(afe,xPadded);


% Determine the denormalization factor to apply.
unNorm = 2/(sum(afe.Window)^2);
features = features/unNorm;
epsil = 1e-6;

% Take the log. 
features = log10(features + epsil);