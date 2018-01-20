function [valids] = type6(a, b, globalDist, localDist)

valids = [];

% condition 1
gx = b - 1;
gy = a - 3;
d1x = b;
d1y = a - 2;
d2x = b;
d2y = a - 1;
d3x = b;
d3y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0 && d3x > 0 && d3y > 0 && globalDist(gx, gy) >= 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y) + localDist(d3x, d3y)];
end
            
% condition 2
gx = b - 1;
gy = a - 2;
d1x = b;
d1y = a - 1;
d2x = b;
d2y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0 && globalDist(gx, gy) >= 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y)];
end

% condition 3
d1x = b - 1;
d1y = a - 1;
d2x = b;
d2y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0 && globalDist(gx, gy) >= 0
    valids = [valids localDist(d1x, d1y) + 2 * localDist(d2x, d2y)];
end

% condition 4
gx = b - 2;
gy = a - 1;
d1x = b - 1;
d1y = a;
d2x = b;
d2y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0 && globalDist(gx, gy) >= 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y)];
end

% condition 5
gx = b - 3;
gy = a - 1;
d1x = b - 2;
d1y = a;
d2x = b - 1;
d2y = a;
d3x = b;
d3y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0 && d3x > 0 && d3y > 0 && globalDist(gx, gy) >= 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y) + localDist(d3x, d3y)];
end

end