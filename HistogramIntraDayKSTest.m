%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and then
%          calculates the Histogram from the KS scores.
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the KS Test
%         
%=========================================================================

tic
clc;close all; clear all;
IntraDayKS=[]; IntraDayKS2=[];

for Assetnumber=1:115
    column=Assetnumber+1;
    Array = readtable('Output/Percentiles/IntraDayNew1/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS=[IntraDayKS;ksstat];
end

for Assetnumber=1:115
    column=Assetnumber+1;
    Array = readtable('Output/Percentiles/IntraDayNew2/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file);
    IntraDayKS2=[IntraDayKS2;ksstat];
end

Array = readtable('Output/Percentiles/IntraDayNew1/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2);
subplot(1,2,1)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 1,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew2/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2);
subplot(1,2,2)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
title(strcat('Intra Day 2,' ,num2str(ksstat),'Aggregated Asset'))

IntraDayP=[]; IntraDayP2=[];

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('FarWest')
figure(4);
subplot(2,5,1)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,2)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('North')
figure(4);
subplot(2,5,2)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,3)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('NorthCentral')
figure(4);
subplot(2,5,3)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,4)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('South')
figure(4);
subplot(2,5,4)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,5)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP=[IntraDayP;h p ksstat cv];
title('West')
figure(4);
subplot(2,5,5)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(3)
subplot(2,5,6)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')
figure(4);
subplot(2,5,6)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('Far West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,7)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North')
figure(4);
subplot(2,5,7)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,8)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North Central')
figure(4);
subplot(2,5,8)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('North Central')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,9)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')
figure(4);
subplot(2,5,9)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(3)
subplot(2,5,10)
histogram(file,20);
[h,p,ksstat,cv]  = kstest(file);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('West')
han=axes(fig,'visible','off'); 
figure(4);
subplot(2,5,10)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
title('West')
han.YLabel.Visible='on';
ylabel(han,'Intra Day 2 & Intra Day 1');

IntraDay1KSValues=IntraDayP(:,3)
IntraDay2KSValues=IntraDayP2(:,3)
figure(5);
subplot(1,2,1)
histogram(IntraDayKS,10)
subplot(1,2,2)
histogram(IntraDayKS2,10)

IntraDay1KSValues=IntraDayP(:,4)
IntraDay2KSValues=IntraDayP2(:,4)
figure(6);
subplot(1,2,1)
histogram(IntraDayKS,10)
subplot(1,2,2)
histogram(IntraDayKS2,10)
toc