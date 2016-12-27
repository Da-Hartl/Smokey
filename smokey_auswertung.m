warning('off','all')

datafile='Messdaten_Smokey/csi3x3_2min.dat';
doShortenData=1;
shortenData=6;
useSpatialPaths=[1 1];

global deviation;
deviation=3;
global learningrate
learningrate=0.2;    



csiTrace = read_bf_file(datafile);
csiTrace=csiTrace(6:length(csiTrace)); %erste Messwerte haben falsche Zeitstempel

csiValues=get_csi_Values(csiTrace);
csiTimestamps=get_csi_Timestamps(csiTrace);
traceCount=size(csiValues,2);

if doShortenData
    csiValues=filter_Array(csiValues,shortenData);
    csiTimestamps=filter_Array(csiTimestamps,shortenData);
    traceCount=size(csiValues,2);
end


csiValues=csiValues((useSpatialPaths(1)-1)*30+1:useSpatialPaths(2)*30,:);
display_csi(csiValues,csiTimestamps);

calibData=csiValues(:,200:300);
calibration=get_Mean_and_Std(calibData);
csiForeground=extract_Foreground(csiValues,calibration);
csiForeground2=extract_Foreground2(csiValues,calibration,csiTimestamps);
display_csi(csiForeground,csiTimestamps);
display_csi(csiForeground2,csiTimestamps);

return;
%Methode filter_small_Events ist noch leer
csiFiltered=filter_small_Events(csiForeground,csiTimestamps);
display_csi(csiFiltered,csiTimestamps);

%Methode filter_single_Motion ist noch leer
csiFiltered2=filter_single_Motion(csiFiltered,csiTimestamps);
cisplay_csi(csiFiltered2,csiTimestamps);

%ToDo: Periodizitäts-Analyse.......








