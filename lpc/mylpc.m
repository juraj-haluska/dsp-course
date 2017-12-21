% Implementation of lpc algorithm 
% using Levinson-Durbin recursion.

function [o] = mylpc(signal, n)

% precomputation of auto-correlation vector
r = zeros(1, n + 1);
for i = 0:n
   r(i + 1) = autocorr(signal, i); 
end

% initialization
e = r(1);
a = zeros(n, n);

% recursion
for i = 1:n
   k = r(i + 1);
   for j = 1:i - 1
       k = k - a(j, i - 1) * r(i - j + 1);
   end
   k = k / e;
   a(i,i) = k;
   for j = 1: i - 1
       a(j, i) = a(j , i - 1) - k * a(i - j, i - 1);
   end
   e = e * (1 - k^2);
end

% result
o = [1 -1 * a(:, n)'];

end