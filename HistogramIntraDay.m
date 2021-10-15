tic
clc;close all; clear all;
Array = readtable("Output/Percentiles/Percentiles_Scoville_wind.xlsx");
%files = readtable('Output/Percentiles/Percentiles_Scoville_wind.xlsx');% calls all the assets from a folder
%Array=files(:,2)
toc