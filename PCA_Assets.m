%
% NOTE: This function is for doing the PCA analysis
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done,
%        -07 Oct, saving PCA factors, variance explained and figure showing the PCA factor to folder   
%=========================================================================
function explained_series=PCA_Assets(assettype,year,filename,Array);
%Array = readtable('Adamstown_Solar.csv');% read a single asset
T1=1:1:24; %Time steps
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
size(b_array);%final array of scenarios and time
[coeff,score,latent, tsquared, explained]=pca(b_array);
explained_series=[explained(1);explained(2);explained(3);explained(4)];
%[coeff]=pca(b_array);
coeff(:,1);
%filename='Adamstown_Solar.csv';
[pathstr,name,ext] = fileparts(filename);
for i=1:4
    if assettype==1
        Fn=strcat('ORFEUS/SimDat_',num2str(year),'/solar/Coefficients/',name,'20170101coefficient',num2str(i),ext);
    elseif assettype==2
        Fn=strcat('ORFEUS/SimDat_',num2str(year),'/wind/Coefficients/',name,'20170101coefficient',num2str(i),ext);
    elseif assettype==3
        Fn=strcat('ORFEUS/SimDat_',num2str(year),'/load/Coefficients/',name,'20170101coefficient',num2str(i),ext);
    end
    
    if i==1
        fid = fopen(Fn,'wt');
        fprintf(fid,'%d\n',coeff(:,i));
        fclose(fid);
    elseif i==2
        fid = fopen(Fn,'wt');
        fprintf(fid,'%d\n',coeff(:,i));
        fclose(fid);
    elseif i==3
        fid = fopen(Fn,'wt');
        fprintf(fid,'%d\n',coeff(:,i));
        fclose(fid);
    elseif i==4
        fid = fopen(Fn,'wt');
        fprintf(fid,'%d\n',coeff(:,i));
        fclose(fid);
    end
end
if assettype==1
    Fn1=strcat('ORFEUS/SimDat_',num2str(year),'/solar/Coefficients/',name,'explained_series20170101',ext);
elseif assettype==2
    Fn1=strcat('ORFEUS/SimDat_',num2str(year),'/wind/Coefficients/',name,'explained_series20170101',ext);
elseif assettype==3
    Fn1=strcat('ORFEUS/SimDat_',num2str(year),'/load/Coefficients/',name,'explained_series20170101',ext);
end
fid = fopen(Fn1,'wt');
fprintf(fid,'%d\n',explained_series);
fclose(fid);
if assettype==1
    Fig=strcat('ORFEUS/SimDat_',num2str(year),'/solar/Coefficients/',name,'coefficient20170101.png');
elseif assettype==2
    Fig=strcat('ORFEUS/SimDat_',num2str(year),'/wind/Coefficients/',name,'coefficient20170101.png');
elseif assettype==3
    Fig=strcat('ORFEUS/SimDat_',num2str(year),'/load/Coefficients/',name,'coefficient20170101.png');
end
Title=strcat(name,'coefficient',num2str(year));

plot(T1,coeff(:,1),'.-b','markersize',20)
ylim([-0.1 0.65])
xlabel('Time')
ylabel('coeff1')
title(Title)
saveas(gcf,Fig)
end
