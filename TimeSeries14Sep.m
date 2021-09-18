%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done, the coefficient,
%        score, latent, explained are plotted
%=========================================================================
tic
clc;close all; clear all;
T1=1:1:24; %Time steps
size(T1);
Array = readtable('Dropbox/HighLevel-Data/SimDat_20181126/solar/solar3.csv');% read a single asset
a_array=[];b_array=[];
for k=3:1000
    a=[];b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24% put the asset in a array
        j=i+2;
        a=[a;T1(i)];
        b=[b;col{1,j}];
    end
    figure(1)
    subplot(2,3,1)
    plot(a,b,'Color', [0.7 0.7 0.7],'markersize',5)
    hold on;
    for i=1:24
        a_array(k,i)=a(i);
        b_array(k,i)=b(i);
    end
end
size(a_array);size(b_array);%final array of scenarios and time
am=mean(a_array);bm=mean(b_array);% calculating the mean of all the scenarios
size(am);
plot(am,bm,'.-r','markersize',20)
hold on;
[coeff,score,latent, tsquared, explained]=pca(b_array);
coeff(:,1);
cumsum(explained);
explained(1)+explained(2)+explained(3)
col1 = Array(1,:); %Data of the Actuals
col2 = Array(2,:); % Data of the Forecase
a=[];b=[];
for i=1:24
    j=i+2;
    a=[a;T1(i)];
    b=[b;col1{1,j}];
end
plot(a,b,'.-b','markersize',20)
hold on;
a=[];b=[];
for i=1:24
    j=i+2;
    a=[a;T1(i)];
    b=[b;col2{1,j}];
end
plot(a,b,'.-g','markersize',20)
hold off;

subplot(2,3,2)
numbers=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24];
plot(coeff(:,1),coeff(:,2),'.-k','markersize',12)
xlabel('Coeff1')
ylabel('Coeff2')

subplot(2,3,3)
plot(T1,latent','.-k','markersize',12)
xlabel('Time')
ylabel('latent')

subplot(2,3,4)
plot(T1,score,'.k','markersize',12)
xlabel('Time')
ylabel('score')

subplot(2,3,5)
plot(T1,explained,'.-k','markersize',12)
xlabel('Time')
ylabel('explained')

subplot(2,3,6)
plot(T1,coeff(:,1),'.-k','markersize',12)
xlabel('Time')
ylabel('coeff')

figure(2);
plot(T1,coeff(:,1),'.-b','markersize',20)
hold on;
plot(T1,coeff(:,2),'.-r','markersize',20)
plot(T1,coeff(:,3),'.-g','markersize',20)
plot(T1,coeff(:,4),'.-y','markersize',20)
plot(T1,coeff(:,5),'.-c','markersize',20)
plot(T1,coeff(:,6),'.-k','markersize',20)
xlabel('Time')
ylabel('coeff')

figure(3);
numbers=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24];
plot(coeff(:,1),coeff(:,2),'.-k','markersize',12)
strValues = strtrim(cellstr(num2str([numbers],'(%d)')));
text(coeff(:,1),coeff(:,2),strValues,'VerticalAlignment','bottom');
xlabel('Coeff1')
ylabel('Coeff2')
toc