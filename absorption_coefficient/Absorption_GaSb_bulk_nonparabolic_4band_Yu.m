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
a_GaAs=5.6533;  a_AlAs=5.6600;  a_InAs=6.0584;  a_InP=5.8688;  a_GaP=5.4505;  a_GaSb=0.60959; a_InSb=6.4794;%[A]
Eg_GaAs=1.424;  Eg_AlAs=3.03;   Eg_InAs=.354;   Eg_InP=1.35;   Eg_GaP=2.78;   Eg_GaSb=0.73; Eg_InSb=0.18;%[eV]
Ds_GaAs=0.341;  Ds_AlAs=0.28;   Ds_InAs=0.39;   Ds_InP=0.108;                 Ds_GaSb=0.76;  Ds_InSb=0.81;%[eV] spin-orbit split energy

mc_GaAs=0.067;  mc_AlAs=0.15;   mc_InAs=0.023;  mc_InP=0.077;  mc_GaP=0.025;  mc_GaSb=0.039;mc_InSb=0.0135;%[m0]
mhh_GaAs=0.50;  mhh_AlAs=0.79;  mhh_InAs=0.40;  mhh_InP=0.60;  mhh_GaP=0.67;  mhh_GaSb=0.25;mhh_InSb=0.263;%[m0]
mlh_GaAs=0.087; mlh_AlAs=0.15;  mlh_InAs=0.026; mlh_InP=0.12;  mlh_GaP=0.17;  mlh_GaSb=0.0439;mlh_InSb=0.015;%[m0]
Ep_GaAs=28.8;   Ep_AlAs=21.1;   Ep_InAs=21.5;   Ep_InP=20.7;                  Ep_GaSb= 27 ;  Ep_InSb=23.3;%[eV]
nb_GaAs=3.3;                    nb_InAs=3.5;                                   nb_GaSb=3.8;  nb_InSb=4.0;

%----------input data --------------------
mc=mc_GaSb;
mhh=mhh_GaSb;
mlh=mlh_GaSb;
Eg=Eg_GaSb;
Ds=Ds_GaSb;
Ep=Ep_GaSb;  %28.8
nb=nb_GaSb;  % GaAs

 Ep_2band=(1/mc-1)*Eg;   % 21
 Ep_4band=(1/mc-1)*Eg*(Eg+Ds)/(Eg+Ds*2/3);   % 

Ep=Ep_4band;
 
dx=0.001;
x=10*dx:dx:0.15;
epsilon=x.^2;

%% solution for cubic function
a=1;
b=Ds-Eg;
c=-(Ds*Eg+x.^2*Ep);
d=-x.^2*Ep*2/3*Ds;
dist=18*a*b*c.*d-4*b^3*d+b^2*c.^2-4*a*c.^3-27*a^2*d.^2; % >0

u1=exp(1i*2*pi/3);
u2=exp(1i*4*pi/3);
u3=1;
delta0=b^2-3*a*c;
delta1=2*b^3-9*a*b*c+27*a^2*d;
C=((delta1+sqrt(delta1.^2-4*delta0.^3))/2).^(1/3);
Ec_4band=-1/3/a*(b+u1*C+delta0./C/u1)+x.^2;  %c
Elh_4band=-1/3/a*(b+u2*C+delta0./C/u2)+x.^2;  %lh
Eso_4band=-1/3/a*(b+u3*C+delta0./C/u3)+x.^2;  %so

Ec_4band=real(Ec_4band);
Elh_4band=real(Elh_4band);
Eso_4band=real(Eso_4band);

mc_4band=2./diff(Ec_4band,1)*dx.*x(2:end);   % numerical solution, length-2
mlh_4band=-2./diff(Elh_4band,1)*dx.*x(2:end);
mso_4band=-2./diff(Eso_4band,1)*dx.*x(2:end);

mchh=1./(1./mc_4band+1/mhh);         % joint effective mass of CB and HHB
mclh=1./(1./mc_4band+1./mlh_4band);  

Et_hh=Ec_4band-Eg+1/mhh*epsilon;
Et_hh=Et_hh(2:end); % length-2
E=Eg+Et_hh;  %eV, 6.2-4l

Mb2=Ep*m0/6; % 1/3* px^2
Nj=1/(2*pi^2)*(2*mchh*m0/(hb^2)).^1.5.*sqrt(Et_hh); % cm^-3, eV^-1, joint density of states, unrelated to T
absorb_hh=pi*q^2*hb./(nb*m0^2*c0*epsilon0*E)*Mb2.*Nj;   % cm-1, 6.2-4l


%% lh
Et_lh=Ec_4band-Eg-Elh_4band;
Et_lh=Et_lh(2:end); % length-2
E_lh=Eg+Et_lh;  %eV, 6.2-4l

Nj_lh=1/(2*pi^2)*(2*mclh*m0/(hb^2)).^1.5.*sqrt(Et_lh); % cm^-3, eV^-1, joint density of states, unrelated to T
absorb_lh=pi*q^2*hb./(nb*m0^2*c0*epsilon0*E_lh)*Mb2.*Nj_lh;   % cm-1, 6.2-4l


% interpolate the value to evenly spaced energy step
E1=0:0.001:0.3;  % eV
absorb_hh1=interp1(Et_hh, absorb_hh,E1,'linear');
%absorb_hh1=interp1(Et_hh, absorb_hh,E1,'linear');
absorb_lh1=interp1(Et_lh, absorb_lh,E1,'linear');
absorb_tot=absorb_hh1+absorb_lh1;

figure(1)
plot(Et_lh,mlh_4band,'o')
output=[Et_lh',mc_4band'];
 save('effective mass.txt','output','-ascii')

figure(2)

semilogy(E1+Eg, absorb_hh1,'r','linewidth',2); hold on
%plot(E1, absorb_lh1,'ob');
plot(E1+Eg, absorb_tot,'ob');


grid on
xlabel('E (eV)','fontsize',15);
ylabel('Absorption (cm^-^1)','fontsize',15)
title('Absorption coefficient in GaSb bulk, 1/m*~dE/dk/k','fontsize',12.5)
legend('\fontsize{15}hh absorption','\fontsize{15}total absorption')
output=[E1',absorb_hh1',absorb_tot'];
 save('absorption in bulk.txt','output','-ascii')
 ylim([1e3 2e4])
 %check
%  figure
%  plot([0,Et_lh], diff(Elh_4band,1))
