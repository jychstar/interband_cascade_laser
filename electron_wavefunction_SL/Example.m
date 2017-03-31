% Example
% Modified from Miniband_R146.m
% Kronig-Penney model
% arbitrary layers
% major update on 2015-6-12
% subcode: fun_miniband_1band,  fun_miniband_2band,  fun_plot_miniband

clear all;
close all;
clc;
%--------Physical Constants-----------------
global m0 hb P
m0=5.685777e-16;   %[eV cm^-2 s^2]
hb=6.5821153e-16;   %[eV s]
P=1.106e8;          %[cm/s]

% Band offset parameter
% Yu, SSP, 46, 1(1992) GaSb based, bowing for GaInSb
Ec_GaSb=1.24;  El_GaSb=0.51;   Eh_GaSb=0.51;    mh_GaSb=0.25;
Ec_InAs=0.3252;El_InAs=0.0316; Eh_InAs=-0.0176; mh_InAs=0.33;
%Ec_InSb=1.0934;El_InSb=0.449;  Eh_InSb=0.768;   mh_InSb=0.26;
Ec_AlSb=2.4393;El_AlSb=0.0844; Eh_AlSb=0.1182;  mh_AlSb=0.357;

% input
Ec = [Ec_GaSb;Ec_AlSb;Ec_GaSb;Ec_InAs];
El = [El_GaSb;El_AlSb;El_GaSb;El_InAs];
Eh = [Eh_GaSb;Eh_AlSb;Eh_GaSb;Eh_InAs];
mh = [mh_GaSb;mh_AlSb;mh_GaSb;mh_InAs];
thick = [ 15;      8;     15;     27]; %A, thickhickness
period = 4; % set the number of SL periods to be displayed
output_file_name = 'Example.txt';

%% calculate miniband
energy=[0:0.0001:max(Eh)]; % eV,energy scan range in valance band
[miniband_bottom1, miniband_top1]=fun_miniband_1band(energy,Eh,mh,thick,0); % call subcode

energy=[min(Ec):0.001:max(Ec)];  % eV,energy scan range in conduction band
[miniband_bottom2, miniband_top2]=fun_miniband_2band(energy,Ec,El,thick); % call subcode

% % miniband width for each miniband
miniband_bottom=[miniband_bottom1,miniband_bottom2];
miniband_top=[miniband_top1,miniband_top2];

the_bandgap=miniband_bottom2(1)-miniband_top1(end)
wavelength=1.24./the_bandgap

%% construct miniband structure in given number of periods
layer_grid=1;%A, precision
subNum=thick/layer_grid;  % number of points in each layer
num_period=sum(subNum);     % number of points in one period
totNum=num_period*period;    % total number of points
depth=[1:1:totNum]*layer_grid;       %A, coordinates for each points

Ec_div=zeros(1,totNum);
El_div=zeros(1,totNum);
Eh_div=zeros(1,totNum);
mh_div=zeros(1,totNum);
last=0;
for i=1:1:period
    for j=1:1:length(thick)
        first=last+1;
        last=first+subNum(j)-1;   % get column numbers for write
        Ec_div(first:1:last)=Ec(j);
        El_div(first:1:last)=El(j);
        Eh_div(first:1:last)=Eh(j);
        mh_div(first:1:last)=mh(j);
    end
end

%% show miniband in band profile
band=[Ec_div;Eh_div];    % first row is Ec; %second row is Ev
[output]=fun_miniband_profile(depth,band,miniband_bottom,miniband_top); % call subcode
%output=[depth',band',miniband']
title(['\fontsize{14}Bandgap=',num2str(the_bandgap),' eV, \lambda=', num2str(wavelength),' \mum']);
save(output_file_name,'output','-ascii');  % save to txt file

% plot wavefunction
E=miniband_top1(end);  % fundamental state in VB
EH=0;  % EH=1 for CB, EH=0 for VB
[field_h,add_hh]=fun_miniband_wavefunction_1band(E,Eh,mh,thick,Eh_div,mh_div,layer_grid, EH);
E=miniband_bottom2(1);  % fundamental state in CB
[field_e,add_e]=fun_miniband_wavefunction_2band(E,Ec,El,thick,Ec_div,El_div,layer_grid);

integral=trapz(depth,abs(conj(add_e).*add_hh))/period;
oscillatorStrength=abs(integral)^2
figure
plot(depth, [Ec_div;Eh_div;field_e;field_h], 'linewidth',2)
xlabel('\fontsize{14} Distance (angstrom)')
ylabel('\fontsize{14} Energy (eV)')
title(['\fontsize{14} Bandgap=',num2str(the_bandgap,3),' eV, \lambda=', num2str(wavelength,3),' \mum, overlap=',num2str(oscillatorStrength)]);
legend('\fontsize{14} Ec','\fontsize{12}Eh','electron wave','heavy hole wave','location', 'best')
display('program end')