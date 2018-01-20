function [valids] = type3(a, b, globalDist, localDist)

big = 1000;

valids = [];

% condition 1
gx = b - 2;
gy = a - 1;
d1x = b - 1;
d1y = a;
d2x = b;
d2y = a;
if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y)];
else 
    valids = [valids big];
end
            
% condition 2
gx = b - 1;
gy = a - 1;
dx = b;
dy = a;
if gx > 0 && gy > 0 && dx > 0 && dy > 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(dx, dy)];
else 
    valids = [valids big];
end
            
% condition 3
gx = b - 1;
gy = a - 2;
d1x = b;
d1y = a - 1;
d2x = b;
d2y = a;

if gx > 0 && gy > 0 && d1x > 0 && d1y > 0 && d2x > 0 && d2y > 0
    valids = [valids globalDist(gx, gy) + 2 * localDist(d1x, d1y) + localDist(d2x, d2y)];
else 
    valids = [valids big];
end

end