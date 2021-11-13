%
% NOTE:    calculates the Brier Score for the asset for intra day 1, 2, 3, 4
%
% HIST:  - 11 Aug, 2021: Created by Patra
%         
%=========================================================================
function BrierScoreCheck(filename)
BrierScoreSeries=[];
for day=1:4
    BrierScore=0.0;number=0.0;
    datetime.setDefaultFormats('defaultdate','yyyyMMdd')
    t = datetime(2017,1,1:365);
    date=t';
    time=char(date(1));
    for k=1:365
        year=char(date(k));
        name=strcat('Scovilleriskpartners/CSV/IntraDay',num2str(day),'/SimDat_',year,'/wind/',string(filename));
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
    number
    BrierScoreSeries=[BrierScoreSeries;BrierScore/number];
end
BrierScoreCheck=BrierScoreSeries
end