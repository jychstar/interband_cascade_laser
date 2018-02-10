function [] = fun_index_overview(ref, thick,lambda)
% plot index plot to have a quick check

layernum=length(thick); %number of layers
ref_real=real(ref);% real part of each layer;
ref_imag=imag(ref);% imaginary part of each layer;
medium_lambda=lambda/3.5; % estimated wavelength in material in microns
lad=0;
layerdepth=zeros(1,layernum);
textdepth=zeros(1,layernum);
for k=1:layernum;
    layerdepth(k)=(lad+thick(k)); % accumlated depth of each layer
    textdepth(k)=lad+0.5*thick(k);% reserved for text display
    lad=layerdepth(k);
end;

figure
plot([0, medium_lambda],[0,0]);
hold on;
ylabel('\fontsize{14}Depth from Top,\mum');
for k=1:layernum;
    plot([0, medium_lambda],[-layerdepth(k),-layerdepth(k)]);
    text(0.3*medium_lambda,-textdepth(k),num2str(ref_real(k)));
    text(0.6*medium_lambda,-textdepth(k),num2str(ref_imag(k),5));
end;
text(.05,.2,'Slab Layers - Real Ref. Index - Imaginary Ref Index');