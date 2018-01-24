% computer speech recognition using MFCC + DTW
clear all;
close all;

% initial parameters
overlapMs = 10;
frameSizeMs = 30;
bandsCount = 40;
mfccCount = 20;
dictDir = 'records/';

% 1. create dictionary
records = dir(strcat(dictDir,'*.wav'));
for i=1:length(records)
    % load wave file
    [y, Fs] = audioread(strcat(dictDir, records(i).name));
    
    overlap = floor(Fs * overlapMs / 1000);
    frameSize = floor(Fs * frameSizeMs / 1000);
    
    % apply pre-emphasis
    y = filter([1 -0.9], 1, y);

    % split signal into frames with overlap and apply window
    m = split(y, frameSize, overlap);
    m = m .* hamming(length(m));
    
    % filter out silence (first and last are indexes of valid blocks)
    [first, last] = vad(m);
    % valid = m(:, first:last);
    valid = m;
    
    % calculate mfcc coefficients for each block
    mfccs = zeros(mfccCount, size(valid, 2));
    for b=1:size(valid, 2)
        mfccout = mfcc(valid(:, b)', bandsCount, mfccCount);
        mfccs(:, b) = mfccout';
    end
    
    % save to dictionary
    records(i).mfccs = mfccs;
end

% 2. do the same for single .wav which should be recognised
[y, Fs] = audioread('test.wav');
overlap = floor(Fs * overlapMs / 1000);
frameSize = floor(Fs * frameSizeMs / 1000);
y = filter([1 -0.9], 1, y);
m = split(y, frameSize, overlap);
m = m .* hamming(length(m));
[first, last] = vad(m);
%valid = m(:, first:last);
valid = m;

mfccs = zeros(mfccCount, size(valid, 2));
for b=1:size(valid, 2)
    mfccout = mfcc(valid(:, b)', bandsCount, mfccCount);
    mfccs(:, b) = mfccout';
end

% 3. evaluate test record against dictionary using DTW
distances = ([]);
for i = 1:length(records)
    distances(i) = dtw(records(i).mfccs, mfccs, 1);
end
[v, i] = min(distances);
records(i).name