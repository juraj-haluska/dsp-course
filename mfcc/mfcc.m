function [mfcc] = mfcc(signal, bandsCount, dctsCount)

    % log of amplitudes of spectrum
    spect = abs(fft(signal));
    spect = spect(1:ceil(length(spect) / 2));
    spectLog = log10(spect);
    
    % apply filter bank
    melFilterBank = mel_fb(length(spectLog), bandsCount);
    filtered = spectLog * melFilterBank;
    
    % perform discrete cosine transform
    dcts = dct(filtered);

    mfcc = dcts(1:dctsCount);
end