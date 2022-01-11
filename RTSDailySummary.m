%%
% NOTE:    Calls the four wind asset, from a day and for that assets
%          calculates distribution of generation cost, load shedding and renewable curtailment
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
function [GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, GenIdxSolar, ExtLoadSolar, CurIdxSolar, GenCostSolar]=RTSDailySummary
clc;close all; clear all;
%% Wind Vatic output
GenerationCost = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/GenerationCostJanuary20.csv'); 
figure(1)
subplot(1,3,1)
GenCost=GenerationCost{:,2};
histogram(GenCost)
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
[MaxGen, Idx]=sort(GenCost);
GenIdx=Idx(950:1000);

LoadShedding = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/LoadSheddingJanuary20.csv'); 
subplot(1,3,2)
histogram(LoadShedding{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
LoadShed=LoadShedding{:,2};
ExtLoad=[];
for i=2:1000
    if (LoadShedding{i,2} ~= 0.0)
        ExtLoad=[ExtLoad; LoadShedding{i,1}];
    end
end
size(ExtLoad)

RenewablesCurtailmentJanuary20 = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/RenewablesCurtailmentJanuary20.csv'); 
subplot(1,3,3)
histogram(RenewablesCurtailmentJanuary20{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
[Curtailment, Idx]=sort(RenewablesCurtailmentJanuary20{:,2});
CurIdx=Idx(950:1000);

%% Solar Vatic output
GenerationCostSolar = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/GenerationCostSolarJanuary20.csv'); 
figure(2)
subplot(1,3,1)
histogram(GenerationCostSolar{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
GenCostSolar=GenerationCostSolar{:,2};
[MaxGenSolar, IdxSolar]=sort(GenerationCostSolar{:,2});
GenIdxSolar=IdxSolar(950:1000);

LoadSheddingSolar = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/LoadSheddingSolarJanuary20.csv'); 
subplot(1,3,2)
histogram(LoadSheddingSolar{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
ExtLoadSolar=[];
for i=2:1000
    if (LoadSheddingSolar{i,2} ~= 0.0)
        ExtLoadSolar=[ExtLoadSolar; LoadSheddingSolar{i,1}];
    end
end
size(ExtLoadSolar)

RenewablesCurtailmentSolarJanuary20 = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/RenewablesCurtailmentSolarJanuary20.csv'); 
subplot(1,3,3)
histogram(RenewablesCurtailmentSolarJanuary20{:,2})
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.75)
[CurtailmentSolar, IdxSolar]=sort(RenewablesCurtailmentSolarJanuary20{:,2});
CurIdxSolar=IdxSolar(950:1000);

end