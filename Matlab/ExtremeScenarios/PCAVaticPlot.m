function PCAVaticPlot=PCAVaticPlot(score,Curtailment,CurtIdx,MaxCurt, GenCost,GenIdx, MaxGen,Ext,Ext2,LoadShed, LoadShedExt)

%% plot Net load vs Gen cost and shows the respresentative scenarios on top of that

PCAVaticPlot=figure()
subplot(1,3,1)
scatter(score(:,1),GenCost)
hold on;
scatter(score(Ext2,1),GenCost(Ext2))
xlabel('PC1')
ylabel('Generation Cost')
grid on;

subplot(1,3,2)
scatter(score(:,1),LoadShed)
hold on;
scatter(score(Ext2,1),LoadShed(Ext2))
%scatter(score(LoadIdx(950:1000),1),MaxLoad(950:1000))
ylabel('Load Shedding')

xlabel('PC1')
grid on;

subplot(1,3,3)
scatter(score(:,1),Curtailment)
hold on;
scatter(score(Ext,1),Curtailment(Ext))
%scatter(score(CurtIdx(950:1000),1),MaxCurt(950:1000))
hold on;
%scatter(ExtPC(IdxCommon),GenCost(IdxCommon),'.')
xlabel('PC1')
ylabel('Curtailment')
grid on;

figure(1)
subplot(1,3,1)
hold on;
h=histogram(GenCost(Ext2));
h.BinWidth = 25000;

figure(1)
subplot(1,3,2)
hold on;
h=histogram(LoadShed(Ext2));
h.BinWidth = 100;
ylabel('Load Shedding')

figure(1)
subplot(1,3,3)
hold on;
h3=histogram(Curtailment(Ext));
h3.BinWidth = 300;
ylabel('Curtailment')
end