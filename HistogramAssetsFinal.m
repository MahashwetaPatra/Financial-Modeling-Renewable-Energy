%
% NOTE:    Calls all the assets, and for each assets calls the matlab code
%          latent,This is for clustering the coefficient 1 for all assets, plotting the assets 
%       on the map based on the cluster, and the histogram for highest four coefficient
%
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%         
%=========================================================================

clc;close all; clear all;
T=1:1:24;%Time steps
files = dir('*.csv');% calls all the assets from a folder
hist_values=[];coeff_matrix=[];
map=readtable('solar_meta_new.xlsx');% read the longitude and latitude data for all assets
l=length(files);
for i=1:length(files)% calling the matlab file latent to do PCA for all assets
    Array = readtable(files(i).name); 
    [coeff,sum_explained]=latent(Array);
    hist_values=[hist_values;sum_explained];
    size(coeff(:,1));
    coeff_matrix=[coeff_matrix,coeff(:,1)];  
end
cluster_count=0;
for i=1:(l-1)% checking all assets to do the clustering and plotting with different colors
check1= coeff_matrix(1,i);check5= coeff_matrix(5,i);
check10=coeff_matrix(10,i);check15=coeff_matrix(15,i);
j=i+1;long=map{j,4};lat=map{j,3};
    if (check1<0.1)&& (check5<0.1)&& (check10<0.1)&& (check15<0.1)
        figure(1)
        plot(T,coeff_matrix(:,i),'.-b','markersize',5)%plotting the coefficient1
        hold on;
        figure(2)
        plot(long,lat, '.','markersize',20) %plotting the assets on the Texas map
        hold on;
        cluster_count=cluster_count+1;
    else
        figure(1)
        plot(T,coeff_matrix(:,i),'.-b','markersize',5)
        hold on;
        figure(2)
        plot(long,lat, '.','markersize',20) 
        hold on;
    end
end
%size(coeff_matrix);
%X=coeff_matrix;
% opts = statset('Display','final');
% [cidx, ctrs] = kmeans(X, 2);
% figure(2);
% plot(X(cidx==1,1),X(cidx==1,2),'r.','markersize',20)
% plot(X(cidx==2,1),X(cidx==2,2),'b.','markersize',20);
 
%size(hist_values);
figure(3);
histogram(hist_values)% plotting the Histogram plot for first 4 coefficient