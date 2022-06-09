%
% NOTE: Calls all asset for a date and illustrating the DA forecast (green),
% scenario mean+95$\%$ band (black),
% and mean (red), 
% HIST:  - 28th Dec, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all;clear all;
for assettype=1:2
%files = dir('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation/SimRequest_Mahashweta20180604_20211228_154113/wind/*.csv');
if assettype==1
    files = dir('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/solar/*.csv');
elseif assettype==2
  files = dir('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/wind/*.csv');
end
s=length(files);
assetall=zeros(1002,24,s);
parfor asset=1:s
    if assettype==1
        files = dir('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/solar/*.csv');
        filename=files(asset).name;%give the column number for the particular asset 
        name=strcat('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/solar/',filename);
        Array = readtable(name);%getting the DA scenarios
    elseif assettype==2
        files = dir('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/wind/*.csv');
        filename=files(asset).name;%give the column number for the particular asset 
        name=strcat('C:/Users/Mahashweta Patra/Dropbox/MikeLudkovski/Scovilleriskpartners/LiveSimulation0412/SimRequest_Mahashweta20180413_20220606_214230/wind/',filename);
        Array = readtable(name);%getting the DA scenarios
    end
    for k=1:1002
        b=zeros(24,1);
        col = Array(k,:);
        for i=1:24% put the asset in a array
            j=i+2;
            assetall(k,i,asset)=col{1,j};
        end  
    end
end
sumAsset=zeros(1002,24);% initialize the sum of all assets
parfor i=1:s %summing over all assets
    sumAsset=sumAsset+assetall(:,:,i);
end
Time=1:1:24; %Time steps
forcastArray =sumAsset(2,:);%actualArray=Array(2,:);
scenario=sumAsset(3:1002,:);
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
parfor k=1:24
    sizecolumn=sort(scenario(:,k));
    LowerBound(k)=sizecolumn(25);
    UpperBound(k)=sizecolumn(975);
end
figure(1);
subplot(1,2,assettype)
x2 = [Time, fliplr(Time)];
bmean=mean(scenario);
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
hold on;
fill(x2, [bmean, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bmean, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
hold on;
%plot(Time,scenario,'Color', [0.7 0.7 0.7],'markersize',5)
plot(Time,forcastArray, '-green','LineWidth',1)
plot(Time,bmean, '-red','LineWidth',1) 

hours=12;
figure(2)%%plots the histogram at some hour
subplot(1,2,assettype)
histogram(sumAsset(3:1002,hours),10)
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
end
toc