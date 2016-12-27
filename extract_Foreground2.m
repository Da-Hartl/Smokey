%helperfunction
function ret = extract_Foreground2(inCsi,initialCalib,timestamps)
global deviation;
global learningrate;

ret=zeros(size(inCsi));
    %basierend auf geschwindigkeit der änderung mean mit lernrate
    %verschieben.....
    magic_constant=0.1;
    for i=2:size(inCsi,2)
        learningratePerTime=learningrate*(timestamps(i)-timestamps(i-1));
        for i2=1:size(inCsi,1)
            val=inCsi(i2,i);
            diff=abs(initialCalib(i2,2)-val);
            if(diff>initialCalib(i2,1)*deviation)
               %ganz klar foreground :-)
               ret(i2,i)=inCsi(i2,i); 
            else
               ret(i2,i)=0;
            end    
            if (diff>initialCalib(i2,1))
               %model anpassen...??? 
               %aber weniger stark je eher wahrscheinlichkeit das es ein
               %foreground ist....
               learningrateCurrent=learningratePerTime/(diff*magic_constant);
               initialCalib(i2,2)=(initialCalib(i2,2)*(1-learningrateCurrent))+(learningrateCurrent*val);
            end   
        end
    end
end
