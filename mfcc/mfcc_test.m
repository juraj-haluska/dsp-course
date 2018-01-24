% test file for mfcc

bandsCount = 40;
dctsCount = 12;

[y, Fs] = audioread('records/zosit.wav');

% subsignal
sub = y(2000:3000);
sub = sub .* hamming(length(sub))';

% spectrum
spect = abs(fft(sub));
spect = spect(1:ceil(length(spect) / 2));

% log of spectrum
spectLog = log10(spect);

% apply filter bank
melFilterBank = mel_fb(length(spectLog), bandsCount);
filtered = spectLog * melFilterBank;

% perform discrete cosine transform
dcts = dct(filtered);

mfcc = dcts(1:dctsCount);