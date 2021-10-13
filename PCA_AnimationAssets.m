clc;close all;clear all;
prompt = 'What is the year range for the animation?for example 2017 ';
year_range = input(prompt,'s')
prompt = 'What is asset type, for example load, solar, wind? ';
assettype = input(prompt,'s')
prompt = 'What is the Asset number in the meda data file, for example 4? ';
Assetnumber = input(prompt)
prompt = 'What PCA factor we want the Animation with, for example coefficient1? ';
PCAfactor = input(prompt, 's')

PCA_Animation=PCA_Animation(year_range, assettype, Assetnumber,PCAfactor);
