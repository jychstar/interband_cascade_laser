
function [E_eigen,Ec_div,El_div,depth]=fun_EigenValue_2band_ext(thick,layer_grid,Ec,El,xr,Vext,EH)
% getEigenValue_2band
% 1D calculation

MM=zeros(length(xr),1);  % note length(xr)
totNum=sum(thick/layer_grid);  % total plot points
subNum=thick/layer_grid;   %number of points in each layer

% evalue Ec_div, El_div, depth
depth=(1:1:totNum)*layer_grid;
Ec_div=zeros(1,totNum);
El_div=zeros(1,totNum);
last=0;
for j=1:1:length(thick)
    first=last+1;
    last=first+subNum(j)-1;   % get column numbers for write
    Ec_div(first:1:last)=Ec(j);    
    El_div(first:1:last)=El(j); 
end
% shift due to electric field
Ec_div=Ec_div-Vext*depth/2*1e-5; 
El_div=El_div-Vext*depth/2*1e-5;  %

% scan energy
for ii=1:1:length(xr);   
    E=xr(ii);    
    MM(ii)=fun_refl_2band_ext(E,Ec_div,El_div,layer_grid,EH); % get element M11
end

% Plot and find the minimum value of reflection coefficient
figure; 
plot(xr,MM,'o-')

xlabel('\fontsize{14}Energy(eV)')
ylabel('\fontsize{14}log(|M_x_x|)')
[a,b]=min(MM); % a is minimum value and b indicates the corresponding sequence number  to the min
E_eigen=xr(b);
disp(['Eigen value by twe band model =',num2str(E_eigen)]);
title(['\fontsize{14} Eigenvalue =',num2str(E_eigen),' eV',', V_e_x_t=',num2str(Vext),' kV/cm'])
