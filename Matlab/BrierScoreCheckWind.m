%
% NOTE:    function that calculates the Brier Score for the  max wind generation
%
% HIST:  - 11 Aug, 2021: Created by Patra
%         -Added more notes to it
%=========================================================================
function BrierScore=BrierScoreCheck(filename,day);
BrierScore=0.0;number=0.0;
score=0.0;
datetime.setDefaultFormats('defaultdate','yyyyMMdd')
t = datetime(2017,1,1:730);
date=t';
time=char(date(1));
parfor k=1:730
    year=char(date(k));
    %name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',year,'/solar/',string(filename));
    %name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/solar/',string(filename));
    if day==5
        name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',year,'/wind/',string(filename));
    
    else
        name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/wind/',string(filename));
    end
        %name=strcat('Scovilleriskpartners/CSV/DA/SimDat_',year,'/wind/',string(filename));
    Array = readtable(name);
    for column=1:6 % For intraday block it is 6, for DA the value is 24
        c=column+2;
        c1=Array{4:1003,c};
        check=max(c1);% considering the max wind generation for each hour
        n = length(c1);
        idx=c1==check;% checking whether the highest value repeats or not 
        out=sum(idx(:));
        probability=out/n;
        if probability>0.01% checking the frequency of occurence of the highest value
            actual=Array{3,c};
            if actual==check
                BS=(probability-1)*(probability-1);
            else
                BS=(probability-0)*(probability-0);
            end
            score=score+BS;
            number=number+1;
        end
    end
end
number;
BrierScore=score/number;
end
