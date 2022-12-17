% Natural Cubic Spline Implementation
% 
% INPUT:
%   - n: number of x values used
%   - x: x values to use for interpolation
%   - y: f(x) values corresponding to x input
%
% OUTPUT:
%   - a: array of a_j coefficients
%   - b: array of b_j coefficients
%   - c: array of c_j coefficients
%   - d: array of d_j coefficients
%
% Written by Eric Nguyen
function [a,b,c,d] = cubicspline(n,x,y)

a = y;
h = zeros(1,n);
alpha = zeros(1,n);
l = zeros(1,n);
mu = zeros(1,n);
z = zeros(1,n);
c = zeros(1,n);
b = zeros(1,n);
d = zeros(1,n);

% STEP 1
for i = 1:(n - 1)
    h(i) = x(i+1) - x(i);
end

% STEP 2
for i = 2:(n - 1)
    alpha(i) = (3 / h(i)) * (a(i + 1) - a(i)) - (3 / h(i - 1)) * (a(i) - a(i - 1));
end

% STEP 3
l(1) = 1;
mu(1) = 0;
z(1) = 0;

% STEP 4
for i = 2:(n - 1)
    l(i) = 2 * (x(i + 1) - x(i - 1)) - h(i - 1) * mu(i - 1);
    mu(i) = h(i) / l(i);
    z(i) = (alpha(i) - h(i - 1) * z(i - 1)) / l(i);
end

% STEP 5
l(n) = 1;
z(n) = 0;
c(n) = 0;

% STEP 6
for j = n-1:-1:1
    c(j) = z(j) - mu(j) * c(j+1);
    b(j) = (a(j + 1) - a(j)) / h(j) - h(j) * (c(j + 1) + 2 * c(j)) / 3;
    d(j) = (c(j + 1) - c(j)) / (3 * h(j));
end

a = a(1:3);
b = b(1:3);
c = c(1:3);
d = d(1:3);

end