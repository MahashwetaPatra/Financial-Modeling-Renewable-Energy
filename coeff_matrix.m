%
% NOTE:    Calls all the assets, and for each assets calls the matlab code
%          latent,This is for clustering the coefficient 1 for all assets, plotting the assets 
%       on the map based on the cluster, and the histogram for highest four coefficient
%
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%         
%=========================================================================
function coeff_matrix
T=1:1:24;%Time steps
files = dir('*.csv');% calls all the assets from a folder
coeff_matrix=[];
for i=1:length(files)% calling the matlab file latent to do PCA for all assets
    Array = readtable(files(i).name); 
    coeff=coefficient1(Array);
    size(coeff(:,1));
    coeff_matrix=[coeff_matrix,coeff(:,1)];  
end
plot(T,coeff_matrix,'.-b','markersize',5)%plotting the coefficient1
title('2018/07/22')
saveas(gcf,'coeff0722.png')
end
