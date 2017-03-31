function [matrix]=fun_miniband_matrix_1band(E,V,meff,thick, EH)
% get miniband matrix in 1 band model
% input: energy(eV, single value),V(eV),meff(m0),t(A)
% EH=1 for electron, EH=0 for heavy hole
global m0 hb  


m=meff*m0;  %[eV cm^-2 s^2]   
if EH
    k=sqrt(2*m.*(E-V))/hb;  %[cm-1]
else
    k=i*sqrt(2*m.*(E-V))/hb;  %[cm-1]
end

beta=1j*k./m;
M=eye(2);
for jj=1:1:length(thick)-1;
    M=fun_matrix_next(beta(jj),beta(jj+1),k(jj+1),thick(jj+1))*M;
end
matrix=fun_matrix_next(beta(end),beta(1),k(1),thick(1))*M; % last layer
