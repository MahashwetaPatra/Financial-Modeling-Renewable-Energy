%
% NOTE:    Calls all the assets, and for each assets calculates the Brier scores for the event
% of zero wind generation plot the histograms for the Brier score in figure 1
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
files = dir('Scovilleriskpartners/CSV/IntraDay1/SimDat_20170101/wind/*.csv');
scorevalue=zeros(length(files),4);
for day=1:5
    parfor i=1:length(files)
        number=0.0;score=0.0;
        datetime.setDefaultFormats('defaultdate','yyyyMMdd')
        t = datetime(2017,1,1:30);
        date=t';
        filename=files(i).name;
        for k=1:30
            year=char(date(k));
             if day==5
                 name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',year,'/wind/',filename);
             
             else
                name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/wind/',filename);
             end
                Array = readtable(name);
            for column=1:6 %considers all the six hours
                c=column+2;
                c1=Array{4:1003,c}; % considers column for each hour 
                n = length(c1);% length of column
                idx=c1==0;  %check how many zero entries we have in that column
                out=sum(idx(:));
                probability=out/n;%checking the frequency of zero wind generation
                if probability>0.01 % check if the frequency/probability of zero wind generation is greater than 1%
                    actual=Array{3,c};% ckeck the event, i.e., whether the actual is generating zero wind
                    if actual==0 %Depending on the event, actual producing zero wind it calculates the Brier score
                        BS=(probability-1)*(probability-1);
                    else
                        BS=(probability-0)*(probability-0);
                    end
                    score=score+BS; % summing over all six hours
                    number=number+1;
                end
            end
        end
        number;
        BrierScore=score/number;
        scorevalue(i,day)=BrierScore;
    end
end
for day=1:5
    figure(1)
    subplot(1,5,day)
    histogram(scorevalue(:,day),10)
    if day==5
        title("DA")
    else
        title(strcat('Intra Day',num2str(day)))
    end
    %xlim([0,0.25])
    %ylim([0,65])   
end
toc