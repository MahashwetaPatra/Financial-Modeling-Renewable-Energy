tic
clc;close all;clear all;
prompt = 'What is asset type, for example solar or wind? ';
assettype = input(prompt,'s');
year=20180303;
files = dir(strcat('ORFEUS/SimDat_20180101/',assettype,'/*.csv'));% calls all the assets from a folder
l=length(files);numberset=zeros(l,1);
for i=1:l
    filename=strcat('ORFEUS/SimDat_',num2str(year),'/',assettype,'/',files(i).name);
    Array = readtable(filename);
    if contains(assettype, 'solar')
        number=PCA_ExtremeScenarioSolar(Array);
        numberset(i)=number;
    elseif contains(assettype, 'wind')
        number=PCA_ExtremeScenarioWind(Array);
        numberset(i)=number;
    end
end
histogram(numberset,15)
toc