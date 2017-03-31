function [matrix]=fun_matrix_previous(beta0,beta1,k1,thick1)
% This function obtain an matrix connecting adjacent layers by
% A0 = matrix * A1; A0 is coefficient pair at pevious interface
% beta0 is for previous point
% beta1, k1, thick1 is for current point
% thick is in angstrom, k1 in cm^-1

t1=thick1*1e-8; % A-> cm
Ainv=0.5*[1,   1/beta0; ...
    1,  -1/beta0];       % (1-8a)
B=[exp(-1i*k1*t1),exp(1i*k1*t1);...
    beta1*exp(-1i*k1*t1),-beta1*exp(1i*k1*t1)];% (1-8b)
matrix=Ainv*B;                       % (1-7a)