%helperfunction
function ret = get_csi_Values(csiTrace)
    traceCount=length(csiTrace);
    csiValues=zeros(270,traceCount);
    for i = 1:traceCount
        csiTemp=abs(get_scaled_csi(csiTrace{i}));
        tempLen=numel(csiTemp);
        csiColumn=reshape(shiftdim(csiTemp,2),[tempLen,1]);
        csiValues(1:tempLen,i)=csiColumn;
    end
    ret=csiValues;

end
