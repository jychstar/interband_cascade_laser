
function [index,plasmon_wavelength]=fun_nik_InAs(NN,lambda, band)
% input NN in cm^-3, lambda in um, 2 or 8 for multi-band model
% output complex index of InAs, plasmon wavelength in um

% last update: 2016-3-18 for effectie mass
% Mobility model: Baranov's equation
% epsilon_inf: 12.25

global m0 hb k0 q c0 epsilon0 mu0 Eg
T=300; %K
m0=5.685777e-16;   %[eV cm^-2 s^2]
hb=6.579465e-16;   %[eV s]
k0=8.6174e-5; %[eV K^-1]
q=1.60217733e-19; %[C]
c0=2.99792458e10; %[cm/s]
epsilon0=8.85419e-14*q;%[C V^-1 cm^-1]
mu0=1.25666e-8/q;%[A s V^-1 cm^-1]
Eg=0.3538; % 300K % JAP,89,5826(2001)

%% InAs effective mass
mc0=0.023;
Ds=0.39;
Ep_2band=(1/mc0-1)*Eg;
Ep_8band=(1/mc0-1)*Eg*(Eg+Ds)/(Eg+Ds*2/3);

kf=(3*pi^2*NN)^(1/3);   % Fermi wavevector
k_energy=hb^2*kf^2/2/m0;
x=sqrt(k_energy);

% 2 band model

if (band==2)
    Ep=Ep_2band;
    mc_i=1+(Eg^2+4*k_energy*Ep).^(-0.5)*Ep;  % 2 band model and 1/m*~dE/dk/k
    mc=1/mc_i;
end
% 8 band model
if (band==8)
    Ep=Ep_8band;
    %solution for cubic function
    a=1;
    b=Ds-Eg;
    c=-(Ds*Eg+x.^2*Ep);
    d=-x.^2*Ep*2/3*Ds;
    %dist=18*a*b*c.*d-4*b^3*d+b^2*c.^2-4*a*c.^3-27*a^2*d.^2; % >0
    u1=exp(1i*2*pi/3);

    delta0=b^2-3*a*c;
    delta1=2*b^3-9*a*b*c+27*a^2*d;
    D=delta1+sqrt(delta1^2-4*delta0^3);
    C=(D/2)^(1/3);
    %Ec_4band=-1/3/a*(b+u1*C+delta0./C/u1)+x.^2;  %c

    diff_delta0=6*x*Ep;
    diff_delta1=18*b*x*Ep-36*x*Ep*Ds;
    diff_D=diff_delta1+0.5*(delta1^2-4*delta0^3)^(-0.5)*(2*delta1*diff_delta1-12*delta0^2*diff_delta0);
    diff_C=1/6*(D/2)^(-2/3)*diff_D;
    diff_E=-1/3*(u1*diff_C+(diff_delta0*C-delta0*diff_C)/u1/C^2)+2*x;
    diff_E=real(diff_E);
    mc=2*x/diff_E;
end

% Caughey-Thomas-like formula
% Mobility using Baranov's empirical model
Un=3e4./(1+(NN/8e17).^0.75);

% Drude model,Doping effect,IEE Proceedings - Optoelectronics. 150,284(2003)

lambda=lambda*1e-4; %cm  emitting wavelength
w=c0*2*pi/lambda;  %[Hz] circular frequency

mc=mc*m0 ;

%epsilon_inf=12.37;   % 2003 Madelung pdf 494
epsilon_inf=12.25;    % JAP,81,1890(1997) or SPIE,69090U (2008)
%epsilon_inf=11.7;    % JAP,36,1841(1965)

tau=Un.*mc; % relaxation time

wp=sqrt(NN*q^2/(mc*epsilon_inf*epsilon0)); %[Hz]Plasmon frequency,circular
plasmon_wavelength=c0*2*pi/wp*1e4; %um

%epsilon=epsilon_inf*(1-wp.^2./(w^2-1i*w/tau));%only plasma effect

wL=c0*2*pi*243.3;
wT=c0*2*pi*218.9;
epsilon=epsilon_inf*(1-wp.^2./(w^2-1i*w/tau)+(wL^2-wT^2)/(wT^2-w^2));%both plasma and phonon effect

%n=real(sqrt(epsilon));
%k=-imag(sqrt(epsilon));
index=sqrt(epsilon);
