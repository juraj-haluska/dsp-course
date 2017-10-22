% Returns a vector [z] which elements represent
% couns of zero crossings for each column in input matrix [m].

function [z] = zero_crossing(m)

z = zeros(1, size(m, 2));
 
for col=1:length(z)
    for e=2:size(m, 1)
        if (sign(m(e, col)) - sign(m(e - 1, col))) ~= 0
            z(col) = z(col) + 1;  
        end
    end
end