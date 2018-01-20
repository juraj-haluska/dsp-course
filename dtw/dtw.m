function [d] = dtw(A, B, type)

% dimension of vectors in [A] and [B] (must be the same)
dim = size(A ,1);

% compute euclidean distances between [dim]-dimensional
% vectors in array [A] and array [B]
localDist = zeros(length(B), length(A));
for a = 1:length(A)
    for b = 1:length(B)
        for i = 1:dim
            square = (A(i, a) - B(i, b))^2;
            localDist(b, a) = localDist(b, a) + square;
            % normally, the square root would be taken 
            % but for purpose of dtw it's not needed
        end
    end
end

% compute global distances based on local conditions
globalDist = -ones(length(B), length(A));

% first point
globalDist(1, 1) = localDist(1, 1);            

% moving diagonally
for i = 2:length(B) + length(A) - 1
    if i <= length(A)
        aStart = i;
        bStart = 1;
    else
        aStart = length(A);
        bStart = bStart + 1;
    end
    a = aStart;
    b = bStart;
    while a >= 1 && b <= length(B)
       if type == 6
           valids = type6(a, b, globalDist, localDist);
       elseif type == 3
           valids = type3(a, b, globalDist, localDist);
       else
           valids = type1(a, b, globalDist, localDist);
       end
       % find and save minimum value to globalDist
       if ~isempty(valids)
           globalDist(b, a) = min(valids);
       end
       
       a = a - 1;
       b = b + 1;
    end
end

% resulting normalised distance
d = globalDist(length(B), length(A)) / (length(B) + length(A));

end