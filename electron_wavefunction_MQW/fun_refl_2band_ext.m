
function M11=fun_refl_2band_ext(E,Ec,El,layer_grid,EH)
% get the very matrix element in transfer matrix method
% exteranl electric field make Ec,El different at each grid
global P hb

if EH
    k=sqrt((E-Ec).*(E-El))/hb/P;  % /cm, positive imag for electron wave in barrier
else
    k=-sqrt((E-Ec).*(E-El))/hb/P;% negative imag for hole wave in barrier
end
beta=hb*P*k./(E-El); 

M=eye(2);
for jj=1:1:length(Ec)-2
   M=fun_matrix_next(beta(jj),beta(jj+1),k(jj+1),layer_grid)*M; 
end
matrix=fun_matrix_next(beta(end-1),beta(end),k(end),0)*M; % last layer

if EH
    M11=matrix(2,2);
    %M11=matrix(1,1)/matrix(1,2);
else
    M11=matrix(1,1);
end

M11=abs(M11);
M11=log(M11);