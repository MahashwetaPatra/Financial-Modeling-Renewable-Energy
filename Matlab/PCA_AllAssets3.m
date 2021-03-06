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
assettype=2;datafile=[];
datetime.setDefaultFormats('defaultdate','yyyyMMdd')
t = datetime(2017,1,1:365);
date=t';
time=char(date(1));
parfor k=1:365
    year=char(date(k));
    files = dir(strcat('ORFEUS/SimDat_',year,'/wind/*.csv'));% calls all the assets from a folder
    l=length(files)
    CoeffMatrixNew=zeros(96,l);
    for i=1:l
        filename=strcat('ORFEUS/SimDat_',year,'/wind/',files(i).name);
        Array = readtable(filename);
        %filenameN=files(i).name;
        CoeffMatrix=PCA_Assets(Array);  
        CoeffMatrixNew(:,i)=CoeffMatrix; 
    end
    size(CoeffMatrixNew);
    datafile=[datafile;{CoeffMatrixNew}];
    %csvwrite('Coefficients/solar_coefficient.csv',datafile,1,1);
end
csvwrite('Coefficients/wind_coefficientNew.csv',datafile,1,1);
toc
