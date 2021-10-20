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
T=1:1:24;%Time steps
files = dir('*.csv');% calls all the assets from a folder
hist_values=[];coeff_matrix=[];
map=readtable('solar_meta_new.xlsx');% read the longitude and latitude data for all assets
l=length(files);Longitude=[];Latitude=[];
parfor i=1:length(files)% calling the matlab file latent to do PCA for all assets
    Array = readtable(files(i).name); 
    coefficient=latent(Array);
    coeff_matrix=[coeff_matrix,coefficient(:,1)];  
end
figure(1);
plot(T,coeff_matrix,'.-b','markersize',5)%plotting the coefficient1
[idx, C] = kmeans(coeff_matrix,24,'distance' , 'sqEuclidean', 'Display','final','EmptyAction','drop','MaxIter',10000,'OnlinePhase','off','Options',files,'Replicates',10);
size(idx)
figure(2);
plot(T,coeff_matrix(:,idx))
%  plot(T,coeff_matrix(:,idx==1),'.-r','MarkerSize',12)
%  hold on
%  plot(T,coeff_matrix(:,idx==2),'.-b','MarkerSize',12)
%  hold on
%  plot(T,coeff_matrix(:,idx==3),'.-g','MarkerSize',12)
% hold on
% plot(T,coeff_matrix(:,idx==4),'.-black','MarkerSize',12)


% 
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
title 'Cluster Assignments and Centroids'
hold off
toc