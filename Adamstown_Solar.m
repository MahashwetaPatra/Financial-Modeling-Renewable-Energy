%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done, the coefficient,
%        score, latent, explained are plotted
%        -17th Sep, calls the assets from the different folder 
%=========================================================================
T1=1:1:24; %Time steps
Array = readtable('Adamstown_Solar.csv');% read a single asset
a_array=[];b_array=[];
for k=3:1000
    a=[];b=[];
    col = Array(k,:);
    for i=1:24% put the asset in a array
        j=i+2;
        a=[a;T1(i)];
        b=[b;col{1,j}];
    end
    for i=1:24
        a_array(k,i)=a(i);
        b_array(k,i)=b(i);
    end
end
size(a_array);size(b_array);%final array of scenarios and time
[coeff,score,latent, tsquared, explained]=pca(b_array);
explained_series=[explained(1);explained(2);explained(3);explained(4)];
%[coeff]=pca(b_array);
coeff(:,1);

fid = fopen('explained_series.txt','w');
fprintf(fid,'%d\n',explained_series);
fclose(fid);

for i=1:6
    if i==1
        fid = fopen('coefficient1.txt','wt');
    elseif i==2
        fid = fopen('coefficient2.txt','wt');
    elseif i==3
        fid = fopen('coefficient3.txt','wt');
    elseif i==4
        fid = fopen('coefficient4.txt','wt');
    elseif i==5
        fid = fopen('coefficient5.txt','wt');
    elseif i==6
        fid = fopen('coefficient6.txt','wt');
    end
      
fprintf(fid,'%d\n',coeff(:,i));
fclose(fid);
end

plot(T1,coeff(:,1),'.-b','markersize',20)
ylim([-0.1 0.6])
xlabel('Time')
ylabel('coeff1')
title('Adamstown Solar 2017/01/01')
saveas(gcf,'AdamstownSolar20170101.png')