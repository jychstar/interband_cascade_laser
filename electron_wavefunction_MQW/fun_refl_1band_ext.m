% 1 band model,use meff as input parameter 
function m22=fun_refl_1band_ext(E,Ec,Eh,meff,layer_grid,EH)

global m0 hb

if EH
    k=sqrt(2*meff*m0.*(E-Ec))/hb;% /cm
else
    k=1i*sqrt(2*meff*m0.*(E-Eh))/hb;% /cm
end
beta=1i*k./meff/m0;
       
M=eye(2);
for jj=1:1:length(Ec)-2
   M=fun_matrix_next(beta(jj),beta(jj+1),k(jj+1),layer_grid)*M; 
end
matrix=fun_matrix_next(beta(end-1),beta(end),k(end),0)*M; % last layer

m22=matrix(2,2); % m11 and m22 are actually very similar
m22=log(abs(m22));