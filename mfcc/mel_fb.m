function [A] = mel_fb(len, bands)
    % this function creates mel filter bank
    % for left half of fft

    % hz <-> mels
    toMels = @(f) 2595 * log10(1 + f/700);
    toHz = @(m) 700 * (10.^(m/2595) - 1);
    
    bandLength = floor(len / bands);
    lastMel = toMels(len);
    bandsInMels = linspace(bandLength, lastMel - bandLength, bands - 1);
    bandsInHz = [floor(toHz(bandsInMels)) len];

    A = zeros(len, bands);
    
    % generate non linear filter bank
    bank = 1;
    for i = 1:len
        if i > bandsInHz(bank)
            bank = bank + 1;
        end
        A(i, bank) = 1;
    end
end