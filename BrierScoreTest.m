%
% NOTE:    Calls all the assets, calculates the Brier Score and plots the Histogram from the scores
%
% HIST:  - 11 Aug, 2021: Created by Patra
%         
%=========================================================================
tic
clc;close all; clear all;
for day=1:4
    BrierScoreSeries=[];
    files = dir('Scovilleriskpartners/CSV/IntraDay1/SimDat_20170101/solar/*.csv');
    for i=1:length(files)
        BrierScore=0.0;number=0.0;
        datetime.setDefaultFormats('defaultdate','yyyyMMdd')
        t = datetime(2017,1,1:365);
        date=t';
        time=char(date(1));
        filename=files(i).name;
        for k=1:365
            year=char(date(k));
            name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/solar/',filename);
            Array = readtable(name);
            score=0.0;
            for column=1:6
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
figure(1)
subplot(2,2,day)
histogram(BrierScoreSeries,10)
xlim([0,0.3])
ylim([0,12])
end
toc