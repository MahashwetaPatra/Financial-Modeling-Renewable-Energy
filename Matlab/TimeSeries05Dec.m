%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done, the coefficient,
%        score, latent, explained are plotted
%        -17th Sep, calls the assets from the different folder 
%        -22nd Sep, shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%        -5-95% band is shown in grey shade
%        -Added more text and it now works in less time   
%=========================================================================
tic
clc;close all; clear all;
Time=1:1:24; %Time steps
%Array = readtable('Dropbox/HighLevel-Data/SimDat_20181126/solar/solar3.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170617/solar/Hopkins.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170122/solar/Lumina.csv');% read a single asset
Array = readtable('ORFEUS/SimDat_20171202/wind/Baffin.csv');% read a single asset
%Array = readtable('ORFEUS/SimDat_20170101/load/Coast.csv');% read a single asset
SizeScenario=size(Array);
forcast =Array(3,:);actual=Array(2,:);
b_array=zeros(1003,24);
for k=3:SizeScenario(1)
    b=zeros(24,1);
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end % end for
end % end for, putting all scenarios in a matrix
size(b_array); %final array of scenarios and time
bmean=mean(b_array);% calculating the mean of all the scenarios
[c_array,I]=sort(b_array,'ascend');
size_c_array=size(c_array);
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
for k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(25);
    UpperBound(k)=sizecolumn(975);
end
hold on
x2 = [Time, fliplr(Time)];
figure(1)
subplot(2,3,1)%plot all the scenario
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
fill(x2, [bmean, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
hold on;
fill(x2, [bmean, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
hold on;
%plot(T1,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
hold on;
plot(Time,bmean,'.-r','markersize',20) %plot the mean of all scenarios
hold on;
forcastArray=zeros(24,1);actualArray=zeros(24,1);
for i=1:24% put the asset in a array
    j=i+2;
    forcastArray(i)=forcast{1,j};
    actualArray(i)=actual{1,j};
end
plot(Time,forcastArray, '-g','LineWidth',2)            
plot(Time,actualArray, '-b','LineWidth',2)  

[coeff,score,latent, tsquared, explained]=pca(b_array);
coeff(:,1);
cumsum(explained);
explained(1)+explained(2)+explained(3)+explained(4);
hold off;
subplot(2,3,2)
scatter(score(:,1),score(:,2))
xlabel('Score1')
ylabel('Score2')

subplot(2,3,3)
plot(Time,latent','.-k','markersize',12)
xlabel('Time')
ylabel('latent')

subplot(2,3,4)
plot(Time,score,'.k','markersize',12)
xlabel('Time')
ylabel('score')

subplot(2,3,5)
plot(Time,explained,'.-k','markersize',12)
xlabel('Time')
ylabel('explained')

subplot(2,3,6)
plot(Time,coeff(:,1),'.-k','markersize',12)
xlabel('Time')
ylabel('coeff')

figure(2);
plot(Time,coeff(:,1),'.-b','markersize',20)
hold on;
plot(Time,coeff(:,2),'.-r','markersize',20)
plot(Time,coeff(:,3),'.-g','markersize',20)
plot(Time,coeff(:,4),'.-y','markersize',20)
plot(Time,coeff(:,5),'.-c','markersize',20)
plot(Time,coeff(:,6),'.-k','markersize',20)
xlabel('Time')
ylabel('PCs')

figure(3);
numbers=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24];
plot(coeff(:,1),coeff(:,2),'.-k','markersize',12)
strValues = strtrim(cellstr(num2str((numbers),'(%d)')));
text(coeff(:,1),coeff(:,2),strValues,'VerticalAlignment','bottom');
xlabel('Coeff1')
ylabel('Coeff2')

A=[score(:,1),score(:,2)];
B=sort(A,1);
figure(4);
plot(score(:,1),score(:,2), '.blue', 'markersize', 10)
hold on;

eps=0.000001;
score_boundary=[];
for i=990:1:1000
    idx = find(abs(score(:,1 )-B(i,1))<eps);
    plot(score(idx,1),score(idx,2), '.black', 'markersize', 20)
    strValues = strtrim(cellstr(num2str((idx),'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom'); 
    score_boundary=[score_boundary;idx];
     
    idx = find(abs(score(:,2 )-B(i,2))<eps);
    plot(score(idx,1),score(idx,2), '.black', 'markersize', 20)
    strValues = strtrim(cellstr(num2str((idx),'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
end

for i=1:1:10
    idx = find(abs(score(:,1 )-B(i,1))<eps);
    plot(score(idx,1),score(idx,2), '.black', 'markersize', 20)
    strValues = strtrim(cellstr(num2str((idx),'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
 
    idx = find(abs(score(:,2 )-B(i,2))<eps);
    plot(score(idx,1),score(idx,2), '.black', 'markersize', 20)
    strValues = strtrim(cellstr(num2str((idx),'(%d)')));
    text(score(idx,1),score(idx,2),strValues,'VerticalAlignment','bottom');
    score_boundary=[score_boundary;idx];
end
toc
