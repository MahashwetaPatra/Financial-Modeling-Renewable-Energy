tic
clc;close all;
%% Run this file to get the K-S score values for all dates for all three algorithms
%% Provide with the Input
FileDir="C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData";
RepScenario = input('Number of representative scenarios, e.g 100: ');
PF=input('Number of PCA factors to be considered, e.g 3: ');
%hours = input('At what hour we want to check the histogram nature? for example 10?: ');
P=[];K=[];
M=["Jan","Feb","Mar","Apr","June","Aug","Sep","Oct","Nov","Dec"];

for i=1:length(M) % Month names are Jan, Feb, Mar, Apr, June, Aug, Sep, Oct, Nov, Dec
    Month=M{i};
    KS=RTSRepresentativeScenNetLoad(FileDir, RepScenario, PF, hours, Month);
    Probability=RTSPCANetLoad(FileDir, RepScenario, Month);
    K=[K;KS];
    P=[P;Probability];
end
%k1=K(:,1); k2=K(:,2); k3=K(:,3);
%figure();
%[mean(k1) mean(k2) mean(k3)];
%boxplot([k1,k2,k3],{strcat('mean(k1)=',num2str(mean(k1))) strcat('mean(k2)=',num2str(mean(k2))) strcat('mean(k3)=',num2str(mean(k3)))},'Colors','b')

 PGen=P(:,1);PCurt=P(:,2);PLoad=P(:,3);PAmount=P(:,4);
 figure();
 boxplot((PGen),{'PGen'},'Colors','b')
 figure();
 boxplot((PCurt),{'PCurt'},'Colors','b')
 figure();
 boxplot((PLoad),{'PLoad'},'Colors','b')
 figure();
 boxplot((PAmount),{'PAmount'},'Colors','b')
toc