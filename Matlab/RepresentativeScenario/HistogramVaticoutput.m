function HistogramVaticoutput=HistogramVaticoutput(GenCost, LoadShed, Curtailment)

%% plots the distribution of vatic output
HistogramVaticoutput=figure();
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',16,'LineWidth',1.0)

subplot(1,3,1)
h1=histogram(GenCost,15);
h1.BinWidth = 25000;
ylabel('Generation Cost')

subplot(1,3,2)
h2=histogram(LoadShed);
h2.BinWidth = 100;
ylabel('Load Shedding')

subplot(1,3,3)
h3=histogram(Curtailment);
h3.BinWidth = 300;
ylabel('Curtailment')

end
