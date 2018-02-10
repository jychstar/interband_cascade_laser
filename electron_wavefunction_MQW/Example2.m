%%
% Exmaple2.m
% This is a main code for the calculation of wavefunction
% The structure is the cascade region of lasers in http://dx.doi.org/10.1038/ncomms1595

tic
close all
clear
disp(' start #################################')
%--------Physical Constants-----------------
global m0 hb P c0
m0=5.685777e-16;   %[eV cm^-2 s^2]
hb=6.5821153e-16;   %[eV s]
P=1.106e8;         % cm/s
c0=2.99792458e10; %[cm/s]

outputFileName='Example1.txt'; 
outputFileName1='Example1_e.txt'; 
outputFileName2='Example1_h.txt'; 

bandoffset = 1; % choose 0 for unstrained, 1 for GaSb based, 2 for InAs based
band_offset_collection; % input band offset

%% input structure, from top to bottom
thick=[  25;     45;    10 ;     30;   10  ;     14;         30 ;   17;    25   ;  17   ;  12   ;   17  ;     12;   20  ;   12  ;  25   ;   12  ;    32 ;  12  ;      42;   25 ];% A thinkness of each layer
Ec=[Ec_AlSb;Ec_GaSb;Ec_AlSb;Ec_GaSb;Ec_AlSb;Ec_InAs;Ec_GaInSb_35;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb;Ec_InAs;Ec_AlSb];
El=[El_AlSb;El_GaSb;El_AlSb;El_GaSb;El_AlSb;El_InAs;El_GaInSb_35;El_InAs;El_AlSb;El_InAs;El_AlSb;El_InAs;El_AlSb;El_InAs;El_AlSb;El_InAs;El_AlSb;El_InAs;El_AlSb;El_InAs;El_AlSb];
Eh=[Eh_AlSb;Eh_GaSb;Eh_AlSb;Eh_GaSb;Eh_AlSb;Eh_InAs;Eh_GaInSb_35;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb;Eh_InAs;Eh_AlSb];
mh=[mh_AlSb;mh_GaSb;mh_AlSb;mh_GaSb;mh_AlSb;mh_InAs;mh_GaInSb_35;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb;mh_InAs;mh_AlSb]; % heavy hole

Vext=-70;  % kV/cm,= V/m, exteral electrical field
display(['Vext=',num2str(Vext)]);

% task selection
get_e_wavefunction= 1;
get_h_wavefunction= 1;

% fine tune calculation accuracy
Nr=201;  % number of points
layer_grid=1;  % in angstrom, this number should not be larger then 
% further fine tune is done by changing xr, force2zero

%% calculate electron wavefunction
if (get_e_wavefunction==1)    
    EH=1;  % 1 for electron, 0 for hole
    if Vext==0
        %xr=linspace(0.62137931,0.62137934,Nr);    % 2 band model, electron, 0th state
        %xr=linspace(0.7192550,0.7192552,Nr); 
        %xr=linspace(0.826478,0.82648,Nr);
        xr=linspace(0.9066,0.90663,Nr);  % Ea1
        %xr=linspace(0.9353,0.935302,Nr);
        %xr=linspace(1.0063,1.00632,Nr);
        %xr=linspace(1.065715,1.065717,Nr);
        %xr=linspace(1.08348,1.08349,Nr);
 
    elseif Vext==-70
        %xr=linspace(0.8,1.15,Nr); % overall scan
        %xr=linspace(0.7420967186,0.7420967188,Nr);   % 1st ejection QW
        %xr=linspace(0.8082847,0.8082849,Nr);   % 2nd ejection
        xr=linspace(0.85,0.95,Nr); force2zero=13; % 1st acive QW
        %xr=linspace(0.886828844,0.886828846,Nr);  % 3rd ejection QW
        %xr=linspace(0.96744,0.96746,Nr);  % 4th
        %xr=linspace(1.0098,1.01,Nr);      % 2nd active
        %xr=linspace(1.0154,1.0156,Nr);   % 6th
        %xr=linspace(1.09242,1.09244,Nr);  % 5th 


    end
    
    %force2zero=0; % force remaining layers to zero, for calculating wavefunction in electron injector
    [E_eigen,Ec_div,El_div,depth]=fun_EigenValue_2band_ext(thick,layer_grid,Ec,El,xr,Vext,EH); % get eigen energy value for electron
    [add1,amplitude1,Field_plot1]=fun_field_2band_ext(E_eigen,Ec_div,El_div,thick,layer_grid,depth,Vext,EH,force2zero); % calculate electron wavefunction
    % add1 is electron conponent of the wavefunction, normalized
    E1=E_eigen; % store eigen value for electron
    output1=[depth',fliplr([Ec_div;El_div;Field_plot1])']; % upward direction
    save(outputFileName1,'output1','-ascii');

end

%% calculate hole wavefunction
if (get_h_wavefunction==1)
    EH=0;  % 1 for electron, 0 for hole
    if Vext==0
        %xr=linspace(0.48687,0.486872,Nr); % H2  the order is from right to left
        %xr=linspace(0.519513,0.519515,Nr); % H1
        xr=linspace(0.56190,0.56191,Nr); % Ha
    
   elseif Vext==-70
        %xr=linspace(0.35,0.65,Nr); % scan   
        xr=linspace(0.60,0.62,Nr);force2zero=14; % active
        % xr=linspace(0.40320,0.40322,Nr);  %H1
        % xr=linspace(0.391,0.393,Nr); % H2

    end
    %force2zero=0; % force remaining layers to zero, for calculating wavefunction in hole injector
    [E_eigen,Ec_div,Eh_div,mh_div,depth]=fun_EigenValue_1band_ext(thick,layer_grid,Ec,Eh,mh,xr,Vext,EH);
    [add2,amplitude2,Field_plot2]=fun_field_1band_ext(E_eigen,Ec_div,Eh_div,mh_div,thick,layer_grid,depth,Vext,EH,force2zero);
    %add2 is heavyhole wavefunction
    E2=E_eigen;% store eigen value for heavy hole
    output2=[depth',fliplr([Ec_div;Eh_div;Field_plot2])']; % upward direction, fliplr because input is downward
    save(outputFileName2,'output2','-ascii'); %
end

%% execute following after get both e and h energy
if (get_e_wavefunction==1)&&(get_h_wavefunction==1)    
    photonEnery=E1-E2;
    wavelength=2*pi*hb*c0/photonEnery*1e4;  % um
  % calculate overlap factor
    integral=trapz(depth,abs(conj(add1).*add2));
    oscillatorStrength=abs(integral)^2;
    disp(['photon Enery =',num2str(photonEnery),' eV']);
    disp(['wavelength =',num2str(wavelength),' um']);
    disp(['oscillator Strength =',num2str(oscillatorStrength)]);
% plot both waves 
    band=[Ec_div;Eh_div;Field_plot1;Field_plot2]; 
    figure
    plot(depth,fliplr(band),'linewidth',2)
    xlabel('\fontsize{14} Upwards,angstrom');
    ylabel('\fontsize{14} Energy (eV)')
    title(['\fontsize{14} V_e_x_t=',num2str(Vext),' kV/cm, \lambda=',num2str(wavelength,3),'\mum/',num2str(photonEnery,3),' eV,Overlap=',num2str(oscillatorStrength,3)]);
    legend('\fontsize{14} CB','\fontsize{14}HHB','\fontsize{14}|\psi_e|^2','\fontsize{14}|\psi_h_h|^2','location','best')
    output=[depth',fliplr(band)'];
    save(outputFileName,'output','-ascii');
    disp('output complete')
end
toc