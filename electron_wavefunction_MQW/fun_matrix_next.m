function [matrix]=fun_matrix_next(beta0,beta1,k1,thick1)
% This function obtain an matrix connecting adjacent layers by
% A1 = matrix * A0; A1 is coefficient pair at next interface
% beta0 is for current point
% beta1, k1, thick1 is for next point
% thick is in angstrom, k1 in cm^-1

t1= thick1*1e-8; % A-> cm
  A=[     1,    1; ...
     beta0 ,-beta0];       % (1-6a)
 Binv=0.5*[exp(1i*k1*t1),exp(1i*k1*t1)/beta1;...
            exp(-1i*k1*t1),-exp(-1i*k1*t1)/beta1];    % (1-8b)
matrix=Binv*A;                       % (1-7a)