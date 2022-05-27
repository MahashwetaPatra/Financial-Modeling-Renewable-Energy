%% This function calculates the KS score for solar and wind assets on zonal
%% level and aggregated assets. Run KSScoreVersion1Version2.m file
function [KSScoreValues,ZonalDistribution]=KSScoreValues(FileDir, assettype, TotalAsset, zones, ZoneName)
ZoneName = {'Coast' 'East' 'Far_West' 'North' 'North_Central' 'South' 'South_Central' 'West'};
KSScoreAllAsset=zeros(TotalAsset,4);
yaxis=zeros(8,1);
parfor Assetnumber=1:TotalAsset %calls all the assets from intraday 1,2,3 & 4
    column=Assetnumber+1;
    Array = readtable(strcat(FileDir,'/Asset/Percentiles_Scoville_',assettype,'.csv'));% calls all the assets from a folder
    Percentile=Array{:,column};
    [h,p,ksstat,cv] = kstest(Percentile,[Percentile unifcdf(Percentile,0,100)]);
    KSScoreAllAsset(Assetnumber,:)=ksstat;    
end

Array = readtable(strcat(FileDir,'/State/Percentiles_Scoville_All.csv'));% calls all the assets from a folder
Percentile=Array{:,2};
[h,p,ksstat,cv] = kstest(Percentile,[Percentile unifcdf(Percentile,0,100)]);
%figure();
%histogram(file,30);
%title(strcat('Intra Day 2, ' ,num2str(ksstat),'Aggregated Asset'))

KSScoreValues=[];

ZonalDistribution=figure()
for i=1:8
    filepath=strcat(FileDir,'/Zonal/Percentiles_Scoville_',ZoneName{i},'.csv');% calls all the assets from a folder
    if isfile(filepath)
        Array = readtable(filepath);
        Percentile=Array{:,2};
        subplot(1,8,i)
        histogram(Percentile,20);
        [h,p,ksstat,cv] = kstest(Percentile,[Percentile unifcdf(Percentile,0,100)]);
        KSScoreValues=[KSScoreValues; ksstat];
        title(strcat(assettype,ZoneName{i}))
    else
        KSScoreValues=[KSScoreValues; 0.0];
    end

end
axes(ZonalDistribution,'visible','off'); 

%%Plot the distribution of KS scores for all assets
figure();
histogram(KSScoreAllAsset,30)
hold on;
plot(KSScoreValues,yaxis, '.r', 'Markersize',10)
title(strcat('KS score distribution for All ',assettype, ' assets'))
end