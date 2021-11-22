%
% NOTE:    Calls all the assets, and for each assets calculates the Brier scores for the event
% of zero wind generation plot the histograms for the KS score in figure 1
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%         
%=========================================================================
function scorevalue=BrierScoreValuesWind;
%tic
scorevalue=[];
for day=1:4
    BrierScoreSeries=[];
    files = dir('Scovilleriskpartners/CSV/IntraDay1/SimDat_20170101/wind/*.csv');
    for i=1:length(files)
        BrierScore=0.0;number=0.0;score=0.0;
        datetime.setDefaultFormats('defaultdate','yyyyMMdd')
        t = datetime(2017,1,1:365);
        date=t';
        time=char(date(1));
        filename=files(i).name;
        for k=1:365
            year=char(date(k));
            name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/wind/',filename);
            %name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',year,'/wind/',filename);
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
        BrierScore=score/number;
        BrierScoreSeries=[BrierScoreSeries;BrierScore];%averaging over
    end
scorevalue(:,day)=BrierScoreSeries;% scorevalue shows Brier score for all intra days and plots
end
for day=1:4
figure(1)
subplot(2,2,day)
histogram(scorevalue(:,day),20)
xlim([0,0.25])
ylim([0,65])
title(strcat('Intra Day',num2str(day)))
end
%toc
end