[y, Fs] = audioread('records/s.wav');

% constants
overlap = floor(Fs * 0.01);
frameSize = floor(Fs * 0.03);

y = filter([1 -0.9], 1, y);

% split signal into frames with overlap
m = split(y, frameSize, overlap);
m = m .* hamming(length(m));

[first, last] = vad(m);

% validate signal
firstSample = frameSize * first - (first - 1) * overlap;
lastSample = frameSize * last - (last - 1) * overlap;
valid = y(firstSample:lastSample);

audiowrite('output.wav',valid,Fs);