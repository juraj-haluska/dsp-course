% computer speech recognition using LPC + DTW

% initial parameters
overlapMs = 10;
frameSizeMs = 30;
lpcCount = 10;

% 1. create dictionary
records = dir('records/*.wav');
for i=1:length(records)
    % load wave file
    [y, Fs] = audioread(strcat('records/', records(i).name));
    
    overlap = floor(Fs * overlapMs / 1000);
    frameSize = floor(Fs * frameSizeMs / 1000);
    
    % apply pre-emphasis
    y = filter([1 -0.9], 1, y);
    
    % split signal into frames with overlap and apply window
    m = split(y, frameSize, overlap);
    m = m .* hamming(length(m));
    
    % filter out silence (first and last are indexes of valid blocks)
    [first, last] = vac(m);
    valid = m(:, first:last);
    
    % calculate lpc coefficients for each block
    lpcs = zeros(lpcCount, size(valid, 2));
    for b=1:size(valid, 2)
        lpcout = mylpc(valid(:, b), lpcCount);
        lpcs(:, b) = lpcout(2:end)';
    end
    
    % save to dictionary
    records(i).lpcs = lpcs;
end

% 2. do the same for single .wav which should be recognised
[y, Fs] = audioread('test.wav');
overlap = floor(Fs * overlapMs / 1000);
frameSize = floor(Fs * frameSizeMs / 1000);
y = filter([1 -0.9], 1, y);
m = split(y, frameSize, overlap);
m = m .* hamming(length(m));
[first, last] = vac(m);
valid = m(:, first:last);
lpcs = zeros(lpcCount, size(valid, 2));
for b=1:size(valid, 2)
    lpcout = mylpc(valid(:, b), lpcCount);
    lpcs(:, b) = lpcout(2:end)';
end

% 3. evaluate test record against dictionary using DTW
distances = ([]);
for i = 1:length(records)
    distances(i) = dtw(records(i).lpcs, lpcs, 1);
end
[m, i] = min(distances);
records(i).name