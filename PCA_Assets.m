%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done,
%        -07 Oct, saving data and figure to diferent folder   
%=========================================================================
function CoeffMatrix=PCA_Assets(assettype,year,filename,Array);
% T1=1:1:24; %Time steps
SizeScenario=size(Array);
b_array=[];
for k=3:SizeScenario(1)
    b=[];
    col = Array(k,:);
    for i=1:24% put the asset in a array
        j=i+2;
        b=[b;col{1,j}];
    end
    for i=1:24
        b_array(k,i)=b(i);
    end
end
%[coeff,score,latent, tsquared, explained]=pca(b_array);
[coeff]=pca(b_array);
CoeffMatrix=[coeff(:,1);coeff(:,2);coeff(:,3);coeff(:,4)];
if assettype==1
    Fn=strcat('Coefficients/solar_coefficient',num2str(year),'.csv');
    fid = fopen(Fn,'a+');
    fprintf(fid,'%d\n',CoeffMatrix);
    fclose(fid);   
elseif assettype==2
    Fn=strcat('Coefficients/wind_coefficient',num2str(year),'.csv');
    fid = fopen(Fn,'a+');
    fprintf(fid,'%d\n',CoeffMatrix);
    fclose(fid);  
elseif assettype==3
    Fn=strcat('Coefficients/load_coefficient',num2str(year),'.csv');
    fid = fopen(Fn,'a+');
    fprintf(fid,'%d\n',CoeffMatrix);
    fclose(fid); 
end
end