%Absorption_GaSb_bulk_nonparabolic
 
%  2016-3-18

clear all
close all
format long
%--------Physical Constants-----------------  
global m0 hb k0 q c0 epsilon0 mu0
T=300; %K
m0=5.685777e-16;   %[eV cm^-2 s^2]
hb=6.579465e-16;   %[eV s] 
k0=8.6174e-5; %[eV K^-1]
q=1.60217733e-19; %[C]
c0=2.99792458e10; %[cm/s]
epsilon0=8.85419e-14*q;%[C V^-1 cm^-1]
mu0=1.25666e-8/q;%[A s V^-1 cm^-1]
%--------- Parameter --------------------
a_GaAs=5.6533;  a_AlAs=5.6600;  a_InAs=6.0584;  a_InP=5.8688;  a_GaP=5.4505;  a_GaSb=0.60959; %[A]
Eg_GaAs=1.424;  Eg_AlAs=3.03;   Eg_InAs=.354;   Eg_InP=1.35;   Eg_GaP=2.78;   Eg_GaSb=0.73; %[eV]
Ds_GaAs=0.341;  Ds_AlAs=0.28;   Ds_InAs=0.39;   Ds_InP=0.108;                 Ds_GaSb=0.76; %[eV] spin-orbit split energy

mc_GaAs=0.067;  mc_AlAs=0.15;   mc_InAs=0.023;  mc_InP=0.077;  mc_GaP=0.025;  mc_GaSb=0.039;%[m0]
mhh_GaAs=0.50;  mhh_AlAs=0.79;  mhh_InAs=0.40;  mhh_InP=0.60;  mhh_GaP=0.67;  mhh_GaSb=0.25;%[m0]
mlh_GaAs=0.087; mlh_AlAs=0.15;  mlh_InAs=0.026; mlh_InP=0.12;  mlh_GaP=0.17;  mlh_GaSb=0.0439;%[m0]
Ep_GaAs=28.8;   Ep_AlAs=21.1;   Ep_InAs=21.5;   Ep_InP=20.7;                  Ep_GaSb= 27 ;  %[eV]

n_InAs=3.5; n_GaSb=3.8; n_InSb_=4.0; n_GaAs=3.3;
%----------input data --------------------
mc=mc_GaSb;
mhh=mhh_GaSb;
mlh=mlh_GaSb;
Eg=Eg_GaSb;
Ds=Ds_GaSb;
Ep=Ep_GaSb;
nb=n_GaSb;  

mv=(mhh^1.5+mlh^1.5)^(2/3);



%Ep=(1/mc-1)*Eg % Ep for 2band
epsilon=0:0.001/10:sqrt(Eg/Ep)/10;   % epsilon =k^2*hb^2/2/m0

mck_inverse=1+(Eg^2+4*epsilon*Ep).^(-0.5)*Ep;   %1/mc(k)
mlk_inverse=1-(Eg^2+4*epsilon*Ep).^(-0.5)*Ep;   %1/mlh(k)
mlh=1./mlk_inverse;

mchh=1./(mck_inverse+1/mhh); % jonit effective mass of CB and HHB
mclh=1./(2*(Eg^2+4*epsilon*Ep).^(-0.5)*Ep);

Et_hh=-Eg/2+sqrt(Eg^2+4*epsilon*Ep)/2+epsilon+1/mhh*epsilon;
E=Eg+Et_hh;  %eV, 6.2-4l

Mb2=Ep*m0/6; % 1/3* px^2
Nj=1/(2*pi^2)*(2*mchh*m0/(hb^2)).^1.5.*sqrt(Et_hh); % cm^-3, eV^-1, joint density of states, unrelated to T
absorb_hh=pi*q^2*hb./(nb*m0^2*c0*epsilon0*E)*Mb2.*Nj;   % cm-1, 6.2-4l

%% lh
Et_lh=-Eg+sqrt(Eg^2+4*epsilon*Ep);
E_lh=Eg+Et_lh;  %eV, 6.2-4l

Nj_lh=1/(2*pi^2)*(2*mclh*m0/(hb^2)).^1.5.*sqrt(Et_lh); % cm^-3, eV^-1, joint density of states, unrelated to T
absorb_lh=pi*q^2*hb./(nb*m0^2*c0*epsilon0*E_lh)*Mb2.*Nj_lh;   % cm-1, 6.2-4l

% interpolate the value to evenly spaced energy step
E1=0:0.001:0.5;  % eV
absorb_hh1=interp1(Et_hh, absorb_hh,E1,'linear','extrap');
%absorb_hh1=interp1(Et_hh, absorb_hh,E1,'linear');
absorb_lh1=interp1(Et_lh, absorb_lh,E1,'linear');
absorb_tot=absorb_hh1+absorb_lh1;

figure(1)

semilogy(E1+Eg, absorb_hh1,'r','linewidth',2); hold on
%plot(E1, absorb_lh1,'ob');
plot(E1+Eg, absorb_tot,'ob');

%plot(Et,1./mck_inverse,'o')
grid on
xlabel('E (eV)','fontsize',15);
ylabel('Absorption (cm^-^1)','fontsize',15)
title('Absorption coefficient in GaSb bulk, nonparabolic m*','fontsize',12.5)
legend('\fontsize{15}hh absorption','\fontsize{15}total absorption')
output=[E1',absorb_hh1',absorb_tot'];
 save('absorption in bulk.txt','output','-ascii')
