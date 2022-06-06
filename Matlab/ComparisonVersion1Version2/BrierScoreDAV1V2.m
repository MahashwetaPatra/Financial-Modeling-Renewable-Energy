%
% NOTE:    Calls all the solar assets, and for each assets calculates the Brier scores for the event
%          of maximum solar generation plot the histograms for the Brier score, and compares the solar assets 
%          for version1 and version2-Subset and version2 all assets in figure 7 in the report
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%        - 31st May, 2022: added the comparision between version 1, version 2 texas data 
%=========================================================================
tic
clc;close all; clear all;
for j=1:3
    BrierScoreSeries=[];
    if j==1
        % version 1
        files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/CSV/DA/SimDat_20170101/solar/*.csv');
    elseif j==2
        % version 2 Subset Assets
        files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/CSV/DA/SimDat_20170101/solar/*.csv');
    elseif j==3
        % version 2 All Assets
        files = dir('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_20170101/solar/*.csv');
    end
    for i=1:length(files)
        filename=files(i).name;
        BrierScore=0.0;number=0.0;
        datetime.setDefaultFormats('defaultdate','yyyyMMdd')
        t = datetime(2017,1,1:730);
        date=t';
        time=char(date(1));
        for k=1:730
            year=char(date(k));
            if j==1
                % version 1
                name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/CSV/DA/SimDat_',year,'/solar/',string(filename));
            elseif j==2
                % version 2 Subset Assets
                name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_',year,'/solar/',string(filename));
            elseif j==3
                % version 2 All Assets
                name=strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/Scovilleriskpartners/LiveSimulation/TX_SolarWindLoad_20220503/TX_SolarWindLoad_20220427/CSV/DA/SimDat_',year,'/solar/',string(filename));
            end
            Array = readtable(name);
            column=Array{3:1003,3};
            [A,I]=sort(column);
            size(I);
            if (A(995)==A(998))
                score=0.0;
                parfor column=1:24
                    c=column+2;
                    c1=Array{4:1003,c}; 
                    n = length(c1);
                    idx=c1==0;
                    out=sum(idx(:));
                    probability=out/n;
                    if probability>0.01
                        actual=Array{3,c};
                        if actual==0
                            BS=(probability-1)*(probability-1);
                        else
                            BS=(probability-0)*(probability-0);
                        end
                        score=score+BS;
                        number=number+1;
                    end
                end
                BrierScore=BrierScore+score;
            end
            BrierScore;
            number;
            BrierScoreSeries=[BrierScoreSeries;BrierScore/number];
        end
    end
    figure(1)
    subplot(1,3,j)
    histogram(BrierScoreSeries,25)
    csvwrite(strcat('C:/Users/Mahashweta Patra/Documents/MikeLudkovski/BrierScore/Solar_BrierScore',num2str(j),'.csv'),BrierScoreSeries,1,1);

end
toc