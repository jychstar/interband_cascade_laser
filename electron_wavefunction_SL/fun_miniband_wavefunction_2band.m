
function [Field_plot,add]=fun_miniband_wavefunction_2band(E,Ec,El,thick,Ec_div,El_div,layer_grid)
% electron wavefunction profile by 2 band model
% output 1: band profile, wave profile based on the eigen value
% output 2: wavefunction for oscillator strength calculation

global P hb

% get matrix
M=fun_miniband_matrix_2band(E,Ec,El,thick); 

% get the initial amplitude, this is the most tricky step
theta=acos(trace(M)/2);
A0=M(1,2)/(exp(1i*theta)-M(1,1));% note:(A0,B0) are not in the initial position

% for the layer before the first layer
  
k=sqrt((E-Ec).*(E-El))/hb/P;  % /cm   
beta=hb*P*k./(E-El);
cd=fun_matrix_previous(beta(end),beta(1),k(1),thick(1))*[A0;1];

% allocate memory
totNum=length(Ec_div);  % total plot points
amplitude=zeros(2,totNum);
kk=zeros(1,totNum);
Beta=zeros(1,totNum);
depth=[1:1:totNum]*layer_grid;       %A, coordinates for each points

% evaluate kk, Beta
for ii=1:1:totNum
    kk(ii)=sqrt((E-Ec_div(ii))*(E-El_div(ii)))/hb/P;  % /cm
    Beta(ii)=hb*P*kk(ii)/(E-El_div(ii));
end

% for the first layer
amplitude(:,1)=fun_matrix_next(Beta(end),Beta(1),kk(1),layer_grid)*cd;
% from second layer to end
for ii=2:1:totNum
     amplitude(:,ii)=fun_matrix_next(Beta(ii-1),Beta(ii),kk(ii),layer_grid)*amplitude(:,ii-1);
end


add=amplitude(1,:)+amplitude(2,:);           % electron component 
minus=(amplitude(1,:)-amplitude(2,:)).*Beta; %light hole component
Field_e=abs(add).^2;  % moduli squared,electron component 
Field_h=abs(minus).^2;   % light hole component 
Field_tot=Field_e+Field_h; % total 
period=totNum/sum(thick/layer_grid);
tot=trapz(depth,Field_tot)/period; % normalize in one period

Field_e=Field_e/tot;   % normalized
Field_h=Field_h/tot;  % normalized
Field_tot=Field_tot/tot; % normalized
add=add/sqrt(tot);% for overlap calculatio
%%
figure;
Field_plot=E+Field_tot*10;
plot(depth, [Ec_div;El_div;Field_plot],'o-')
xlabel('\fontsize{14} distance(angstrom)');
%ylabel('\fontsize{14} Energy (eV)') 
title(['\fontsize{14} 2-Band Model, ']);
%legend('\fontsize{14}E_c','\fontsize{14}E_h_h','\fontsize{14}Eigen','\fontsize{14}|\psi_h_h|^2','location','best')
grid on
