function matrix=fun_waveguide_matrix(lambda,neff,ref,thick,TE)
% transfer matrix
% lambda(um),neff(1),ref(1),thick(um),TE(1/0)
k0=2*pi/lambda;
epsilon=ref.^2;%1xN
gamma=k0*sqrt(neff^2-epsilon);%1xN
% get matrix
M=eye(2);
for jj=1:1:length(thick)-2
   M=fun_matrix_next_wg(gamma(jj),epsilon(jj),gamma(jj+1),epsilon(jj+1),thick(jj+1),TE)*M; 
end
matrix=fun_matrix_next_wg(gamma(end-1),epsilon(end-1),gamma(end),epsilon(end),0,TE)*M; % last layer, 
