function [p,i] = secant(f,p0,p1,Nmax,tol)
% This function solves a root-finding problem
% for a given function f at an accuracy tol
% using the Secant method 
%
% INPUTS
%         f - Root-finding function
%        p0 - First initial guess
%        p1 - Second initial guess
%      Nmax - Maximum number of iterations
%       tol - Solution tolerance
%
% OUTPUTS
%         p - Solution to the problem
%         i - Number of iterations it takes to get convergence
%
% Written by Eric Nguyen

% STEP 1
i=2;
fprintf('i = %4d, p = %.10e\n',i-1,p0);
q0 = f(p0);
q1 = f(p1);

% STEP 2
while i <= Nmax
    % STEP 3 (Compute p_i)
    p = p1 - q1*(p1 - p0) / (q1 - q0);

    fprintf('i = %4d, p = %.15e\n',i,p);

    % STEP 4 (Procedure success)
    if abs(p - p1) < tol
        return;
    end

    % STEP 5
    i = i + 1;

    % STEP 6
    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = f(p);
end

% STEP 7 (Procedure failure)
fprintf(['Method failed to reach desired tolerance after \n' ...
    ' the max number of iterations allowed: %d iterations.\n'],Nmax);
end