
function [Field_plot,add]=fun_miniband_wavefunction_1band(E,Eh,mh,thick,Eh_div,mh_div,layer_grid,EH)
% heavy hole wavefunction by 1 band model
% output 1: band profile, wave profile based on the eigen value
% output 2: wavefunction for oscillator strength calculation

global m0 hb

% get matrix
M=fun_miniband_matrix_1band(E,Eh,mh,thick,EH); 

% get the initial amplitude, this is the most tricky step
theta=acos(trace(M)/2);
A0=M(1,2)/(exp(1i*theta)-M(1,1));% note:(A0,B0) are not in the initial position

% for the layer before the first layer
  
m=mh*m0;  %[eV cm^-2 s^2]
if EH
    k=sqrt(2*m.*(E-Eh))/hb;  %[cm-1]
else k=1i*sqrt(2*m.*(E-Eh))/hb;  %[cm-1]
end
beta=1j*k./m;
cd=fun_matrix_previous(beta(end),beta(1),k(1),thick(1))*[A0;1];

% allocate memory
totNum=length(Eh_div);  % total plot points
amplitude=zeros(2,totNum);
kk=zeros(1,totNum);
Beta=zeros(1,totNum);
depth=[1:1:totNum]*layer_grid;       %A, coordinates for each points

% evaluate kk, Beta
for ii=1:1:totNum    
if EH
   kk(ii)=sqrt(2*mh_div(ii)*m0*(E-Eh_div(ii)))/hb; % /cm
else
    kk(ii)=1i*sqrt(2*mh_div(ii)*m0*(E-Eh_div(ii)))/hb;
end
    Beta(ii)=1i*kk(ii)/mh_div(ii)/m0;
end

% for the first layer
amplitude(:,1)=fun_matrix_next(Beta(end),Beta(1),kk(1),layer_grid)*cd;
% from second layer to end
for ii=2:1:totNum
     amplitude(:,ii)=fun_matrix_next(Beta(ii-1),Beta(ii),kk(ii),layer_grid)*amplitude(:,ii-1);
end
add=amplitude(1,:)+amplitude(2,:);
Field_tot=abs(add).^2;
period=totNum/sum(thick/layer_grid);
tot=trapz(depth,Field_tot)/period;
Field_tot=Field_tot/tot;
add=add/sqrt(tot);
%%
figure;
Field_plot=E-Field_tot*10;

plot(depth, [Eh_div;Field_plot],'o-')
%plot(depth, Field_tot,'o-')
xlabel('\fontsize{14} distance(angstrom)');
%ylabel('\fontsize{14} Energy (eV)') 
title(['\fontsize{14} 1-Band Model, ']);
%legend('\fontsize{14}E_c','\fontsize{14}E_h_h','\fontsize{14}Eigen','\fontsize{14}|\psi_h_h|^2','location','best')
grid on

%%
% figure;
% 
% plot(depth, fliplr(band),'linewidth',2)
% 
% xlabel('\fontsize{14} Upwards(angstrom)');
% ylabel('\fontsize{14} Energy (eV)') 
% title(['\fontsize{14} 1-Band Model, E=',num2str(E_eigen),' eV']);
% legend('\fontsize{14}E_c','\fontsize{14}E_h_h','\fontsize{14}Eigen','\fontsize{14}|\psi_h_h|^2','location','best')

grid on
