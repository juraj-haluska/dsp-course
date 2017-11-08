[y, Fs] = audioread('records/kostol.wav');

m = split(y, floor(Fs * 0.03), 0);
e = sum(m.*m)/2;    % energy of signal
z = zero_crossing(m);

% filter zero crossing
slope_th_zeros = 180;
zd = diff(z);
zf = zeros(1, length(z));
for i=1:length(zd)
    if (abs(zd(i)) > slope_th_zeros)
        zf(i) = 150;    % only for visibility in plots
    end
end
% filter energy
slope_th_energy = 0.3;
ed = diff(e);
ef = zeros(1, length(e));
for i=1:length(zd)
    if (abs(ed(i)) > slope_th_energy)
        ef(i) = 5;      % only for visibility in plots
    end
end

valid = zf + ef;
% normalize valid (only for plotting purposes)
for i=1:length(valid)
    if (valid(i) ~= 0) 
        valid(i) = 1;
    end
end

% compute valid blocks
first = 0;
last = 0;
for i=1:length(valid)
    if (valid(i) ~= 0 && first == 0)
        first = i;
    end
    if (valid(length(valid) - i + 1) ~= 0 && last == 0)
        last = length(valid) - i + 1;
    end
end

% trim signal


plot(y);
figure;
plot(y(first * Fs * 0.03:last * Fs * 0.03));
%figure;
%plot(e);
%hold on;
%plot(ef, "r");
%figure;
%plot(z);
%hold on;
%plot(zf, "r");
%figure;
%plot(valid);