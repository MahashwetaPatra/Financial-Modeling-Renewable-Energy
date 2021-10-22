%
% NOTE:    Calls all the assets, and for each assets calls the matlab code
%          latent,This is for clustering the cloud form from 1st PCA factor and 2nd PCA factor for all assets, plotting the assets 
%       on the map based on the cluster, and the histogram for highest four coefficient
%
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%         
%=========================================================================
tic
clc;close all; clear all;
T=1:1:24;%Time steps
map=readtable('solar_meta_new.xlsx');% read the longitude and latitude data for all assets
files = dir('*.csv');% calls all the assets from a folder
hist_values=[];coeff_matrix=[];coeff_matrix2=[];
map=readtable('solar_meta_new.xlsx');% read the longitude and latitude data for all assets
l=length(files);Longitude=[];Latitude=[];
parfor i=1:length(files)% calling the matlab file latent to do PCA for all assets
    Array = readtable(files(i).name); 
    coefficient=latent(Array);
    coeff_matrix=[coeff_matrix;coefficient];  
end

figure(1);
subplot(1,2,1)
plot(coeff_matrix(:,1),coeff_matrix(:,2),'.b','markersize',5)%plotting the coefficient1
xlabel('1st PCA factor')
ylabel('2nd PCA factor')
x= [coeff_matrix(:,1), coeff_matrix(:,2)];size(x);
[idx, C] = kmeans(x,4);
idxsize=size(idx)
idx;
subplot(1,2,2)
plot(x(idx==1,1),x(idx==1,2),'r.','MarkerSize',12)
hold on
plot(x(idx==2,1),x(idx==2,2),'b.','MarkerSize',12)
hold on
plot(x(idx==3,1),x(idx==3,2),'g.','MarkerSize',12)
hold on
plot(x(idx==4,1),x(idx==4,2),'y.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'Kx','MarkerSize',15,'LineWidth',3);
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids', 'Location','NW');
title('Cluster Assignments and centroids');
hold off;

for i=1:size(C, 1)
    display(['Centroid ', num2str(i), ': X1 = ', num2str(C(i, 1)), '; X2 = ', num2str(C(i, 2))]);
end
xlabel('1st PCA factor')
ylabel('2nd PCA factor')
title 'Cluster Assignments and centroids '
hold off

LongitudeArray=[];LatitudeArray=[];
for i=1:(l-1)% checking all assets to do the clustering and plotting with different colors
j=i+1;long=map{j,4};lat=map{j,3};
LongitudeArray=[LongitudeArray;long];LatitudeArray=[LatitudeArray;lat];
end
figure(2)
subplot(1,2,1)
plot(LongitudeArray,LatitudeArray,'r.','MarkerSize',12)
x= [LongitudeArray, LatitudeArray];size(x);
[idx, C] = kmeans(x,4);
idxsize=size(idx)
idx;
subplot(1,2,2)
plot(x(idx==1,1),x(idx==1,2),'r.','MarkerSize',12)
hold on
plot(x(idx==2,1),x(idx==2,2),'b.','MarkerSize',12)
hold on
plot(x(idx==3,1),x(idx==3,2),'g.','MarkerSize',12)
hold on
plot(x(idx==4,1),x(idx==4,2),'y.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'Kx','MarkerSize',15,'LineWidth',3);
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Centroids', 'Location','NW');
title('Cluster Assignments and centroids');
hold off;

for i=1:size(C, 1)
    display(['Centroid ', num2str(i), ': X1 = ', num2str(C(i, 1)), '; X2 = ', num2str(C(i, 2))]);
end
xlabel('1st PCA factor')
ylabel('2nd PCA factor')
title 'Cluster Assignments and centroids '
hold off

toc