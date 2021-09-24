%
% NOTE:    Calls all the assets, and for each assets calls the matlab code
%          latent,This is for clustering the coefficient 1 for all assets, plotting the assets 
%       on the map based on the cluster, and the histogram for highest four coefficient
%
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%         
%=========================================================================
tic
clc;close all; clear all;
run('SimDat_20180613/solar/coeff_matrix.m'); 

run('SimDat_20180722/solar/coeff_matrix.m');

run('SimDat_20180911/solar/coeff_matrix.m'); 

run('SimDat_20181126/solar/coeff_matrix.m'); 

toc
