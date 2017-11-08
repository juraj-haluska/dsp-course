clear all;
[x, Fs] = wavread('C:\Users\KTK\Desktop\M04\lieh_M4.wav');

sub = x(16030:(16030 + Fs*0.05));
sub = sub.*hamming(length(sub));

a = lpc(sub, 10);

freq = abs(fft(sub));

out = ([]);
samples = length(freq);
for i=1:samples
   out(i) = h(2*pi*(i-1)/samples, a(2:end));
end

plot(abs(out));
hold on;
plot(freq);
figure;

signal = filter(a, 1, sub);
synth = out * signal;

plot(signal);
hold on;
plot(synth);
