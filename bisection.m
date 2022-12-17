function [p,nit] = bisection(f,a,b,Nmax,tol)
%BISECTION
% This program solves the scalar-valued equation f(x)=0 using the 
% bisection method to a given tolerance accuracy
%
% INPUTS: 
%         f - Root-finding function defined as an anonymous Matlab function.
%         a - Left end point of interval containing solution
%         b - Right end point of interval containing solution 
%      Nmax - Maximum number of iterations (an integer)
%       tol - Solution tolerance
% OUTPUTS
%         p - Solution to the problem
%     nit - Number of iterations it takes to get convergence
%        
% Written by 
% MATH3043 @ Temple University 
% Fall 2022

% Translate the Bisection Algorithm pseudocode on page 49 of 
% Burden, Faires, Burden's 10th edition Numerical Analysis to complete this program.
%%%% YOUR CODE goes here %%%%%%

% STEP 1
nit = 1;
FA = f(a);

% STEP 2
while nit <= Nmax
    % STEP 3
    p = a + (b - a) / 2;
    FP = f(p);

    % STEP 4
    if FP == 0 || (b - a) / 2 < tol
        return;
    end

    % STEP 5
    nit = nit + 1;

    % STEP 6
    if FA * FP > 0
        a = p;
        FA = FP;
    else
        b = p;
    end
end

% STEP 7
fprintf('Method failed after N_0 iterations, N_0 = %d', Nmax);