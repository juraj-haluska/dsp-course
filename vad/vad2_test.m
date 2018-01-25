[y, Fs] = audioread('viac_slov.wav');

close all;

% constants
overlap = floor(Fs * 0.01);
frameSize = floor(Fs * 0.03);

% pre-emphasis
% y = filter([1 -0.9], 1, y);

% split signal into frames with overlap
m = split(y, frameSize, overlap);
m = m .* hamming(frameSize);

% find valid regions in frames
out = vad2(m, Fs);

% save isolated records
for i=1:length(out)
    firstSample = frameSize * out(1, i) - (out(1, i) - 1) * overlap;
    lastSample = frameSize * out(2, i) - (out(2, i) - 1) * overlap;
    valid = y(firstSample:lastSample);
    audiowrite(strcat(num2str(i),'.wav'), valid, Fs);
end