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
globalDist = zeros(length(B), length(A));
for a = 1:length(A)
    for b = 1:length(B)
        if a == 1 && b == 1
            globalDist(b, a) = localDist(b, a);
        else
            if type == 3
                valids = type3(a, b, globalDist, localDist);
            else
                valids = type1(a, b, globalDist, localDist);
            end 
                  
            % find and save minimum value to globalDist
            globalDist(b, a) = min(valids);
        end
    end
end

% resulting normalised distance
d = globalDist(length(B), length(A)) / (length(B) + length(A));

end