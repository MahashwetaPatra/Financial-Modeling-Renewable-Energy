%%
% NOTE:   Calculates distribution of generation cost, load shedding and renewable curtailment
% HIST:  - 10 Feb, 2022: Created by Patra
%=========================================================================
function [GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen,l]=RTSDailySummaryFunction
%% Vatic output
VaticOutput = readtable(strcat("C:\\Users\\Mahashweta Patra\\Downloads\\ProcessedData\\ProcessedDataJan\\VaticOutput.csv")); 
figure(1)
subplot(1,3,1)
GenCost=VaticOutput{:,2};
h=histogram(GenCost,15)
h.BinWidth = 50000;
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
[MaxGen, Idx]=sort(GenCost);
GenIdx=Idx(950:1000);
%hold on;
%histogram(MaxGen(950:1000))

subplot(1,3,2)
h=histogram(VaticOutput{:,3})
h.BinWidth = 100;
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
LoadShed=VaticOutput{:,3};
ExtLoad=[];
for i=2:1000
    if (VaticOutput{i,3} ~= 0.0)
        ExtLoad=[ExtLoad; VaticOutput{i,1}];
    end
end
l=length(ExtLoad)
subplot(1,3,3)
histogram(VaticOutput{:,4})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
Curtailment=VaticOutput{:,4};
[Curt, Idx]=sort(VaticOutput{:,4});
CurIdx=Idx(950:1000);
end