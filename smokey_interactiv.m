warning('off','all');
echo off

function new_csi = read_csi_file (filename,deleteContents)
csi_trace = read_bf_file(filename);

if length(csi_trace)==0
  new_csi=[];
  return
end


if (deleteContents)
  system(strcat('> ',filename));
end

ysize=length(csi_trace{1}.csi)*csi_trace{1}.Nrx;
xsize=length(csi_trace);
csi_final=zeros(ysize,xsize);

for i = 1:length(csi_trace)
  try
    csi_temp=get_scaled_csi(csi_trace{i});
    csi_temp=abs(squeeze(csi_temp)).';
    csi_all_antennas=[csi_temp(:,1);csi_temp(:,2)];
    csi_final(:,i)=csi_all_antennas;
  catch
    new_csi=[];
    return
  end_try_catch
end

new_csi=csi_final;
endfunction


%global buffer
intervallPause=0.1;
diagrammXSize=int16(1000);
diagrammPtr=int16(1);
csi_interactiv_data=zeros(60,diagrammXSize);
xfilled=false;
diagramm= imagesc(csi_interactiv_data,[0,50]);



%do forever
while true
  new_csi=read_csi_file('csi_live.dat',true);
  new_csi_count=int16(size(new_csi)(2));
  fprintf('%i\n',new_csi_count);
  fflush(stdout);

  if (new_csi_count==0)
    pause(intervallPause);
    continue;
  elseif (new_csi_count <= diagrammXSize)
    if (~xfilled)
      if (new_csi_count+diagrammPtr > diagrammXSize)
        xfilled=true;
        csi_interactiv_data=circshift(csi_interactiv_data,[0,-(new_csi_count-(diagrammXSize-diagrammPtr))]);
        csi_interactiv_data(:,diagrammXSize-(new_csi_count-1):diagrammXSize)=new_csi;
        %rotate difference ant then copy      
      else
        %copy stuff into csi_interactiv_data at right position
        csi_interactiv_data(:,diagrammPtr:(diagrammPtr+(new_csi_count-1)))=new_csi;
        diagrammPtr=diagrammPtr+new_csi_count;
      end
    else
      %shift and then copy
      csi_interactiv_data=circshift(csi_interactiv_data,[0,-new_csi_count]);
      csi_interactiv_data(:,diagrammXSize-(new_csi_count-1):diagrammXSize)=new_csi;
    end    
  elseif (new_csi_count > diagrammXSize)
      csi_interactiv_data=new_csi(:,(new_csi_count-diagrammXSize)-1:new_csi_count);
  end
    
  pause(intervallPause);
  set(diagramm,"cdata",csi_interactiv_data);
  drawnow;
end

