%helperfunction
function ret = get_Mean_and_Std(inCsi)
    std1=std(inCsi,0,2);
    mean1=mean(inCsi,2);
    var=std1.^2;
    ret=[std1 mean1 var];
end
