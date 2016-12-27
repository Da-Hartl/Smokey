%helperfunction
function ret = filter_Array(inArray,eachNr)

    newLen=round(size(inArray,2)/eachNr)-1;
    ret=zeros(size(inArray,1),newLen);

    for i=1:newLen
        ret(:,i)=inArray(:,i*6);
    end
    

end
