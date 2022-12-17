function [x1, x2] = quadroots(a,b,c)
% This function gives the two roots of the quadratic equation
% given any inputs a, b, and c
% Written by Eric Nguyen
x1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a);
x2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a);
end
