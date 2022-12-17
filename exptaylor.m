% In this script, we approximate eˆ(−5) using a Taylor polynomial of degree
% nine and compute the associated absolute errors
% Written by Eric Nguyen
format short
x = -5;
n = 9;

% Part A
approxA = (sum((repelem(x,n+1).^(0:n))./factorial(0:n)));
absErrorA = abs(approxA - exp(-5));

disp(approxA)
disp(absErrorA)

% Part B
approxB = 1./(sum((repelem(-x,n+1).^(0:n))./factorial(0:n)));
absErrorB = abs(approxB - exp(-5));

disp(approxB)
disp(absErrorB)

% Part C
% Part B gives the better approximation since the value is positive
% which prevents the exponent from alternating the sums
% between negative and positive numbers