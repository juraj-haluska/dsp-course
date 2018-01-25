function [out] = vad2(m, Fs)
% Voice Activity Detection

% constants
zerosPeakTh = 0.3;
zerosPeakDiffTh = 0.15;
energyMagTh = 0.01;
durationMs = 350;

% energy and number of zero-crossings for each frame
e = sum(m .* m) / 2;
z = zero_crossing(m);

% normalize zeros and energy to range between 0 - 1
maxEnergy = max(e);
maxZeros = max(z);
e = e ./ maxEnergy;
z = z./ maxZeros;

% mean of zero crossings
zerosMean = sum(z) / length(z);
variance = (z - zerosMean).^2 ./ length(z);

% create low pass filter
b = poly([-1, 0, 0]);
p1 = 0.93;
p2 = 0.90*exp(1j*pi/20);
p3 = conj(p2);
a = poly([p1, p2 p3]);

% low pass filter zeros
filtered = filter(b, a, variance);
filtered = filtered ./ max(filtered);

% find peaks in filtered zeros
[pks,locs] = findpeaks(filtered);

% filter zeros peaks by zerosPeakTh
zerosPeaks = [];
for i=1:length(pks)
    if pks(i) >= zerosPeakTh
        zerosPeaks = [zerosPeaks locs(i)];
    end
end

% variable representing valid zero-regions
validZeros = zeros(1, length(filtered));
for i=1:length(zerosPeaks)
    peakValue = filtered(zerosPeaks(i));
    % left side to the current peak
    index = zerosPeaks(i);
    while index >= 1 && (peakValue - filtered(index)) <= zerosPeakDiffTh
        validZeros(index) = 1;
        index = index - 1;
    end
    % right side to the current peak
    % index = zerosPeaks(i);
    % while index <= length(filtered) && (peakValue - filtered(index)) <= zerosPeakDiffTh
    %     validZeros(index) = 1;
    %     index = index + 1;
    % end
end
plot(filtered); hold on; plot(validZeros, 'r');

% filter energy according to treshold - energyMagTh
for i=1:length(e)
   if e(i) >= energyMagTh
       e(i) = 1;
   else
       e(i) = 0;
   end
end

% combine valid regions from energy and zeros
validRegions = e + validZeros;

figure; plot(validRegions);

% filter valid regions by duration filter 
frameMs = Fs / size(m ,1);
offset = ceil(durationMs / frameMs);
for i=2:length(validRegions) - offset
    if validRegions(i - 1) > 0 && validRegions(i + offset) > 0
        start = i;
        for i=start:start + offset
            validRegions(i) = 1;
        end
    end
end

figure; plot(validRegions);

% create output matrix
count = 0;
for i=2:length(validRegions)
    % transition from invalid to valid
    if validRegions(i - 1) == 0 && validRegions(i) > 0
        count = count + 1;
        out(1, count) = i;
    end
    % transition from valid to invalid
    if validRegions(i - 1) > 0 && validRegions(i) == 0
       out(2, count) = i; 
    end
end

end