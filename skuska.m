% exam
[y, Fs] = audioread('zadanie.wav');

% parametre
overlapMs = 10;
frameSizeMs = 30;
pocetLpc = 20;
% dtw 1 a 2 = 50, 6 = 4
dtwTreshold = 50;

overlap = floor(Fs * overlapMs / 1000);
frameSize = floor(Fs * frameSizeMs / 1000);

% rozdel na bloky
m = split(y, frameSize, overlap);
m = m .* hamming(frameSize);

% najdi zaciatky a konce slov
out = vad2(m, Fs);

% preemfaza
y = filter([1 -0.9], 1, y);

% znova bloky po preemfaze
m = split(y, frameSize, overlap);
m = m .* hamming(frameSize);

% 1. vytvor slovnik
slovnik = struct([]);
for i=1:length(out)
    slovo = m(:, out(1, i):out(2, i));
    
    % vyrataj MFCC pre kazdy blok
    lpcs = zeros(pocetLpc, size(slovo, 2));
    for b=1:size(slovo, 2)
        lpcout = mylpc(slovo(:, b)', pocetLpc);
        lpcs(:, b) = lpcout(2:end)';
    end
    
    % uloz do slovnika
    slovnik(i).lpcs = lpcs;
end

% nacitaj porovnavane slovo
[y, Fs] = audioread('7.wav');

% preemfaza
y = filter([1 -0.9], 1, y);

% bloky
jednoSlovo = split(y, frameSize, overlap);
jednoSlovo = jednoSlovo .* hamming(frameSize);

% MFCC koeficienty
lpcs = zeros(pocetLpc, size(jednoSlovo, 2));
for b=1:size(jednoSlovo, 2)
    lpcout = mylpc(slovo(:, b)', pocetLpc);
    lpcs(:, b) = lpcout(2:end)';
end

% porovnaj pomocou DTW
vzdialenosti = ([]);
for i = 1:length(slovnik)
    vzdialenosti(i) = dtw(slovnik(i).lpcs, lpcs, 3);
end

for s=1:length(vzdialenosti)
   if vzdialenosti(s) < dtwTreshold && vzdialenosti(s) >= 0
       disp('najdene slovo')
       disp(strcat('    zaciatocny blok:', num2str(out(1, s))));
       disp(strcat('    konecny blok:', num2str(out(2, s))));
   end
end
