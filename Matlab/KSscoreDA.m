%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and then
%          calculates the Histogram from the KS scores.
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the Kolmogorov-Smirnov Test
%         
%=========================================================================
tic
clc;close all;
IntraDayKS2=zeros(36,4);

for Assetnumber=1:36 %calls all the assets from intraday 1,2,3 & 4
    column=Assetnumber+1;
    Array = readtable('Output/Percentiles/DASolar/Asset/Percentiles_Scoville_solar.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS2(Assetnumber,:)=[h p ksstat cv];    
end

Array = readtable('Output/Percentiles/DASolar/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
histogram(file,30);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 2, ' ,num2str(ksstat),'Aggregated Asset'))

IntraDayP2=[];
Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_Coast.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2);
subplot(2,7,2)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,3)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,4)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North Central')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,5)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_South_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,6)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')

Array = readtable('Output/Percentiles/DASolar/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,7)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('West')
han=axes(fig,'visible','off'); 

ZonalKSIntraDay2=IntraDayP2(:,3);
yaxis=zeros(7,1);
figure(4);
histogram(IntraDayKS2(:,3),30)
hold on;
plot(ZonalKSIntraDay2,yaxis, '.r', 'Markersize',10)
xlim([0,0.15])
ylim([0,12])
title('All assets')
toc
