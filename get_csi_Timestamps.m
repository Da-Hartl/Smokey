%helperfunction
function ret = get_csi_Timestamps(csiTrace)
    traceCount=length(csiTrace);
    csiTimestamps=zeros(1,traceCount);
    for i = 1:traceCount
        csiTimestamps(1,i)=csiTrace{i}.timestamp_low;       
    end

    timestamp1=csiTimestamps(1);
    for i = 1:length(csiTimestamps)
        csiTimestamps(i)=csiTimestamps(i)-timestamp1;
        csiTimestamps(i)=csiTimestamps(i)/1000000;
    end
ret=csiTimestamps;

end
