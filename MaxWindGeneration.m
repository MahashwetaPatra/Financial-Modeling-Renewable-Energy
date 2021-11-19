%
% NOTE:    Checks for the asset from the metadata file which hits the maximum wind capacity and for that asset calls the 
% function BrierScoreCheck and then for intraday 1,2,3,4 it calculates the four Brier scores.
%
% HIST:  - 13 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
Array = readtable('Scovilleriskpartners/CSV/metaData.xlsx');
column=Array{38:152,8};
[A,I]=sort(column);
file=I(length(I)-1);
FileName=Array{file,2}
BrierScoreCheck(FileName)
toc