function [valids] = type1(a, b, globalDist, localDist)

valids = [];

% condition 1
i = b;
j = a - 1;
if i > 0 && j > 0
    valids = [valids globalDist(i, j) + localDist(b, a)];
end
            
% condition 2
i = b - 1;
j = a - 1;
if i > 0 && j > 0
    valids = [valids globalDist(i, j) + 2 * localDist(b, a)];
end
            
% condition 3
i = b - 1;
j = a;
if i > 0 && j > 0
    valids = [valids globalDist(i, j) + localDist(b, a)];
end

end