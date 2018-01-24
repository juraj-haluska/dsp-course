function [first, last] = vad(m)
% Voice Activity Detection
% this script tries to find speech in audio file
% analysing energy of the signal and count of zero crossings

% constants
energyTh = 0.01;
diffTh = 0.05;
durationTh = 8;
before = 0;
after = 0;

% energy and number of zero-crossings for each frame
e = sum(m .* m) / 2;
z = zero_crossing(m);

% normalize zeros and energy to range between 0 - 1
maxEnergy = max(e);
maxZeros = max(z);
e = e ./ maxEnergy;
z = z./ maxZeros;

% filter energy according to treshold - energyTh
for i=1:length(e)
   if e(i) >= energyTh
       e(i) = 1;
   else
       e(i) = 0;
   end
end

% difference treshold filter - diffTh
zz = zeros(1, length(z));
value = 0;
for i=2:length(z)
    delta = z(i) - z(i - 1);
    if delta <= -diffTh
        value = 1;
    end
    if delta >= diffTh
        value = 0;
    end
    zz(i) = value;
end

% duration filter
i = 1;
while i <= length(z)
    if zz(i) == 1
        % count ones from here
        count = 0;
        while zz(i + count) == 1 && (i + count) < length(zz)
            count = count + 1;
        end
        if count >= durationTh
            i = i + count;
        end
    end
    zz(i) = 0;
    i = i + 1;
end

% find valid region in signal
ez = e + zz;
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

% apply before and after values
if first - before >= 1
    first = first - before;
end
if last + after <= size(m, 2)
    last = last + after;
end