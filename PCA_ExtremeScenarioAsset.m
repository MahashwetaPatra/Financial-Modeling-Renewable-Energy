tic
clc;close all;clear all;
prompt = 'What is the date, for example 20170310? ';
year = input(prompt,'s');
prompt = 'What is asset type, for example solar or wind? ';
assettype = input(prompt,'s');
prompt = 'What is the Asset name, give with the csv extension, for example Adamstown_Solar.csv or Aguayo_Wind.csv? ';
filename = input(prompt, 's');
file=strcat('ORFEUS/SimDat_',year,'/',assettype,'/',filename);
Array=readtable(file);
PCA_ExtremeScenario=PCA_ExtremeScenario(Array);
PCA_ExtremeScenario4=PCA_ExtremeScenario4(Array);
toc