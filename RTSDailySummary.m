%%
% NOTE:    Calls the four wind asset, from a day and for that assets
%          calculates distribution of generation cost, load shedding and renewable curtailment
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
function GenIdx=RTSDailySummary
clc;close all; clear all;
%% Provide with the Input
GenerationCost = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/GenerationCostJanuary20.csv'); 
figure()
histogram(GenerationCost{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
[MaxGen, Idx]=sort(GenerationCost{:,2});
GenIdx=Idx(950:1000);

LoadShedding = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/LoadSheddingJanuary20.csv'); 
figure()
histogram(LoadShedding{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
ExtLoad=[];
for i=2:1000
    if (LoadShedding{i,2} ~= 0.0)
        ExtLoad=[ExtLoad; LoadShedding{i,1}];
    end
end
size(ExtLoad);

RenewablesCurtailmentJanuary20 = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/RenewablesCurtailmentJanuary20.csv'); 
figure()
histogram(RenewablesCurtailmentJanuary20{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
[Curtailment, Idx]=sort(RenewablesCurtailmentJanuary20{:,2});
CurIdx=Idx(950:1000);
end