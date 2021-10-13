%
% NOTE:    Calls all the assets for a date, and for each assets calls the
%          matlab function PCA_Assets.m, This is for doing the PCA for the asset and 
%          save the first four PCA factors and first four explained series in csv format 
%          save the 1st PCA factor plotted in png format in folder
%          Coefficient
%
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%          07 Oct, saving data to folder, renamed the file
%=========================================================================
tic
clc;close all; clear all;
%year=20170101;
for year=20170101:20170131
for assettype=1:1
    if assettype==1
        files = dir(strcat('ORFEUS/SimDat_',num2str(year),'/solar/*.csv'));% calls all the assets from a folder
    elseif assettype==2
        files = dir(strcat('ORFEUS/SimDat_',num2str(year),'/wind/*.csv'));% calls all the assets from a folder
    elseif assettype==3
        files = dir(strcat('ORFEUS/SimDat_',num2str(year),'/load/*.csv'));% calls all the assets from a folder
    end
    for i=1:length(files)
        if assettype==1
            filename=strcat('ORFEUS/SimDat_',num2str(year),'/solar/',files(i).name);
        elseif assettype==2
            filename=strcat('ORFEUS/SimDat_',num2str(year),'/wind/',files(i).name);
        elseif assettype==3
            filename=strcat('ORFEUS/SimDat_',num2str(year),'/load/',files(i).name);
        end
        Array = readtable(filename);
        filenameN=files(i).name;
        PCA_Assets(assettype,year,filenameN,Array);      
    end
end
end
toc