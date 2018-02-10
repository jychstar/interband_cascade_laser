
function [Neff,Loss]=fun_getNeff(lambda,ref,thick,xr,xi,TE)
% 2D searching for the effective index
% recall: fun_waveguide_matrix

k0=2*pi/lambda;
logrho=zeros(length(xi),length(xr));  % store refl(), size is  length(xi) *length(xr)
flag=1e10;  % inital flag value to store minimum refl()
for ii=1:1:length(xr);  % vary real part
    xxr=xr(ii);
    for jj=1:1:length(xi);  % vary imag part
        xxi=xi(jj);
        nef=xxr+1i*xxi;  % nef is the estimated effective index
        matrix=fun_waveguide_matrix(lambda,nef,ref,thick,TE); % call subcode
        M=log(abs(matrix(2,2)));
        logrho(jj,ii)=M;
        if M<flag
            flag=M;
            real_index=ii;
            imag_index=jj;
        end
    end
end

% Plot and show the minimum value of reflection coefficient
 figure;
 [x,y]=meshgrid(xr,xi);   % build grids
  y=2*k0*y*1e4;  % convert to loss
  mesh(x,y,logrho); shading flat

Neff=xr(real_index)+1i*xi(imag_index);
Loss=2e4*k0*xi(imag_index);

 grid on
xlabel('\fontsize{14}ref-real')
ylabel('\fontsize{14}loss')

zlabel('\fontsize{14}log(\rho)')
title(['\fontsize{14}n_{eff}=', num2str(Neff,4),', Loss=',num2str(Loss,4),' cm^-^1'])
disp(' ** GetNeff complete **')
