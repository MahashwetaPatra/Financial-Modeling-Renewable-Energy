%
% NOTE: Calls all asset for a date and illustrating the DA forecast (green),
% scenario mean+95$\%$ band (black),
% and mean (red), 
% HIST:  - 28th Dec, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all;
files = dir('Scovilleriskpartners/LiveSimulation/SimRequest_Mahashweta20180604_20211228_154113/wind/*.csv');
s=length(files);
assetall=zeros(1002,24,s);
parfor asset=1:s
    files = dir('Scovilleriskpartners/LiveSimulation/SimRequest_Mahashweta20180604_20211228_154113/wind/*.csv');
    filename=files(asset).name;%give the column number for the particular asset 
    name=strcat('Scovilleriskpartners/LiveSimulation/SimRequest_Mahashweta20180604_20211228_154113/wind/',filename);
    Array = readtable(name);%getting the DA scenarios
    for k=1:1002
        b=zeros(24,1);
        col = Array(k,:);
        for i=1:24% put the asset in a array
            j=i+2;
            b(i,1)=col{1,j};
            assetall(k,i,asset)=b(i,1);
        end  
    end
end
sum=zeros(1002,24);% initialize the sum of all assets
parfor i=1:s %summing over all assets
    sum=sum+assetall(:,:,i);
end
Array=sum;
Time=1:1:24; %Time steps
forcastArray =Array(1,:);%actualArray=Array(2,:);
b_array=Array(2:1002,:);
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
parfor k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(25);
    UpperBound(k)=sizecolumn(975);
end
figure(1);
%subplot(1,5,5)
hold on;
x2 = [Time, fliplr(Time)];
bmean=mean(b_array);
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
fill(x2, [bmean, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bmean, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
hold on;
%plot(Time,Array(3:1002,:),'Color', [0.7 0.7 0.7],'markersize',5)
hold on;
plot(Time,Array(2,:), '-green','LineWidth',1)
plot(Time,bmean, '-red','LineWidth',1) 

hours=12;
figure(2)%%plots the histogram at some hour
subplot(1,5,5)
histogram(Array(3:1002,hours),10)
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

mean(Array(3:1002,hours))
toc
