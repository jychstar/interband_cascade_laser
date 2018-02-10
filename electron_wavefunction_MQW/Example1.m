
%%
% Exmaple1.m
% This is a main code for the calculation of wavefunction
% The structure is the active region of lasers in http://dx.doi.org/10.1038/ncomms1595

close all
clear
disp(' start ---------')
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
thick=[  30;   10  ;     14;         30 ;  17;    25  ];  % angstrom, thinkness of each layer
Ec=[Ec_GaSb;Ec_AlSb;Ec_InAs;Ec_GaInSb_35;Ec_InAs;Ec_AlSb];% conduction band edge
El=[El_GaSb;El_AlSb;El_InAs;El_GaInSb_35;El_InAs;El_AlSb];% light hole valence band edge
Eh=[Eh_GaSb;Eh_AlSb;Eh_InAs;Eh_GaInSb_35;Eh_InAs;Eh_AlSb];% heavy hole valence band edge
mh=[mh_GaSb;mh_AlSb;mh_InAs;mh_GaInSb_35;mh_InAs;mh_AlSb];% heavy hole effective mass

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
        xr=linspace(0.85,0.95,Nr);  % Ea1
    elseif Vext==-70
        xr=linspace(0.9,0.95,Nr); % Ea2, minor E2
    end
    
    force2zero=0; % force remaining layers to zero, for calculating wavefunction in electron injector
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
        xr=linspace(0.56,0.57,Nr); % Ha
    elseif Vext==-70
        xr=linspace(0.56,0.6,Nr); % Ea1
    end
    
    force2zero=0; % force remaining layers to zero, for calculating wavefunction in hole injector
    [E_eigen,Ec_div,Eh_div,mh_div,depth]=fun_EigenValue_1band_ext(thick,layer_grid,Ec,Eh,mh,xr,Vext,EH);
    [add2,amplitude2,Field_plot2]=fun_field_1band_ext(E_eigen,Ec_div,Eh_div,mh_div,thick,layer_grid,depth,Vext,EH,force2zero);
    %add2 is heavyhole wavefunction
    E2=E_eigen;% store eigen value for heavy hole
    output2=[depth',fliplr([Ec_div;Eh_div;Field_plot2])']; % upward direction, fliplr because input is downward
    save(outputFileName2,'output2','-ascii'); %
end
%
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

%
% %% get overlap waveform and output to txt file
% if 0
%     m1=abs(y1).^2;  % moduli squared
%     m2=abs(y2).^2;
%
%     m3=m1;  % m3=overlap
%     for ii=1:1:length(m1)
%         if m2(ii)<m1(ii)
%             m3(ii)=m2(ii);
%         end
%     end
%     output=[depth',fliplr(m1)',fliplr(m2)',fliplr(m3)',fliplr(Ec_div)',fliplr(Ev_div)',E1',E2'];
%     save(outputFileName,'output','-ascii');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%