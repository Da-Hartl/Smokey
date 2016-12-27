%helperfunction
function ret = display_csi(inCsi,inTimestamps)
format long;
    lim=[0 70];
    figure;
    y=1:size(inCsi,1);
    diagramm= imagesc(inTimestamps,y,inCsi,lim);
    colormap jet;
    colorbar;
    ret=diagramm;   
end
