
function [add,amplitude,Field_plot_tot]=fun_field_2band_ext(E,Ec_div,El_div,thick,layer_grid,depth,Vext,EH,force2zero)
% electron wavefunction profile by 2 band model
% output 1: band profile, wave profile based on the eigen value
% output 2: wavefunction for oscillator strength calculation
% force2zero: force certain layers to have zero wave for self-consistence

global hb P

totNum=sum(thick/layer_grid);  % total plot points
amplitude=zeros(2,totNum);

% evaluate kk, Beta
if EH
    k=sqrt((E-Ec_div).*(E-El_div))/hb/P;  % /cm, positive imag for electron wave in barrier
else
    k=-sqrt((E-Ec_div).*(E-El_div))/hb/P;% negative imag for hole wave in barrier  , not sure
end
beta=hb*P*k./(E-El_div);

% set amplitude for first layers
amplitude(:,1)=[0;1];  % electron wave
% from second layer to end
for ii=2:1:totNum
    amplitude(:,ii)=fun_matrix_next(beta(ii-1),beta(ii),k(ii),layer_grid)*amplitude(:,ii-1);
end

% handle the last several layers, change to eliminate the errors
remain=sum(thick(length(thick)-force2zero+1:1:end))/layer_grid; % remaining points
d=layer_grid*1e-8; %convert A to cm
for ii=totNum-remain+1:1:totNum
    amplitude(1,ii)=amplitude(1,ii-1)*exp(1i*k(ii)*d); %
    amplitude(2,ii)=0;   % Bn=0,no incoming e wave
end

add=amplitude(1,:)+amplitude(2,:);           % electron component
minus=(amplitude(1,:)-amplitude(2,:)).*beta; %light hole component
Field_e=abs(add).^2;  % moduli squared,electron component
Field_h=abs(minus).^2;   % light hole component
Field_tot=Field_e+Field_h; % total
tot=trapz(depth,Field_tot);% normalize

Field_e=Field_e/tot;   % normalized
Field_h=Field_h/tot;  % normalized
Field_tot=Field_tot/tot; % normalized
add=add/sqrt(tot);% for overlap calculatio
%%
%trapz(depth,Field_tot)
%centroid_electron=sum(thick)-trapz(depth, depth.*Field_tot)

figure;
Field_plot_e=E+Field_e*30;
Field_plot_tot=E+Field_tot*30;
plot(depth,  fliplr([Ec_div;El_div;Field_plot_e;Field_plot_tot]),'linewidth',2)
xlabel('\fontsize{14} Upwards distance(angstrom)');
%plot(depth, [Field_e;Field_h;Field_tot],'o-','linewidth',2)
ylabel('\fontsize{14} Energy (eV)')
title(['\fontsize{14} 2-Band Model, E=',num2str(E),' eV, V_e_x_t=',num2str(Vext),' kV/cm']);
legend('\fontsize{14}E_c','\fontsize{14}E_l_h','\fontsize{14}|\psi_e|^2','\fontsize{14}|\psi_t_o_t|^2','location','best')

grid on
