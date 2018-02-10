function [confine,depth,field,index]=fun_opticalField(lambda,ref,thick,Neff,Loss,TE,which_is_active,layer_grid)
% unit of size is um
% plot optical field

%% 1st step,get the amplitudes at the left of every interface
k0=2*pi/lambda;
totNum=sum(thick/layer_grid);  % total plot points
subNum=thick/layer_grid;   %number of points in each layer
lastNum=subNum(end);   % nunmber of points in the last layer

% evalue Ec_div, El_div, depth
depth=(1:1:totNum)*layer_grid;
ref_div=zeros(1,totNum);
last=0;
for j=1:1:length(thick)
    first=last+1;
    last=first+subNum(j)-1;   % get column numbers for write
    ref_div(first:1:last)=ref(j);
end
epsilon_div=ref_div.^2;%1xN
gamma_div=k0*sqrt(Neff^2-epsilon_div);%1xN

amplitude=zeros(2,totNum);
%% 2nd step, get amplitudes for each grid
% set amplitude for first layers
    amplitude(:,1)=[0;1];
% from second layer to second last layer
for ii=2:1:totNum-lastNum+1
     amplitude(:,ii)=fun_matrix_next_wg(gamma_div(ii-1),epsilon_div(ii-1),gamma_div(ii),epsilon_div(ii),layer_grid,TE)*amplitude(:,ii-1);
end

% % growing fields may dominate with small errors in M(1 1) unless artificially eliminated.
for ii=totNum-lastNum+2:1:totNum
    amplitude(1,ii)=amplitude(1,ii-1)*exp(-gamma_div(ii)*layer_grid);
end
if TE
    add=sum(amplitude);
else
    add=sum(amplitude)./ ref_div; % convert H to E
end

index=real(ref_div);
field=abs(add).^2;

tot=trapz(depth,field);
field=field/tot;  % normalization

% Give active layer logic value.
activeRegion=zeros(1,totNum);
Active_Begin=sum(subNum(1:which_is_active-1))+1; % location of first active region point
Active_End=sum(subNum(1:which_is_active));      % location of last active region point
activeRegion(Active_Begin:Active_End)=1; % Location of Active region
field_active=activeRegion.*field;
confine=trapz(depth,field_active)  % confinement factor

%%
figure;

fill(depth, field_active,'c');hold on

% y2=index;
%[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');
y2=[index;real(Neff)*ones(1,length(index))];  % add effective index to check fake solution
[AX,H1,H2] = plotyy(depth,field,depth,y2,'plot');

set(get(AX(1),'Ylabel'),'String','\fontsize{14}Modal Intensity (Normalized)')
set(get(AX(2),'Ylabel'),'String','\fontsize{14}Refractive Index')
%set(AX(1),'YTick',[0:0.1:max(y1)-0.01,fix(max(y1)*100)/100])
set(AX(2),'YTick',[0:0.5:max(index)-0.01,fix(max(index)*100)/100])   % 0.5 per tick, and max value round to 2 digits
set(AX(1),'YLim',[0,max(field)*2])
set(AX(2),'YLim',[0,max(index)*1.05])
set(AX(1),'XLim',[min(depth),max(depth)])
set(AX(2),'XLim',[min(depth),max(depth)])
set(H1,'LineStyle','-.','linewidth',2)
set(H2,'LineStyle','-','linewidth',2)
set(H1,'color','b','linewidth',2)
set(H2,'color','r','linewidth',2)

legend(['\fontsize{14}\Gamma_{core}=',num2str(confine,3)],'location','best');
xlabel('\fontsize{14}Vertical Distance from Top(\mum)');
if TE
    title(['\fontsize{14}TE, \lambda=',num2str(lambda),'\mum, \alpha_w_g=',num2str(Loss),' cm^-^1, n_e_f_f=',num2str(real(Neff))]);
else
    title(['\fontsize{14}TM, \lambda=',num2str(lambda),'\mum, \alpha_w_g=',num2str(Loss),'  cm^-^1, n_e_f_f=',num2str(real(Neff))]);
end
