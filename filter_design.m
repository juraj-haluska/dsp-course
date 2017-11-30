% filter design method using frequency sampling

Fs = 8000;
N = 10;
rads = 2*pi/Fs;
step = (Fs/N) * rads;

start = 667 * rads;
stop = 1414 * rads;
start2 = 2*pi - stop;
stop2 = 2*pi - start;

H = zeros(1, N);
for k=1:N
    freq =(k-1) * step;
    if (freq >= start && freq <= stop) || (freq >= start2 && freq <= stop2)
       H(k) = exp(1j*2*pi*(k-1)/N);
    else 
        H(k) = 0;
    end
end

figure,stem(abs(H));

%h = zeros(1, N);
h=[];
pom=0;
%for n=0:N-1
% pozn - treba spravit ifft zo symetrickeho spektra
 for n=-N/2:N/2
    for k=0:N-1
       %h(n + 1) = h(n+1) + H(k+1)*exp(1j*2*pi*n*k/N);
       pom = pom + H(k+1)*exp(1j*2*pi*n*k/N);
    end
    h = [h pom/N];
    pom=0;
end

%h=ifft(H);

%figure;
h=real(h(1:end-2));
h=hamming(length(h))'.*h;
figure,stem(h);

[h,w]=freqz(h,1,1024,'whole');
figure,
%hold on;
plot(w,abs(h),'m')
figure,plot(angle(h))