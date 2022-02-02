clc;close all;clear all;
prompt = 'What is the year range for the animation?for example 2017 ';
year_range = input(prompt,'s');
prompt = 'What is the start date, for example 1? ';
startdate = input(prompt);
prompt = 'What is the end date, for example 31? ';
enddate = input(prompt);
prompt = 'What is asset type, for example load, solar, wind? ';
assettype = input(prompt,'s');
prompt = 'What is the Asset number in the meda data file, for example 4? ';
Assetnumber = input(prompt);
prompt = 'What PCA factor we want the Animation with, for example coefficient1? ';
PCAfactor = input(prompt, 's');
prompt = 'What is the framerate, for example 2? ';
framerate = input(prompt);
prompt = 'Do you want to save the code?, say yes or no ';
saveornot = input(prompt,"s");

PCA_Animation=PCA_Animation(year_range, startdate, enddate, assettype, Assetnumber,PCAfactor, framerate,saveornot);
