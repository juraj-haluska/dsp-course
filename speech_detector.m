% this script finds speech in audio based on energy of signal
% and count of zero crossings

[y, Fs] = audioread('records/slovo.wav');

% constants
overlap = 30;
frameSize = floor(Fs * 0.03);
zerosTh = 0.9;
energyTh = 0.01;

% split signal into frames with overlap
m = split(y, frameSize, overlap);
m = m .* hamming(length(m));

% energy and number of zero-crossings for each frame
e = sum(m .* m) / 2;
z = zero_crossing(m);

% normalize zeros and energy to range between 0 - 1
maxEnergy = max(e);
maxZeros = max(z);
e = e ./ maxEnergy;
z = z./ maxZeros;

% filter zeros and energy based on tresholds
for i=1:size(m, 2)
   if z(i) >= zerosTh
       z(i) = 1;
   else 
       z(i) = 0;
   end
   if e(i) >= energyTh
       e(i) = 1;
   else
       e(i) = 0;
   end
end

% find valid region in signal
ez = e + z;
first = 0;
last = 0;
for i=1:length(ez)
    if (first == 0)
       if (ez(i) >= 1)
           first = i;
       end
    end
    if (last == 0)
       if (ez(length(ez) - i + 1) >= 1)
           last = length(ez) - i + 1;
       end
    end
end

% validate signal (for plot only)
firstSample = frameSize * first - (first - 1) * overlap;
lastSample = frameSize * last - (last - 1) * overlap;
valid = y(firstSample:lastSample);

audiowrite('output.wav',valid,Fs);

% plot(y);
% figure;
% plot(valid);