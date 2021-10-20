tic
clc;close all;clear all;
prompt = 'What is the date? ';
year = input(prompt,'s')
prompt = 'What is asset type? ';
assettype = input(prompt,'s')
prompt = 'What is the Asset name, give with the csv extension, for example Adamstown_Solar.csv? ';
filename = input(prompt, 's')
%file=strcat('Dropbox/HighLevel-Data/SimDat_',year,'/',assettype,'/',filename);
file=strcat('ORFEUS/SimDat_',year,'/',assettype,'/',filename);
Array=readtable(file);
numExtremeScen=10;
PCA_ExtremeScenario=PCA_ExtremeScenario(year, assettype, filename,Array,numExtremeScen);
toc