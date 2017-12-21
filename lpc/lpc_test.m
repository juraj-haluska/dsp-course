close all;
[y, Fs] = audioread('records/zosit.wav');

% subsignal
sub = y(2000:3000);
sub = sub .* hamming(length(sub))';

% fft of subsignal
spectrum = fft(sub);
freq = (2*pi/length(spectrum):2*pi/length(spectrum):2*pi);
yyaxis left
plot(freq, abs(spectrum));

% frequency response of lpc
a = lpc(sub, 20);
[h,w] = freqz(1, a, 512 , 'whole');
hold on;
yyaxis right
plot(w, abs(h));

% frequency response of mylpc
mya = mylpc(sub, 20);
[h,w] = freqz(1, mya, 512 , 'whole');
hold on;
yyaxis right
plot(w, abs(h), 'g');