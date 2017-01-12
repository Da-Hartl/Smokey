%helperfunction
function ret = display_csi(inCsi,inTimestamps,titlee)
format long;
    lim=[5 20];
    figure;
    y=1:size(inCsi,1);
   % diagramm= imagesc(inTimestamps,y,inCsi,lim);
    diagramm= imagesc(inTimestamps,y,inCsi);
    title(titlee);
   
   colormap jet;
    colorbar;
    ret=diagramm;   
end
