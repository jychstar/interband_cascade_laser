% BandEdgeShift
% JAP,89,5815(2001)
% calculate the band edge shift due to strain effect 

clear all
close all
clc
m0=5.685777e-16;   %[eV cm^-2 s^2]
%% Parameters
a_GaAs=5.65325;  a_AlAs=5.6611;  a_InAs=6.0583; a_GaSb=6.0959; a_AlSb=6.1355; a_InSb=6.4794; %[A]
Eg_GaAs=1.424;  Eg_AlAs=3.03;   Eg_InAs=.354;   Eg_GaSb=0.73;  Eg_AlSb=2.3;   Eg_InSb=0.18; %[eV]
Ds_GaAs=0.341;   Ds_AlAs=0.28;   Ds_InAs=0.39;  Ds_GaSb=0.76;  Ds_AlSb=0.676; Ds_InSb=0.81;%[eV]
r1_GaAs=6.98;    r1_AlAs=3.76;   r1_InAs=20.0;  r1_GaSb=13.4;  r1_AlSb=5.18;  r1_InSb=34.8;       
r2_GaAs=2.06;    r2_AlAs=0.82;   r2_InAs=8.5;   r2_GaSb=4.7;   r2_AlSb=1.19;  r2_InSb=15.5;
ac_GaAs=-7.17;  ac_AlAs=-5.64;  ac_InAs=-5.08;  ac_GaSb=-7.5;  ac_AlSb=-4.5;  ac_InSb=-6.94;%[eV]
av_GaAs=1.16;   av_AlAs=2.47;   av_InAs=1.00;   av_GaSb=0.8;   av_AlSb=1.4;   av_InSb=0.36;%[eV]
b_GaAs=-2.0;    b_AlAs=-2.3;    b_InAs=-1.8;    b_GaSb=-2.0;   b_AlSb=-1.35;  b_InSb=-2.0;%[eV]
C11_GaAs=1221; C11_AlAs=1250;  C11_InAs=832.9; C11_GaSb=884.2; C11_AlSb=876.9; C11_InSb=684.7; %[GPa]
C12_GaAs=566;  C12_AlAs=534;   C12_InAs=452.6; C12_GaSb=402.6; C12_AlSb=434.1; C12_InSb=373.5; %[GPa]
mc_GaAs=0.067;  mc_AlAs=0.15;  mc_InAs=0.026;  mc_GaSb=0.039;  mc_AlSb=0.14;   mc_InSb=0.0135; %[m0]

%% select substrate and reference level
as=a_GaSb;
% E_ref=-6.5433  % Ev(InAs) on InAs substrate

%% select material
material='InAs';

if strcmp(material,'InAs')
    disp(' %%  InAs  %%')
    ax=a_InAs;C11=C11_InAs;C12=C12_InAs;
    Ds=Ds_InAs;r1=r1_InAs;r2=r2_InAs;
    ac=ac_InAs;av=av_InAs;b=b_InAs;Eg=Eg_InAs;
elseif strcmp(material,'GaSb')
    disp(' %%  GaSb  %%')
    ax=a_GaSb;C11=C11_GaSb;C12=C12_GaSb;
    Ds=Ds_GaSb;r1=r1_GaSb;r2=r2_GaSb;
    ac=ac_GaSb;av=av_GaSb;b=b_GaSb;Eg=Eg_GaSb;
elseif strcmp(material,'AlSb')
    disp(' %%  AlSb  %%')
    ax=a_AlSb;C11=C11_AlSb;C12=C12_AlSb;
    Ds=Ds_AlSb;r1=r1_AlSb;r2=r2_AlSb;
    ac=ac_AlSb;av=av_AlSb;b=b_AlSb;Eg=Eg_AlSb;
elseif strcmp(material,'AlAs')
    disp(' %%  AlAs  %%')
    ax=a_AlAs;C11=C11_AlAs;C12=C12_AlAs;
    Ds=Ds_AlAs;r1=r1_AlAs;r2=r2_AlAs;
    ac=ac_AlAs;av=av_AlAs;b=b_AlAs;Eg=Eg_AlAs;
elseif strcmp(material,'GaAs')
    disp(' %%  GaAs  %%')
    ax=a_GaAs;C11=C11_GaAs;C12=C12_GaAs;
    Ds=Ds_GaAs;r1=r1_GaAs;r2=r2_GaAs;
    ac=ac_GaAs;av=av_GaAs;b=b_GaAs;Eg=Eg_GaAs;
elseif strcmp(material,'InSb')
    disp(' %%  InSb  %%')
    ax=a_InSb;C11=C11_InSb;C12=C12_InSb;
    Ds=Ds_InSb;r1=r1_InSb;r2=r2_InSb;
    ac=ac_InSb;av=av_InSb;b=b_InSb;Eg=Eg_InSb;
end

 %% strain effect on the band edge
 format short
  exx=(as-ax)/ax
  eyy=exx;   %   
  ezz=-exx*2*C12/C11     %
  Pce=ac*(exx+eyy+ezz);
  Pe=-av*(exx+eyy+ezz)    
  Qe=-b*(exx-ezz) 
  LSD=sqrt(Ds^2+2*Ds*Qe+9*Qe^2);%    
    
  shift_Ec=Pce
  shift_Ehh=-Pe-Qe
  shift_Elh=-Pe+0.5*(Qe-Ds+LSD)
  shift_Eso=-Pe+0.5*(Qe-Ds-LSD);
  mlhz=1/(r1+2*r2) 
  mhhz=1/(r1-2*r2)
  Eg
  Eeff=Eg+shift_Ec-shift_Elh
 
disp('%%%%%%%%%% program  end %%%%%%%%%%%%%%%%%%%%%%%%%%') 