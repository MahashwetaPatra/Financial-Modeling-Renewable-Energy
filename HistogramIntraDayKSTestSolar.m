%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and then
%          calculates the Histogram from the KS scores. Analyze for both
%          zonal and asset level for solar data
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the Kolmogorov-Smirnov Test
%         
%=========================================================================
tic
clc;close all; clear all;
IntraDayKS=zeros(115,4);
for day=2:3
    IntraDayKS=zeros(115,4);
    parfor Assetnumber=1:36 %calls all the assets from intraday 1,2,3 & 4
        column=Assetnumber+1;
        Array = readtable(strcat('Output/Percentiles/IntraDayNew',num2str(day),'Solar/Asset/Percentiles_Scoville_solar.csv'));% calls all the assets from a folder
        file=Array{:,column};
        [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
        IntraDayKS(Assetnumber,:)=[h p ksstat cv];
    end
    figure(4);
    subplot(1,2,day-1)
    histogram(IntraDayKS(:,3),20)
    title(strcat('Intra Day',num2str(day)))
end

Array = readtable('Output/Percentiles/IntraDayNew2Solar/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(1,2,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 2, ' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew3Solar/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(1,2,2)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 3, ' ,num2str(ksstat),'Aggregated Asset'))

IntraDayP=[]; IntraDayP2=[]; IntraDayP3=[]; IntraDayP4=[];

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_Coast.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2)
subplot(2,7,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Coast')
figure(3);
subplot(2,7,1)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('Coast')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2)
subplot(2,7,2)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')
figure(3);
subplot(2,7,2)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('Far West')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,3)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North')
figure(3);
subplot(2,7,3)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,4)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North Central')
figure(3);
subplot(2,7,4)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('North Central')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,5)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')
figure(3);
subplot(2,7,5)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_South_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,6)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South Central')
figure(3);
subplot(2,7,6)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('South Central')

Array = readtable('Output/Percentiles/IntraDayNew2Solar/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,7)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('West')
han=axes(fig,'visible','off'); 
figure(3);
subplot(2,7,7)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('West')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_Coast.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2)
subplot(2,7,8)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('Coast')
figure(3);
subplot(2,7,8)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('Coast')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,9)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('FarWest')
figure(3);
subplot(2,7,9)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,10)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('North')
figure(3);
subplot(2,7,10)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,11)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(2,7,11)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,12)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('South')
figure(3);
subplot(2,7,12)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_South_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,13)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('South Central')
figure(3);
subplot(2,7,13)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('South Central')

Array = readtable('Output/Percentiles/IntraDayNew3Solar/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(2,7,14)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('West')
figure(3);
subplot(2,7,14)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
%legend('Empirical CDF','Uniform CDF','Location','best')
title('West')

ZonalKSIntraDay2=IntraDayP2(:,3)
ZonalKSIntraDay3=IntraDayP3(:,3)
yaxis=[0;0;0;0;0;0;0];

figure(4);
subplot(1,2,1)
hold on;
plot(ZonalKSIntraDay2,yaxis,'.','Markersize',15)

subplot(1,2,2)
hold on;
plot(ZonalKSIntraDay3,yaxis,'.','Markersize',15)

toc