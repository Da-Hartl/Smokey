%helperfunction
function ret = filter_Foreground(inCsi,timestamps, precision)
    
%global learningrate;
ret=zeros(size(inCsi));
keep_value_front=0;
keep_value_back=0;
    for i=1:size(inCsi,2)
        for i2=1:size(inCsi,1)
            if(i>precision)
                    keep_value_front=keep_value_front+inCsi(i2,i-1);
                    for j=1:precision
                        keep_value_front=keep_value_front*inCsi(i2,i-j);
                    end                    
            else
                keep_value_front=precision;
            end
            if(i<size(inCsi,1)-precision)
                keep_value_back=keep_value_back+inCsi(i2,i+1);
                for j=1:precision
                        keep_value_back=keep_value_back*inCsi(i2,i+j);
                end
            else
                keep_value_back=precision;
            end
            if((keep_value_front~=0)&&(keep_value_back~=0))
               ret(i2,i)=inCsi(i2,i);
            else
               ret(i2,i)=0;
            end
            keep_value_front=0;
            keep_value_back=0;
        end
    end
end