% Splits input vector [v] by [n] samples into 
% columns of matrix [m] with [o]-long overlaps.
% Remaining samples are ignored.

function [m] = split(v, n, o)

if o >= n
    error('o have to be less than n!');
end

m=([]);

for col=1:floor((length(v) - o) / (n - o))
    begin = (col - 1) * (n - o); 
    for i=1:n
        m(i, col) = v(begin + i);
    end
end
