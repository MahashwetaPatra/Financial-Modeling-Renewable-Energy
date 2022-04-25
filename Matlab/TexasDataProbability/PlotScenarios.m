function Scenarios=PlotScenarios(T, b_array)

%% plots the scenarios
Scenarios=figure;
plot(T,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
end