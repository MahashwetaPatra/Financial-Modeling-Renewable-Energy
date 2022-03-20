%%
% NOTE:   Calculates distribution of generation cost, load shedding and renewable curtailment
% HIST:  - 10 Feb, 2022: Created by Patra
%=========================================================================
function [GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen,l]=RTSDailySummaryFunction(Month)
%% Vatic output
VaticOutput = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedData",Month,"\\VaticOutput.csv")); 
GenCost=VaticOutput{:,2};
[MaxGen, Idx]=sort(GenCost);
GenIdx=Idx(950:1000);

LoadShed=VaticOutput{:,3};
ExtLoad=[];
for i=2:1000
    if (VaticOutput{i,3} ~= 0.0)
        ExtLoad=[ExtLoad; VaticOutput{i,1}];
    end
end
out=sum(LoadShed==0);
l=length(ExtLoad);

Curtailment=VaticOutput{:,4};
[Curt, Idx]=sort(VaticOutput{:,4});
CurIdx=Idx(950:1000);
end