%
% NOTE:    Calls all the wind assets, and for each assets calculates the Brier scores for the event
%          of zero wind generation plot the histograms for the Brier score, and compares the wind assets 
%          for version1 and version2 in figure 7 in the report
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%        - 31st May, 2022: added the comparision between version 1, version 2 texas data 
%=========================================================================
tic
clc;close all; clear all;
parfor j=1:2
    if j==1
        % version 1
        files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/CSV/DA/SimDat_20170101/wind/*.csv');
    elseif j==2
        files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20170101/wind/*.csv');
        % version 2
    end
    scorevalue=zeros(length(files),1);
    for i=1:length(files)
        number=0.0;score=0.0;
        datetime.setDefaultFormats('defaultdate','yyyyMMdd')
        t = datetime(2017,1,1:730);
        date=t';
        filename=files(i).name;
        for k=1:730
            year=char(date(k));
            if j==1
                name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/CSV/DA/SimDat_',year,'/wind/',filename);
            elseif j==2
                name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_',year,'/wind/',filename);
            end
            Array = readtable(name);
            for column=1:24 %considers all the six hours
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
                    end %end if, checking whether actual produces zero or nonzero wind
                    score=score+BS; % summing over all six hours
                    number=number+1;
                end %end if, whether probability /frequency of zero wind generation is more than 1%
            end %end for, summing over 6 hours
        end %end for, summing over 2yrs
        scorevalue(i)=score/number;
    end% end for, end of all assets 
    figure(1)
    subplot(1,2,j)
    histogram(scorevalue,10)
    title("DA")
end
toc