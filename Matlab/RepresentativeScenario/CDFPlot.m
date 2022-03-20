function CdfPlot =CDFPlot(GenCost, RepScenario, KmeansIndex, PCAKmeansIndex)

%% plots the cumulative distribution function
CdfPlot=figure();
cdfplot(GenCost)
hold on;
cdfplot(GenCost(1:RepScenario))
cdfplot(GenCost(KmeansIndex))
cdfplot(GenCost(PCAKmeansIndex))
set(gca,'FontSize',10,'LineWidth',1.0)
end