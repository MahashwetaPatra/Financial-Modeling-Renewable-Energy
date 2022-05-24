%% This function calculates the KS score for solar and wind assets on zonal
%% level and aggregated assets. Run KSScoreVersion1Version2.m file
function KSScoreValues=KSScoreValues(FileDir, assettype, TotalAsset, zones)
IntraDayKS2=zeros(TotalAsset,4);
yaxis=zeros(zones,1);
for Assetnumber=1:TotalAsset %calls all the assets from intraday 1,2,3 & 4
    column=Assetnumber+1;
    Array = readtable(strcat(FileDir,'/Asset/Percentiles_Scoville_',assettype,'.csv'));% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS2(Assetnumber,:)=[h p ksstat cv];    
end

Array = readtable(strcat(FileDir,'/State/Percentiles_Scoville_All.csv'));% calls all the assets from a folder
file=Array{:,2};
%figure();
%histogram(file,30);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
%title(strcat('Intra Day 2, ' ,num2str(ksstat),'Aggregated Asset'))
IntraDayP2=[];

Filename = {'Coast' 'East' 'Far_West' 'North' 'North_Central' 'South' 'South_Central' 'West'};
fig=figure()
for i=1:8
    filepath=strcat(FileDir,'/Zonal/Percentiles_Scoville_',Filename{i},'.csv');% calls all the assets from a folder
    if isfile(filepath)
        Array = readtable(filepath);
        file=Array{:,2};
        subplot(2,8,i)
        histogram(file,20);
        [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
        IntraDayP2=[IntraDayP2;h p ksstat cv];
        title(strcat(assettype,Filename{i}))
    end
end
axes(fig,'visible','off'); 

ZonalKSIntraDay2=IntraDayP2(:,3);
KSScoreValues=ZonalKSIntraDay2;

%%Plot the distribution of KS scores for all assets
figure();
histogram(IntraDayKS2(:,3),30)
hold on;
plot(ZonalKSIntraDay2,yaxis, '.r', 'Markersize',10)
title(strcat('KS score distribution for All ',assettype, ' assets'))
end