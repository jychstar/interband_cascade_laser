function [output]=fun_miniband_profile(depth, band,miniband_bottom,miniband_top)
% show miniband in band profile
% input= QW_number,Ec,Ev,thick,miniband_bottom,miniband_top
% output=[depth',band',miniband'];

miniband_number=length(miniband_top); % number of minibands
totNum=length(depth);

figure
plot(depth,band, 'linewidth',2); hold on

xdata=zeros(4,miniband_number);
ydata=zeros(4,miniband_number);
zdata=ones(4,miniband_number);

for i=1:1:miniband_number
    xdata(1:1:2,i)=depth(1);
    xdata(3:1:4,i)=depth(end);
    ydata(1:3:4,i)=miniband_bottom(i);
    ydata(2:1:3,i)=miniband_top(i);
end

patch(xdata,ydata,zdata,'r')
legend('\fontsize{14}CB','\fontsize{14}VB','\fontsize{14}miniband',0);
xlabel('\fontsize{14}Distance(angstrom)'); 
ylabel('\fontsize{14}Energy(eV)');
%title('\fontsize{12}Conduction miniband in SL of InAs(33.5A)-GaSb(21.9A)-InSb(3.6A)');

%% output
miniband=ones(miniband_number*2,totNum);
for i=1:1:miniband_number
    miniband(i*2-1,:)=miniband_bottom(i);
    miniband(i*2,:)=miniband_top(i);
end
output=[depth',band',miniband'];
