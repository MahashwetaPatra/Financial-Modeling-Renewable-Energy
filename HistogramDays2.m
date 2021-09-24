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
 files = dir;% calls all the assets from a folder
 allNames = files(8).name 
%a=allNames(12)
% for i=3:368% calling the matlab file latent to do PCA for all assets
   % Array = readtable(files(8).name); 
   run('SimDat_20170201/solar/Adamstown_Solar.m'); 
     
   run('SimDat_20170301/solar/Adamstown_Solar.m'); 
 
   run('SimDat_20170401/solar/Adamstown_Solar.m'); 
   
   run('SimDat_20170501/solar/Adamstown_Solar.m'); 
 
  run('SimDat_20170601/solar/Adamstown_Solar.m'); 
 
 run('SimDat_20170701/solar/Adamstown_Solar.m'); 

 run('SimDat_20170801/solar/Adamstown_Solar.m'); 
 
   run('SimDat_20170901/solar/Adamstown_Solar.m'); 
   
   run('SimDat_20171001/solar/Adamstown_Solar.m'); 
 
  run('SimDat_20171101/solar/Adamstown_Solar.m'); 
  
  run('SimDat_20171201/solar/Adamstown_Solar.m'); 

   run('SimDat_20170101/solar/Adamstown_Solar.m'); 



% run('SimDat_20170102/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170103/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170104/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170105/solar/Adamstown_Solar.m'); 

% run('SimDat_20170106/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170107/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170108/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170109/solar/Adamstown_Solar.m'); 
% run('SimDat_20170110/solar/Adamstown_Solar.m');


% run('SimDat_20170111/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170112/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170113/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170114/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170115/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170116/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170117/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170118/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170119/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170120/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170121/solar/Adamstown_Solar.m');

%run('SimDat_20170122/solar/Adamstown_Solar.m'); 

%run('SimDat_20170123/solar/Adamstown_Solar.m');

% run('SimDat_20170124/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170125/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170126/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170127/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170128/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170129/solar/Adamstown_Solar.m');
% 
% run('SimDat_20170130/solar/Adamstown_Solar.m'); 
% 
% run('SimDat_20170131/solar/Adamstown_Solar.m');

toc
