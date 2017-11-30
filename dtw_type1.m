clear all;

A = [1 2 -1 0; 0 3 2 0];
B = [1 2 1; 1 3 0];

d = zeros(length(B), length(A));

% loop through cols of A
for a=1:length(A)
   % loop through cols of B
   for b=1:length(B)
       % sum (ai - bi)^2
       d(b,a) = sum((A(:, a) - B(:, b)).^2);
   end
end

% find the best path
m = 1; n = 1;
last = d(m, n);
direction = [1 1];
while (direction(1) ~= 0 && direction(2) ~= 0)
    current = 1000000;
    direction = [0 0];
    % up direction
    if m ~= length(B)
        if (d(m + 1, n) + last) < current
            current = d(m + 1, n) + last;
            direction = [1 0];
        end
    end
    % right direction
    if n ~= length(A)
        if (d(m, n + 1) + last) < current
            current = d(m, n + 1) + last;
            direction = [0 1];
        end
    end
    % diagonal direction
    if (m ~= length(B)) && (n ~= length(A))
        if (2*d(m + 1, n + 1) + last) < current
            current = 2*d(m + 1, n + 1) + last;
            direction = [1 1];
        end
    end
    m = m + direction(1);
    n = n + direction(2);
    last = current;
end
