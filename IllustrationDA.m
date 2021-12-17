%
% NOTE: Calls all asset for a date and illustrating the DA forecast (green),
% scenario mean+95$\%$ band (black),
% and actual (blue), 
% HIST:  - 2nd Dec, 2021: Created by Patra
%         
%=========================================================================

tic
%clc;close all;
%function IllustrationDA=IllustrationDA(year, assettype, filename,s);;
year=20171212;
files = dir('Scovilleriskpartners/CSV/IntraDay1/SimDat_20170101/wind/*.csv');
s=length(files);
assetall=zeros(1003,24,s);
parfor asset=1:s
    files = dir(strcat('Scovilleriskpartners/CSV/IntraDay1/SimDat_',num2str(year),'/wind/*.csv'));
    filename=files(asset).name;%give the column number for the particular asset 
    name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',num2str(year),'/wind/',filename);
    Array = readtable(name);%getting the DA scenarios
    for k=2:1003
        b=zeros(24,1);
        col = Array(k,:);
        for i=1:24% put the asset in a array
            j=i+2;
            b(i,1)=col{1,j};
            assetall(k,i,asset)=b(i,1);
        end
        
    end

end
all=[];sum2=assetall(:,:,1);
parfor i=2:s
    all=assetall(:,:,i);
    size(all);
    sum2=sum2+all;
end
Array=sum2;
a=[];b=[];%actualArray=[];forcastArray=[];
T=1:1:24; %Time steps
forcastArray =Array(3,:);actualArray=Array(2,:);
SizeScenario=size(Array);
b_array=Array(4:1003,:);
bm=mean(b_array);
[c_array,I]=sort(b_array,'ascend');
size_c_array=size(c_array);
index=[];lowerB=[];
bm=mean(b_array);% calculating the mean of all the scenarios
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
parfor k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(25);
    UpperBound(k)=sizecolumn(975);
end
%IllustrationDA=
figure(1);
%plot(T,LowerBound,'-black','LineWidth',1);
%hold on;
%plot(T,UpperBound,'-black','LineWidth',1);  
plot(T,forcastArray, '-g','LineWidth',1) 
hold on;
plot(T,actualArray, '-b','LineWidth',1) 
hold on;
x2 = [T, fliplr(T)];
figure(1)
xlabel('Time (hours)'); 
     ylabel('Energy (MW)'); 
     set(gca, 'GridLineStyle', ':') %dotted grid lines
     set(gca,'FontSize',18,'LineWidth',1.5)

fill(x2, [bm, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bm, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
%end
toc