function HistogramVaticoutput=HistogramVaticoutput(GenCost, LoadShed, Curtailment)

%% plots the distribution of vatic output
HistogramVaticoutput=figure();
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',16,'LineWidth',1.0)

subplot(1,3,1)
h1=histogram(GenCost,15);
%h1.BinWidth = 50000;
ylabel('Generation Cost')
hold on;

subplot(1,3,2)
histogram(LoadShed,15);
%h2.BinWidth = 100;
ylim([0 100])
ylabel('Load Shedding')
hold on;

subplot(1,3,3)
histogram(Curtailment,15);
%h3.BinWidth = 300;
ylabel('Curtailment')
hold on;

end
