%%
% This example file is a main file to run for the calculation of waveguide
% Please put the following functions (file name begin with "fun..") in the same folder with main file, which calls these sub-codes.

% This example is based on "inner cladding" waveguide. The result is part of Fig. 1 for a paper published in http://dx.doi.org/10.1063/1.4922995

%% input waveguide parameter
% clc
clear all
close all
tic % time program run tim

TE=1; % TE=1 for TE mode, TE=0 for TM mode
lambda=4.6; % um, emitting wavelength
k0=2*pi/lambda;  % wavevector, in 1/um

Nr=201;  % number of poins to get the real part of effective index
Ni=201;  % number of poins to get the imagenary part of effective index
xr=linspace(3.35,3.5,Nr); % generate Nr points in an estiamted range of index
xi=-linspace(1,21,Ni)/k0/2*1e-4;   % range of loss in cm^-1, loss= 2*k0*imag(complex index)

% assign refractive index to specific material or region
AlSb=3.2032;
GaSb=3.7263;
SL=3.354437-0.000063i;
InAs=3.49458;
InAs_plus=fun_nik_InAs(1e19,4.6,2); % 3.0463 - 0.0082i
core=3.44744-0.00045i;

% assgin refractive index to each layer
r1=InAs_plus;
r2=SL;
r3=InAs;
r4=core;
r5=r3;
r6=r2;
r7=r1;

% assign thickness in um to each layer
t1=0.4;
t2=1.0;
t3=0.5;
t4=0.4;
t5=t3;
t6=t2;
t7=t1;

opticl_field_file='optical_field.txt';  % assign file name for output
far_field_file='far_field.txt';

% build waveguide structure 
thick=[ t1,t2,t3,t4,t5,t6,t7];% thinkness of each layer, in um
ref=[   r1,r2,r3,r4,r5,r6,r7];
active_layer_sequence=4;  % indicate which layer is cascade active region, from top

%% plot index profile
fun_index_overview(ref, thick,lambda);

%% get effective refractive index 
[Neff,Loss]=fun_getNeff(lambda,ref,thick,xr,xi,TE)

%% plot optical field
[confine,depth,field,index]=fun_opticalField(lambda,ref,thick,Neff,Loss,TE,active_layer_sequence,0.01);
% the above Loss is actually only free-carrier absorption loss
otherLoss=10; % estimate other loss, including mirror loss
Gth=(-Loss+10)/confine % estimate threshold gain

% output
output1=[depth',field',index'];
save(opticl_field_file,'output1','-ascii')

%% plot far-field pattern
[FWHM,theta,Efar]=fun_farField(lambda,depth,field,Neff,TE);
% output
output2=[theta',Efar'];
save(far_field_file,'output2','-ascii')

toc
disp('Programme  end')