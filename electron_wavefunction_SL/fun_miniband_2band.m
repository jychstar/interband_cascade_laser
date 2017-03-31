function [miniband_bottom, miniband_top]=fun_miniband_2band(energy, Ec,El,t)
% get miniband by Kronig-Penney model & 2 band model 
% input: energy(eV),Ec(eV),Ev(eV),t(A)
% output: miniband_bottom, miniband_top

global hb P  
                                                                        
ff=zeros(1,length(energy));  % store f function
for ii=1:1:length(energy)
    E=energy(ii); 
%     k=sqrt((E-Ec).*(E-El))/hb/P;  % /cm,
%     beta=hb*P*k./(E-El);
%     M=eye(2);
%     for jj=1:1:length(t)-1;
%         M=fun_matrix_next(beta(jj),beta(jj+1),k(jj+1),t(jj+1))*M;
%     end
%     M=fun_matrix_next(beta(end),beta(1),k(1),t(1))*M; % last layer   
    M=fun_miniband_matrix_2band(E,Ec,El,t);
    ff(ii)=0.5*trace(M);   % 0.5*( t11+t22)     
end  

minibandArea=zeros(1,length(energy)); % store miniband area info, defaul=0 is forbiddend area.
ii=0;jj=0;
for m=2:1:length(energy)-1
    %
    if abs(ff(m))<=1,minibandArea(m)=1;  % allowed energy
    else minibandArea(m)=0;             % forbidden energy
    end
    % 
    if    (abs(ff(m))>=1 && abs(ff(m+1))<=1),ii=ii+1;miniband_bottom(ii)=energy(m+1); % store the energy at miniband edge
    elseif(abs(ff(m))<=1 && abs(ff(m+1))>=1),jj=jj+1;miniband_top(jj)=energy(m);    % store the energy at miniband edge
    end
end

% abandom unmatched miniband
if (ii==0) disp(' no miniband_bottom');miniband_bottom=[]; plot(energy,abs(ff),'linewidth',2); return
elseif (jj==0) disp(' no miniband_top');miniband_top=[]; plot(energy,abs(ff),'linewidth',2);  return
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
xlabel('\fontsize{14}Energy (eV)'); 
ylabel('\fontsize{14}f(E)');
title('\fontsize{14}miniband by two band model');