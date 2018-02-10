function [E_eigen,Ec_div,Eh_div,mh_div,depth]=fun_EigenValue_1band_ext(thick,layer_grid,Ec,Eh,mh,xr,Vext,EH)
% getEigenValue_1Band_ext
% one band model, effective mass approach
% 1D calculation

M22=zeros(1,length(xr));  % 
totNum=sum(thick/layer_grid);  % total plot points
subNum=thick/layer_grid;   %number of points in each layer

% evalue Ec_div, El_div, depth
depth=(1:1:totNum)*layer_grid;
Ec_div=zeros(1,totNum);
Eh_div=zeros(1,totNum);
mh_div=zeros(1,totNum);
last=0;
for j=1:1:length(thick)
    first=last+1;
    last=first+subNum(j)-1;   % get column numbers for write
    Ec_div(first:1:last)=Ec(j);    
    Eh_div(first:1:last)=Eh(j); 
    mh_div(first:1:last)=mh(j); 
end
% shift due to electric field
Ec_div=Ec_div-Vext*depth/2*1e-5; 
Eh_div=Eh_div-Vext*depth/2*1e-5;  %

% scan energy
for ii=1:length(xr);  
    E=xr(ii);    
    [m22]=fun_refl_1band_ext(E,Ec_div,Eh_div,mh_div,layer_grid,EH); % get element M11
 M22(ii)=log(abs(m22));  %M11 and M22 are actually very similar
end

% Plot and find the minimum value of reflection coefficient
figure; 
plot(xr,M22)
xlabel('\fontsize{14}Energy(eV)')
ylabel('\fontsize{14}log(|M_x_x|)')

[a, b]=min(M22); % a is minimum value and b indicates the number sequence corresponding to the min

E_eigen=xr(b);
disp(['Eigen value by one band model =',num2str(E_eigen)]);
title(['\fontsize{14} Eigenvalue =',num2str(E_eigen),' eV',', V_e_x_t=',num2str(Vext),' kV/cm'])
