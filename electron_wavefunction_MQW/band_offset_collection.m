% band_offset_collection.m
% list all the possible parameters
% Ec,Ehh,Elh,mhh
% last update 2016-8-15

if bandoffset == 0 % JAP,89,5815(2001) unstrained    
    disp('%% band offset: unstrained  %%')
    Ec_GaSb=1.29; El_GaSb=0.56;  Eh_GaSb=0.56;   mh_GaSb=0.25;
    Ec_AlSb=2.48; El_AlSb=0.18;  Eh_AlSb=0.18;   mh_AlSb=0.357;
    Ec_AlAs=2.71; El_AlAs=-0.32; Eh_AlAs=-0.32;  mh_AlAs=0.47;
    Ec_GaAs=1.634;El_GaAs=0.7645;Eh_GaAs=0.013;  mh_GaAs=0.35;
    Ec_InAs=0.354;El_InAs=0;     Eh_InAs=0;      mh_InAs=0.33;
    Ec_InSb=0.77; El_InSb=0.497; Eh_InSb=0.8405; mh_InSb=0.26;
    
    Ec_GaInSb_30=1.134;El_GaInSb_30=0.569;Eh_GaInSb_30=0.569;mh_GaInSb_30=0.253;
    Ec_GaInSb_35=1.108;El_GaInSb_35=0.5705;Eh_GaInSb_35=0.5201;mh_GaInSb_35=0.2535;
    
elseif bandoffset == 1 % JAP,89,5815(2001) GaSb based, no exception, bowing for GaInSb
    disp('%% band offset: GaSb based  %%')
    Ec_GaSb=1.29; El_GaSb=0.56; Eh_GaSb=0.56; mh_GaSb=0.25;
    Ec_AlSb=2.5093;El_AlSb=0.1544; Eh_AlSb=0.1882;  mh_AlSb=0.357;
    Ec_InAs=0.3252;El_InAs=0.0316; Eh_InAs=-0.0176; mh_InAs=0.33;
    Ec_InSb=1.1434;El_InSb=0.499;  Eh_InSb=0.8182; mh_InSb=0.26;
    Ec_GaInSb_30=1.15887;El_GaInSb_30=0.5417;Eh_GaInSb_30=0.63746;mh_GaInSb_30=0.253;
    Ec_GaInSb_35=1.14428;El_GaInSb_35=0.53865;Eh_GaInSb_35=0.65037;mh_GaInSb_35=0.2535;
    
elseif bandoffset == 2 % JAP,89,5815(2001) InAs based, no exception, bowing for GaInSb,AlAsSb
    disp('%% band offset: InAs based  %%')
    Ec_GaSb=1.3404; El_GaSb=0.5326; Eh_GaSb=0.5782; mh_GaSb=0.25;
    Ec_AlSb=2.5372; El_AlSb=0.1319; Eh_AlSb=0.196;  mh_AlSb=0.357;
    Ec_AlAs=2.2567; El_AlAs=0.401;  Eh_AlAs=-0.4207;mh_AlAs=0.47;
    Ec_GaAs=1.0828; El_GaAs=0.7645; Eh_GaAs=0.013;  mh_GaAs=0.35;
    Ec_InAs=0.354;  El_InAs=0;      Eh_InAs=0;      mh_InAs=0.33;
    Ec_InSb=1.18;   El_InSb=0.497;  Eh_InSb=0.8405;  mh_InSb=0.26;
    
    Ec_GaInSb_24=1.22621;El_GaInSb_24=0.52406;Eh_GaInSb_24=0.64115;mh_GaInSb_24=0.2524;
    Ec_GaInSb_30=1.20513;El_GaInSb_30=0.52192;Eh_GaInSb_30=0.6569;mh_GaInSb_30=0.253;
    Ec_GaInSb_32=1.19877;El_GaInSb_32=0.52121;Eh_GaInSb_32=0.6621;mh_GaInSb_32=0.2532;
    Ec_GaInSb_35=1.18985;El_GaInSb_35=0.52014;Eh_GaInSb_35=0.6700;mh_GaInSb_35=0.2535;
    Ec_GaInSb_38=1.27945;El_GaInSb_38=0.51907;Eh_GaInSb_38=0.6779;mh_GaInSb_38=0.2538;
    Ec_AlAsSb_16=2.3848; El_AlAsSb_16=0.17496;Eh_AlAsSb_16=0.097328;mh_AlAsSb_16=0.3751;    
end
