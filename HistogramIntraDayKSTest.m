%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test and then
%          calculates the Histogram from the KS scores. Does the analysis
%          for both zonal and asset level
%
% HIST:  - 25 Oct, 2021: Created by Patra
%          02 Nov,2021: Added the Kolmogorov-Smirnov Test
%         
%=========================================================================

tic
clc;close all; clear all;
IntraDayKS=zeros(115,4);
for day=1:4
    IntraDayKS=zeros(115,4);
    parfor Assetnumber=1:115 %calls all the assets from intraday 1,2,3 & 4
        column=Assetnumber+1;
        Array = readtable(strcat('Output/Percentiles/IntraDayNew',num2str(day),'/Asset/Percentiles_Scoville_wind.csv'));% calls all the assets from a folder
        file=Array{:,column};
        [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
        IntraDayKS(Assetnumber,:)=[h p ksstat cv];
    end
    figure(4);
    subplot(2,2,day)
    histogram(IntraDayKS(:,3),20)
    title(strcat('Intra Day',num2str(day)))
end

Array = readtable('Output/Percentiles/IntraDayNew1/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 1,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew2/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,2)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 2,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew3/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,3)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 3,' ,num2str(ksstat),'Aggregated Asset'))

Array = readtable('Output/Percentiles/IntraDayNew4/State/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(1);
subplot(2,2,4)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
title(strcat('Intra Day 4,' ,num2str(ksstat),'Aggregated Asset'))

IntraDayP=[]; IntraDayP2=[]; IntraDayP3=[]; IntraDayP4=[];

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,1)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP=[IntraDayP;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,1)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,2)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP=[IntraDayP;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,2)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,3)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP=[IntraDayP;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,3)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,4)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP=[IntraDayP;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,4)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew1/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,5)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP=[IntraDayP;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,5)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
fig=figure(2)
subplot(4,5,6)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('Far West')
figure(3);
subplot(4,5,6)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('Far West')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,7)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,7)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,8)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('North Central')
figure(3);
subplot(4,5,8)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('North Central')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,9)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,9)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew2/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,10)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP2=[IntraDayP2;h p ksstat cv];
title('West')
han=axes(fig,'visible','off'); 
figure(3);
subplot(4,5,10)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('West')


Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,11)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,11)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,12)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,12)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,13)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,13)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,14)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,14)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew3/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,15)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP3=[IntraDayP3;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,15)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('West')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,16)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('FarWest')
figure(3);
subplot(4,5,16)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('FarWest')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,17)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('North')
figure(3);
subplot(4,5,17)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('North')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,18)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('NorthCentral')
figure(3);
subplot(4,5,18)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,19)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('South')
figure(3);
subplot(4,5,19)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('South')

Array = readtable('Output/Percentiles/IntraDayNew4/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2)
subplot(4,5,20)
histogram(file,20);
[h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
IntraDayP4=[IntraDayP4;h p ksstat cv];
title('West')
figure(3);
subplot(4,5,20)
cdfplot(file)
hold on
x_values = linspace(min(file),max(file));
plot(x_values,unifcdf(x_values,0,100),'r-')
legend('Empirical CDF','Uniform CDF','Location','best')
title('West')

ZonalKSIntraDay1=IntraDayP(:,3);
ZonalKSIntraDay2=IntraDayP2(:,3);
ZonalKSIntraDay3=IntraDayP3(:,3);
ZonalKSIntraDay4=IntraDayP4(:,3);
yaxis=[0;0;0;0;0];
figure(4);
subplot(2,2,1)
hold on;
plot(ZonalKSIntraDay1,yaxis,'.','Markersize',15)

subplot(2,2,2)
hold on;
plot(ZonalKSIntraDay2,yaxis,'.','Markersize',15)

subplot(2,2,3)
hold on;
plot(ZonalKSIntraDay3,yaxis,'.','Markersize',15)
 
subplot(2,2,4)
hold on;
plot(ZonalKSIntraDay4,yaxis,'.','Markersize',15)

toc