function ScatterPlot=ScatterPlot(b_array, GenCost, KmeansIndex, PCAKmeansIndex)

%% plot Net load vs Gen cost and shows the respresentative scenarios on top of that

S=sum(b_array,2);
ScatterPlot=figure();
plot(S,GenCost,'.blue','MarkerSize',10);
hold on;
plot(S(KmeansIndex),GenCost(KmeansIndex),'.red','MarkerSize',10);
hold on;
plot(S(PCAKmeansIndex),GenCost(PCAKmeansIndex),'.green','MarkerSize',10);
xlabel('Net Load Gwh')
ylabel('Generation cost')
legend('Generation Cost','K-means','PCA+K-means')
end