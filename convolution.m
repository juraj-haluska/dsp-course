% algorithm for computation of 1d discrete convolution

% random input signal
x = rand(1, 10);

% random impulse response
h = rand(1, randi(20, 1, 1));

% output signal
y = zeros(1, length(x) + length(h) -1);

% loop through the output signal
for yi = 1:length(y)
   % loop through impulse response and
   % corresponding samples in input signal
   for hi = 1:length(h)
       % compute actual index for xi
       xi = yi - hi + 1;
       % check bounds of the input signal
       if (xi >= 1 && xi <= length(x))
           y(yi) = y(yi) + h(hi) * x(xi);
       end
   end
end

% tests
correct = conv(x, h);
if length(correct) ~= length(y)
    fprintf("error - wrong length of output signal.");
elseif (correct - y) ~= zeros(1, length(y))
   fprintf("error"); 
else
   fprintf("convolution works");
   stem(y);
   figure;
   stem(correct);
end
