%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done,
%        -07 Oct, saving data and figure to diferent folder   
%=========================================================================
function CoeffMatrix=PCA_Assets(Array)
SizeScenario=size(Array);
b_array=zeros(1003,24);
for k=3:SizeScenario(1)
    b=zeros(24,1);
    col = Array(k,:);
    for i=1:24% put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end
end
[coeff]=pca(b_array);
CoeffMatrix=[coeff(:,1);coeff(:,2);coeff(:,3);coeff(:,4)];
end
