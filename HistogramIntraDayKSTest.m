%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and then
%          calculates the Histogram from the KS scores.
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the Kolmogorov-Smirnov Test
%         
%=========================================================================

tic
clc;close all; clear all;
IntraDayKS=[]; IntraDayKS2=[];IntraDayKS3=[]; IntraDayKS4=[];

for Assetnumber=1:115 %calls all the assets from intraday 1,2,3 & 4
    column=Assetnumber+1;
    Array = readtable('Output/Percentiles/IntraDayNew1/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS=[IntraDayKS;ksstat cv];
    
    Array = readtable('Output/Percentiles/IntraDayNew2/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS2=[IntraDayKS2;ksstat cv];

    Array = readtable('Output/Percentiles/IntraDayNew3/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS3=[IntraDayKS3;ksstat cv];

    Array = readtable('Output/Percentiles/IntraDayNew4/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS4=[IntraDayKS4;ksstat cv];

end

Array = readtable('Output/Percentiles/IntraDayNew1/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,1)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 1,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew2/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,2)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 2,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew3/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,3)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 3,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew4/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,4)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 4,' ,num2str(ksstat),'Aggregated Asset'))

IntraDayP=[]; IntraDayP2=[]; IntraDayP3=[]; IntraDayP4=[];

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,1)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,2)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,2)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,3)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,3)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,4)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,4)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,5)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,5)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2)
subplot(4,5,6)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')
figure(3);
subplot(4,5,6)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('Far West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,7)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,7)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,8)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North Central')
figure(3);
subplot(4,5,8)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North Central')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,9)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,9)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,10)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('West')
han=axes(fig,'visible','off'); 
figure(3);
subplot(4,5,10)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')


Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,11)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,11)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,12)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,12)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,13)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,13)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,14)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,14)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,15)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,15)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')


Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,16)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,16)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,17)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,17)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,18)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,18)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,19)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,19)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,20)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,20)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')

%han.YLabel.Visible='on';
%ylabel(han,'Intra Day 2 & Intra Day 1');

ZonalKSIntraDay1=IntraDayP(:,3)
ZonalKSIntraDay2=IntraDayP2(:,3)
ZonalKSIntraDay3=IntraDayP3(:,3)
ZonalKSIntraDay4=IntraDayP4(:,3)

figure(4);
subplot(2,2,1)
histogram(IntraDayKS(:,1),10)
title('Intra Day 1, Histogram of kS scores')
subplot(2,2,2)
histogram(IntraDayKS2(:,1),10)
title('Intra Day 2, Histogram of kS scores')
subplot(2,2,3)
histogram(IntraDayKS3(:,1),10)
title('Intra Day 3, Histogram of kS scores')
subplot(2,2,4)
histogram(IntraDayKS4(:,1),10)
title('Intra Day 4, Histogram of kS scores')
toc