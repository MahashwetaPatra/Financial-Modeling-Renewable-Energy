tic
clc;close all;clear all;
prompt = 'What is the date, for example 20170310? ';
year = input(prompt,'s');
prompt = 'What is asset type, for example solar or wind? ';
assettype = input(prompt,'s');
prompt = 'What is the Asset name, give with the csv extension, for example Adamstown_Solar.csv or Aguayo_Wind.csv? ';
filename = input(prompt, 's');
prompt = 'Number of extreme scenarios we want to consider? give a number like 20 ';
numExtremeScen= input(prompt);
prompt = 'Number of cluster we want to make? give a number like 40 ';
clusternumber= input(prompt);

%file=strcat('Dropbox/HighLevel-Data/SimDat_',year,'/',assettype,'/',filename);
file=strcat('ORFEUS/SimDat_',year,'/',assettype,'/',filename);
Array=readtable(file);
%numExtremeScen=10;
PCA_ExtremeScenario=PCA_ExtremeScenario(Array);
%PCA_ExtremeScenario2=PCA_ExtremeScenario2(year, assettype, filename,Array,numExtremeScen);
%PCA_ExtremeScenario3=PCA_ExtremeScenario3(year, assettype, filename,Array,numExtremeScen,clusternumber);
PCA_ExtremeScenario4=PCA_ExtremeScenario4(Array,numExtremeScen);
toc