function [A] = mel_fb(len, bands, Fs)
    % freq to mels
    function [m] = toMels(f)
        m = 2595 * log10(1 + f/700);
    end
    % mels to freq
    function [hz] = toHz(m)
        hz = 700 * (10^(m/2595) - 1);
    end

fmax = Fs/2;
fmmax = toMels(fmax);

bandSize = floor(fmmax / bands);

fBands = zeros(bands);
for i=1:bands
    fBands(i) = toHz(i*bandSize);
end

A = zeros(len, bands);

for i=1:bands
    start = 1;
    if i ~= 1
        start = ceil(fBands(i - 1));
    end
    stop = floor(fBands(i));
    A(start:stop,i) = ones();
end

end