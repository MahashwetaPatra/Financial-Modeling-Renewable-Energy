%
% NOTE: This is for calculating teh time series of actual , forcast and mean
%
% HIST:  - 1 Sep, 2021: Created by Patra
%        - 7th Sep, Principal component analysis is done, the coefficient,
%        score, latent, explained are plotted
%=========================================================================
clc;close all; clear all;
T1=1:1:24; %Time steps
size(T1);
Array = readtable('solar3.csv');
a_array=[];b_array=[];
for k=3:1000
    a=[];b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24
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
size(a_array);size(b_array);
am=mean(a_array);bm=mean(b_array);
size(am);
plot(am,bm,'.-r','markersize',20)
hold on;
[coeff,score,latent, tsquared, explained]=pca(b_array);
%[coeff,score,latent]=pca(b_array);%[COEFF, SCORE, LATENT] = pca(X) 
%returns the principal component variances, 
%i.e., the eigenvalues of the covariance matrix of X, in LATENT.
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
%figure(2);
subplot(2,3,2)
%scatter(score(:,1),score(:,2))
numbers=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24];
plot(coeff(:,1),coeff(:,2),'.-k','markersize',12)
% hold on
% for p=8:19
%     plot(coeff(p,1),coeff(p,2),'.-','markersize',20)
%     hold on;
% end
% strValues = strtrim(cellstr(num2str([numbers],'(%d)')));
% text(coeff(:,1),coeff(:,2),strValues,'VerticalAlignment','bottom');
xlabel('Coeff1')
ylabel('Coeff2')

subplot(2,3,3)
plot(T1,latent','.-k','markersize',12)
xlabel('Time')
ylabel('latent')
%figure(5)
subplot(2,3,4)
plot(T1,score,'.k','markersize',12)
xlabel('Time')
ylabel('score')
%figure(6)
subplot(2,3,5)
plot(T1,explained,'.-k','markersize',12)
xlabel('Time')
ylabel('explained')
%figure(7)
subplot(2,3,6)
plot(T1,coeff(:,1),'.-k','markersize',12)
xlabel('Time')
ylabel('coeff')

figure(2);
plot(T1,coeff(:,1),'.-b','markersize',20)
hold on;
plot(T1,coeff(:,2),'.-r','markersize',20)
hold on;
plot(T1,coeff(:,3),'.-g','markersize',20)
hold on;
plot(T1,coeff(:,4),'.-y','markersize',20)
hold on;
plot(T1,coeff(:,5),'.-c','markersize',20)
hold on;
plot(T1,coeff(:,6),'.-k','markersize',20)
xlabel('Time')
ylabel('coeff')
legend on;

figure(3);
numbers=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24];
% for p=8:19
%     plot(coeff(p,1),coeff(p,2),'.-','markersize',20)
%     hold on;
% end
plot(coeff(:,1),coeff(:,2),'.-k','markersize',12)
strValues = strtrim(cellstr(num2str([numbers],'(%d)')));
text(coeff(:,1),coeff(:,2),strValues,'VerticalAlignment','bottom');
xlabel('Coeff1')
ylabel('Coeff2')