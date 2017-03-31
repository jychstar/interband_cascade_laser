function [matrix]=fun_miniband_matrix_2band(E,Ec,El,thick)
% get miniband matrix in 1 band model
% input: energy(eV, single value),V(eV),meff(m0),t(A)

global P hb
                                                                        
k=sqrt((E-Ec).*(E-El))/hb/P;  % /cm   
beta=hb*P*k./(E-El);

M=eye(2);
for jj=1:1:length(thick)-1;
    M=fun_matrix_next(beta(jj),beta(jj+1),k(jj+1),thick(jj+1))*M;
end
matrix=fun_matrix_next(beta(end),beta(1),k(1),thick(1))*M; % last layer
