
function [add,amplitude,Field_plot]=fun_field_1band_ext(E,Ec_div,Eh_div,mh_div,thick,layer_grid,depth,Vext,EH,force2zero)
% heavy hole wavefunction profile by 1 band model
% output 1: band profile, wave profile based on the eigen value
% output 2: wavefunction for oscillator strength calculation

global hb m0

totNum=sum(thick/layer_grid);  % total plot points
amplitude=zeros(2,totNum);

% evaluate kk, Beta
if EH
    k=sqrt(2*mh_div*m0.*(E-Ec_div))/hb;% /cm
else
    k=1i*sqrt(2*mh_div*m0.*(E-Eh_div))/hb;% /cm
end
beta=1i*k./mh_div/m0;

%% 1st step, get amplitudes for each grid
% set amplitude for first layers
amplitude(:,1)=[0;1];  % electron wave
% from second layer to end
for ii=2:1:totNum
    amplitude(:,ii)=fun_matrix_next(beta(ii-1),beta(ii),k(ii),layer_grid)*amplitude(:,ii-1);
end

% %% handle the last several layers, change to eliminate the errors
remain=sum(thick(length(thick)-force2zero+1:1:end))/layer_grid; % remaining points
d=layer_grid*1e-8; %convert A to cm
for ii=totNum-remain+1:1:totNum    
    amplitude(1,ii)=amplitude(1,ii-1)*exp(1i*k(ii)*d); %
    amplitude(2,ii)=0;   % Bn=0,no incoming e wave    
end

%%
add=amplitude(1,:)+amplitude(2,:);           %
Field=abs(add).^2;
tot=trapz(depth,Field);
Field=Field/tot;
add=add/sqrt(tot);
% centroid_hole=sum(thick)-trapz(depth, depth.*Field)
%%
figure;
Field_plot=E-Field*10;
plot(depth, fliplr([Ec_div;Eh_div;Field_plot]),'linewidth',2)

xlabel('\fontsize{14} Upwards(angstrom)');
ylabel('\fontsize{14} Energy (eV)')
title(['\fontsize{14} 1-Band Model, E=',num2str(E),' eV, V_e_x_t=',num2str(Vext),' kV/cm']);
legend('\fontsize{14}E_c','\fontsize{14}E_h_h','\fontsize{14}|\psi_h_h|^2','location','best')

grid on
