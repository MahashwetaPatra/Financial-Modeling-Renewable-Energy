%%
% NOTE:   Calculates distribution of generation cost, load shedding and renewable curtailment
% HIST:  - 10 Feb, 2022: Created by Patra
%=========================================================================
function [GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen,l]=RTSDailySummaryFunction(FileDir,Month)
%% Vatic output
VaticOutput = readtable(strcat(FileDir,Month,"\\VaticOutput.csv")); 
GenCost=VaticOutput{:,1};
[MaxGen, Idx]=sort(GenCost);
GenIdx=Idx(950:1000);

LoadShed=VaticOutput{:,2};
ExtLoad=[];
for i=2:1000
    if (VaticOutput{i,2} ~= 0.0)
        ExtLoad=[ExtLoad; VaticOutput{i,2}];
    end
end
out=sum(LoadShed==0);
l=length(ExtLoad);

Curtailment=VaticOutput{:,3};
[Curt, Idx]=sort(VaticOutput{:,3});
CurIdx=Idx(950:1000);
end