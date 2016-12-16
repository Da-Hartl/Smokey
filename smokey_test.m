csi_trace = read_bf_file('Messdaten_Smokey/longer_csi.dat');
csi1=get_scaled_csi(csi_trace{1});
csi1=abs(squeeze(csi1)).';
csi_final=[csi1(:,1);csi1(:,2)];
for i = 2:length(csi_trace)
csi1=get_scaled_csi(csi_trace{i});
csi1=abs(squeeze(csi1)).';
csi_temp=[csi1(:,1);csi1(:,2)];
csi_final=[csi_final,csi_temp];
end
csi_final