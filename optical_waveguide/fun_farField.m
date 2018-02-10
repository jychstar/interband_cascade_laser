function [FWHM,theta,Efar]=fun_farField(lambda,depth,field,Neff,TE)
% calculate far-field from a known nearField 

theta=-80:0.1:80; % in degree, far-field range
sintheta=sin(pi*theta/180);
costheta=cos(pi*theta/180);
Efar=zeros(1,length(theta));
k0=2*pi/lambda;
for k=1:1:length(theta)
    fun=field.*exp(-1i*k0*depth*sintheta(k));
    Efar(k)=trapz(depth,fun);
end
Efar=abs(Efar).^2; % modulus value

if TE
    aa=1+sqrt(Neff^2-sintheta.^2);   % numerator
    bb=costheta+sqrt(Neff^2-sintheta.^2); % denominator    
else
    aa=Neff^2+sqrt(Neff^2-sintheta.^2);
    bb=Neff^2*costheta+sqrt(Neff^2-sintheta.^2);
end
factor=costheta.^2.*abs(aa./bb).^2;
Efar=Efar.*factor;
Efar=Efar/max(Efar);  % normalize by setting maximum=1

% determine full width at half maximum

half=max(Efar)/2;
M=abs(Efar-half);
 
iii=1;
if 1
    for ii=2:length(M)-1
        if M(ii)<M(ii-1)&M(ii)<M(ii+1)& M(ii)<0.1
            F(iii)=theta(ii);iii=iii+1;
        end
    end    
    FWHM=abs(F(1)-F(2))    
end

figure 
plot(theta,Efar,'k','linewidth',2);hold on
plot(theta,half,'b','linewidth',2)
xlabel('\fontsize{14}\theta \circ')
ylabel('\fontsize{14}Intensity')

if TE
    title(['\fontsize{14}TE Far Field Pattern, \lambda=',num2str(lambda,2),'\mum, FWHM=',num2str(FWHM),' \circ'])
else
    title(['\fontsize{14}TM Far Field Pattern, \lambda=',num2str(lambda,2),'\mum, FWHM=',num2str(FWHM),' \circ'])
end

% if length(F)==4; title(['\fontsize{14}TE Far Field Pattern, \lambda=',num2str(lambda,2),'\mum, FWHM=',num2str(FWHM),' \circ for each lobe'])
% else title(['\fontsize{14}TE Far Field Pattern, \lambda=',num2str(lambda,2),'\mum, FWHM=',num2str(FWHM),' \circ'])
% end
grid on


