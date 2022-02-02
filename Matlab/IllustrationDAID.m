%
% NOTE: Calls an asset for a date and illustrating the DA forecast (green),
% scenario mean+95$\%$ band (black),
% and actual (blue), superimposed with the 6-hour Intraday forecasts (red)
% + scenario means+95$\%$ bands (orange)
%
% HIST:  - 2nd Dec, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all;clear all;
year=20170202;% date for which we want the calculation
T=1:1:24; %Time steps
files = dir(strcat('Scovilleriskpartners/CSV/IntraDay1/SimDat_',num2str(year),'/wind/*.csv'));
filename=files(40).name;%give the column number for the particular asset 

name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',num2str(year),'/wind/',filename);
Array = readtable(name);%getting the DA scenarios
forcast =Array(3,:);actual=Array(2,:);%getting the DA actual and forecast
SizeScenario=size(Array);
b_array=zeros(1003,24);%preallocating for the scenarios.
for k=4:SizeScenario(1)
    b=zeros(24,1);
    col = Array(k,:);
    for i=1:24% put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end
end
bm=mean(b_array);%mean of all scenarios
LowerBound=zeros(24,1);UpperBound=zeros(24,1);%plotting 5-95% band for I_i
for k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(25);
    UpperBound(k)=sizecolumn(975);
end
hold on
x2 = [T, fliplr(T)];
figure(1)
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

fill(x2, [bm, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bm, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);

forcastArray=zeros(24,1);actualArray=zeros(24,1);
for i=1:24% plotting the forecast and actual for DA
    j=i+2;
    forcastArray(i)=forcast{1,j};
    actualArray(i)=actual{1,j};
end
plot(T,forcastArray, '-g','LineWidth',2)%plotting the DA forecast 

%%%%%% plotting I_i forecast, actual and 2.5-97.5% scenarios
for day=1:4
    name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',num2str(year),'/wind/',filename);
    Array = readtable(name);% getting the I_i scenarios
    SizeScenario=size(Array);
    b_array=zeros(1003,6);size(Array);
    IDforcastArray=zeros(6,1);T1=1+6*(day-1);T2=T1+5;
    IDforcast =Array(3,:);T=T1:1:T2;
    for k=3:SizeScenario(1)% getting the scenarios of I_i
        b=zeros(6,1);
        col = Array(k,:);
        for i=1:6% put the asset in a array
            j=i+2;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    hold on;
    bm=mean(b_array); %mean of I_i scenarios
    LowerBound=zeros(6,1);UpperBound=zeros(6,1);% 2.5-97.5% band for 
    for k=1:6
        sizecolumn=sort(b_array(:,k));
        LowerBound(k)=sizecolumn(25);
        UpperBound(k)=sizecolumn(975);
    end 
    x2 = [T, fliplr(T)];
    fill(x2, [bm, fliplr(UpperBound')], 0.6 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
    fill(x2, [bm, fliplr(LowerBound')], 0.6 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);

    for i=1:6% plotting the I_i forecast
        j=i+2;
        IDforcastArray(i)=IDforcast{1,j};
    end
    plot(T,IDforcastArray,'-r','LineWidth',2)
    hold on;  
end
T=1:1:24;% plotting the actual 
plot(T,actualArray, '-b','LineWidth',2)  

toc
