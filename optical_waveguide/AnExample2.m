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
lambda=0.63; % um, emitting wavelength
k0=2*pi/lambda;  % wavevector, in 1/um

Nr=201;  % number of poins to get the real part of effective index
Ni=201;  % number of poins to get the imagenary part of effective index
xr=linspace(3.2,3.6,Nr); % generate Nr points in an estiamted range of index
xi=-linspace(-1,1,Ni)/k0/2*1e-4;   % range of loss in cm^-1, loss= 2*k0*imag(complex index)

% assign refractive index to specific material or region


% assgin refractive index to each layer
r1=3.191;
r2=3.27;
r3=3.6;
r4=r2;
r5=r1;

% assign thickness in um to each layer
t1=2;
t2=0.12;
t3=0.01;
t4=t2;
t5=t1;


opticl_field_file='optical_field.txt';  % assign file name for output
far_field_file='far_field.txt';

% build waveguide structure 
thick=[ t1,t2,t3,t4,t5];% thinkness of each layer, in um
ref=[   r1,r2,r3,r4,r5];
active_layer_sequence=3;  % indicate which layer is cascade active region, from top

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