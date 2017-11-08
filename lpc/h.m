function [v] = h(w,a)

sum = 1;

for i=1:length(a)
    sum = sum + a(i) * exp(-j*w*i);
end

v = 1/sum;