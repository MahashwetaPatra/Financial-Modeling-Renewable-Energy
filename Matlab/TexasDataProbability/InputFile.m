tic
clc;close all;
%% Run this file to get the K-S score values for all dates for all three algorithms
%% shows box plot using probability to get high generation cost and load shedding
%% Provide with the Input
%FileDir="C:\\Users\\MahashwetaPatra\\Downloads\\ProcessedDataRTS\\"; % processed data location for RTS data 
FileDir="C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedDataTexas\\"; % % processed data location for Texas data

RepScenario = input('Number of representative scenarios, e.g 100: ');
PF=input('Number of PCA factors to be considered, e.g 3: ');
%hours = input('At what hour we want to check the histogram nature? for example 10?: ');
P=[];K=[];Pcomb=[];
% RTS days names
%M=["Jan","Feb","Mar","Apr","June","Aug","Sep","Oct","Nov","Dec"];

% Texas days name
M=["Jan20","Feb16", "May27","Jun04","Jul09","Sep04","Nov20", "Dec19"];

for i=1:length(M) % Month names are Jan, Feb, Mar, Apr, June, Aug, Sep, Oct, Nov, Dec
    Month=M{i};
    [KS, ProbNew]=RTSRepresentativeScenNetLoad(FileDir, RepScenario, PF, hours, Month);
    Probability=RTSPCANetLoad(FileDir, RepScenario, Month);
    K=[K;KS];
    P=[P;Probability];
    Pcomb=[Pcomb;ProbNew];
end
k1=K(:,1); k2=K(:,2); k3=K(:,3);
figure();
[mean(k1) mean(k2) mean(k3)];
boxplot([k1,k2,k3],{strcat('mean(k1)=',num2str(mean(k1))) strcat('mean(k2)=',num2str(mean(k2))) strcat('mean(k3)=',num2str(mean(k3)))},'Colors','b')
%legend('Subsampling','K-means','PCA+K-means','Location','NorthEastOutside')
title('k1: Subsampling, k2: Kmeans, k3: PCA+Kmeans')
PGen=P(:,1);
PCurt=P(:,2);PLoad=P(:,3);PAmount=P(:,4);
figure();
PGenNetLoad = table2array(readtable(strcat(FileDir,"ProbabilityNetLoad.csv"), 'VariableNamingRule','preserve')); 
%PGenNetLoad=[46; 60; 58;52;46;46;50; 40]; % Texas case
subplot(1,2,1) % Net load and PCA1 is combined and is predicting high generation cost with higher probability
%boxplot((PGen*100),{'PGen'},'Colors','b') % 100 is multiplied to get in percentage value
boxplot((Pcomb*100),{'P(Net load+PCA1)'},'Colors','b') % 100 is multiplied to get in percentage value
ylim([0 100])
subplot(1,2,2)
boxplot(PGenNetLoad,{'PGenNetLoad'},'Colors','b')
ylim([0 100])

%figure();
%boxplot((PCurt),{'PCurt'},'Colors','b')
%figure();
%boxplot((PLoad),{'PLoad'},'Colors','b')
%figure();
%boxplot((PAmount),{'PAmount'},'Colors','b')
toc