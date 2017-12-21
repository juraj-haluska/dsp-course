% This function computes autocorrelation
% of signal [s] with lag [l].

function [r] = autocorr(s, l)
    r = 0;
    for i=1:length(s)
        if i + l <= length(s)
            r = r + s(i) * s(i + l);
        end
    end
end