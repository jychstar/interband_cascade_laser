function [matrix]=fun_matrix_next_wg(gamma0,epsilon0,gamma1,epsilon1,thick1,TE)
% This function return an matrix connecting adjacent layers by
% A1 = matrix * A0; A1 is coefficient pair at next interface
% gamma0 is for current point
% gamma1, epsilon1, thick1 is for next point
% thick is in um

if (TE==1)
    beta0=gamma0;
    beta1=gamma1;
else
    beta0=gamma0/epsilon0;
    beta1=gamma1/epsilon1;
end
    A=[     1,    1; ...
        -beta0 ,beta0];       % (1-6a)  
    Binv=0.5*[exp(-gamma1*thick1),-exp(-gamma1*thick1)/beta1;...
              exp(gamma1*thick1),   exp(gamma1*thick1)/beta1];    % (1-8b)
matrix=Binv*A;                       % (1-7a)
