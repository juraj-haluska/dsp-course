% preemphase
% can be easily realised by filter function
% filter([1 -a], 1, y);

[w,h] = freqz([1 -0.9], 1, 'whole', 512);
plot(w, abs(h));