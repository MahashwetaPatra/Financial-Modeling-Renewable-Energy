tic
clc;close all; clear all;
prompt = 'What is the Asset number in the meda data file, for example 4? ';
Assetnumber = input(prompt)
column=Assetnumber+1;
Array = readtable('Output/Percentiles/IntraDay1/State/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
file=Array{:,column};
figure(1)
subplot(1,2,1)
histogram(file,20);
title(strcat('Intra Day1, AssetNumber',num2str(Assetnumber)))

Array = readtable('Output/Percentiles/IntraDay2/State/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
file=Array{:,column};
figure(1)
subplot(1,2,2)
histogram(file,20);
title(strcat('Intra Day2, AssetNumber',num2str(Assetnumber)))

Array = readtable('Output/Percentiles/IntraDay1/Asset/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2);
subplot(1,2,1)
histogram(file,20);
title('Intra Day1, Aggregated Asset')

Array = readtable('Output/Percentiles/IntraDay2/Asset/Percentiles_Scoville_All.csv');% calls all the assets from a folder
file=Array{:,2};
figure(2);
subplot(1,2,2)
histogram(file,20);
title('Intra Day2, Aggregated Asset')

fig=figure(3);
Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_Coast.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,1)
histogram(file,20);
title('Coast')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_East.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,2)
histogram(file,20);
title('East')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,3)
histogram(file,20);
title('FarWest')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,4)
histogram(file,20);
title('North')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,5)
histogram(file,20);
title('NorthCentral')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,6)
histogram(file,20);
title('South')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_South_Central.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,7)
histogram(file,20);
title('South Central')

Array = readtable('Output/Percentiles/IntraDay1/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,8)
histogram(file,20);
title('West')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_Coast.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,9)
histogram(file,20);
title('Coast')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_East.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,10)
histogram(file,20);
title('East')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_Far_West.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,11)
histogram(file,20);
title('Far West')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_North.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,12)
histogram(file,20);
title('North')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_North_Central.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,13)
histogram(file,20);
title('North Central')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_South.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,14)
histogram(file,20);
title('South')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_South_Central.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,15)
histogram(file,20);
title('South Central')

Array = readtable('Output/Percentiles/IntraDay2/Zonal/Percentiles_Scoville_West.csv');% calls all the assets from a folder
file=Array{:,2};
subplot(4,4,16)
histogram(file,20);
title('West')
han=axes(fig,'visible','off'); 

han.YLabel.Visible='on';
ylabel(han,'Intra Day 2 & Intra Day 1');
toc