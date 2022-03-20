function PlotPCA=PCAPlot(Time,coeff, score, NetLoad, CurtIdx)


%% plot Net load vs Gen cost and shows the respresentative scenarios on top of that

PlotPCA=figure()
subplot(1,2,1) 
plot(Time,coeff(:,1), '-black', 'LineWidth',1.2)
hold on;
plot(Time,coeff(:,2),'-blue', 'LineWidth',1.2)
plot(Time,coeff(:,3),'-green', 'LineWidth',1.2)
legend('PC1','PC2','PC3')
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',12,'LineWidth',1.0)

j = boundary(score(:,1),score(:,3),1.0);
subplot(1,2,2)
plot(score(:,1),score(:,3),'.black', 'MarkerSize',15)
hold on;
plot(score(j,1),score(j,3),'.red','markersize',15);
hold on;
plot(score(CurtIdx(1:50),1),score(CurtIdx(1:50),3),'.green','markersize',15);
set(gca,'FontSize',12,'LineWidth',1.0)
xlabel('PC1')
ylabel('PC3')
%legend('PC1-PC3','boundary','High Load Shed')
end