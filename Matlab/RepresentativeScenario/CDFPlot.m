function [CdfPlot, KStest] =CDFPlot(GenCost, RepScenario, KmeansIndex, PCAKmeansIndex)

%% plots the cumulative distribution function
CdfPlot=figure();
cdfplot(GenCost)
hold on;
cdfplot(GenCost(1:RepScenario))
cdfplot(GenCost(KmeansIndex))
cdfplot(GenCost(PCAKmeansIndex))
set(gca,'FontSize',10,'LineWidth',1.0)
[~, ~, k1]=kstest2(GenCost, GenCost(1:RepScenario));
[~, ~, k2]=kstest2(GenCost, GenCost(KmeansIndex));
[~, ~, k3]=kstest2(GenCost, GenCost(PCAKmeansIndex));
legend('GenCost',strcat('Subsampling,','K-S score: ',num2str(k1)),strcat('K-means,','K-S score: ',num2str(k2)),strcat('PCA+Kmeans,','K-S score: ',num2str(k3)),'Location','southeast')
KStest=[k1, k2, k3];
end