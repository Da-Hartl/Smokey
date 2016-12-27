%helperfunction
function ret = extract_Foreground(inCsi,initialCalib)
    
global deviation;
%global learningrate;
ret=zeros(size(inCsi));
    
    for i=1:size(inCsi,2)
        for i2=1:size(inCsi,1)
            val=inCsi(i2,i);
            diff=abs(initialCalib(i2,2)-val);
            if(diff<initialCalib(i2,1)*deviation)
               ret(i2,i)=0; 
            else
               ret(i2,i)=inCsi(i2,i);
            end        
        end
    end
end
