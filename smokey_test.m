%warning('off','all')

datafile='Messdaten_Smokey/csi3x3_2min.dat';

csi_trace = read_bf_file(datafile);
complLength=length(csi_trace);
csi_final=zeros(270,complLength);
csi_timestamps=zeros(1,complLength);
for i = 1:complLength
    csi1=abs(get_scaled_csi(csi_trace{i}));
    csi_timestamps(1:i)=csi_trace{i}.timestamp_low;
    tempLen=numel(csi1);
    csi_temp=reshape(shiftdim(csi1,2),[tempLen,1]);
    csi_final(1:tempLen,i)=csi_temp;
    
    
end

start=1;
ende=500;
lim=[0 70];
%data_part=csi_final(:,start:ende);

lessDenseLength=round(complLength/6)-1;
csiLessDense=zeros(270,lessDenseLength);

for i=1:lessDenseLength
    csiLessDense(:,i)=csi_final(:,i*6);
end

csiSubcFilter=csiLessDense(1:30,:);

data_part=csiSubcFilter;
%data_part=csiSubcFilter(:,1000:1500);
%diagramm= imagesc(data_part,lim);
%colormap jet;
%colorbar;


%Festlegung: es werden die ersten 5 "Spatial Paths" genutzt
calib1=csiSubcFilter(:,500:700);
calib2=csiSubcFilter(:,1000:1100);

copy=csiSubcFilter;

std1=std(calib1,0,2);
mean1=mean(calib1,2);
std2=std(calib2,0,2);
mean2=mean(calib2,2);

stdmean1=[std1 mean1];
stdmean2=[std2 mean2];

thestdmean=stdmean1;
sortedstdmean=sortrows(thestdmean);
deviation=2.5;

%for i=1:lessDenseLength
%    for i2=1:size(copy,1)
%        val=copy(i2,i);
%        diff=abs(thestdmean(i2,2)-val);
%        if(diff<thestdmean(i2,1)*deviation)
%           copy(i2,i)=0; 
%        end    
    
%    end
%end

for i=1:lessDenseLength
    for i2=1:size(copy,1)
        val=copy(i2,i);
        diff=abs(thestdmean(i2,2)-val);
        if(diff<thestdmean(i2,1)*deviation)
           copy(i2,i)=0; 
        end        
    end
end


diagramm= imagesc(copy,lim);
colormap jet;
colorbar;
