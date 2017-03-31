function [miniband_bottom, miniband_top]=fun_miniband_1band(energy, V,meff,thick,EH)
% get miniband by Kronig-Penney model & 1 band model 
% input: energy(eV, a range),V(eV),meff(m0),t(A)
% output: miniband_bottom, miniband_top,last_matrix

ff=zeros(1,length(energy));  % store f function
for ii=1:1:length(energy)
    E=energy(ii);
    M=fun_miniband_matrix_1band(E,V,meff,thick,EH);
    ff(ii)=0.5*trace(M);     
end  

minibandArea=zeros(1,length(energy)); % store miniband area info, defaul=0 is forbidden area.
ii=0;jj=0;
for m=2:1:length(energy)-1
    %
    if abs(ff(m))<=1,minibandArea(m)=1;  % allowed energy
    else minibandArea(m)=0;              % forbidden energy
    end
    % 
    if    (abs(ff(m))>=1 && abs(ff(m+1))<=1),ii=ii+1;miniband_bottom(ii)=energy(m+1); % store the energy at miniband edge
    elseif(abs(ff(m))<=1 && abs(ff(m+1))>=1),jj=jj+1;miniband_top(jj)=energy(m);    % store the energy at miniband edge
    end
end

if (ii==0) disp(' no miniband_bottom');miniband_bottom=[]; plot(energy,abs(ff),'linewidth',2); return
elseif (jj==0) disp(' no miniband_top');miniband_top=[]; plot(energy,abs(ff),'linewidth',2); return
% abandom unmatched miniband
elseif ii<=jj
   miniband_bottom=miniband_bottom(1:ii);
   miniband_top=miniband_top(1:ii);
elseif ii>jj
   miniband_bottom=miniband_bottom(1:jj);
   miniband_top=miniband_top(1:jj); 
end

figure
 
minibandArea(1)=0;minibandArea(end)=0;     %In the fill command,the polygon is closed by connecting the last vertex to the first.so it is necessary to control the first and last point.
fill(energy,minibandArea,'r');  
hold on;  
plot(energy,abs(ff),'linewidth',2); 
xlim([min(energy),max(energy)]);
ylim([0,2]);

legend('\fontsize{14}miniband','\fontsize{14}|f(E)|','location','best')
xlabel('\fontsize{14}Energy(eV)'); 
ylabel('\fontsize{14}f(E)');
title('\fontsize{14}miniband by one band model');
