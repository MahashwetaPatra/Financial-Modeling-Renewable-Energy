%
% NOTE:    (a)Calls the four wind asset, from a day and take the summation of all the assets
%          (b) Identify the extreme scenarios (those that yield the 5%
%          highest cost), shows them on aggregated assets
%           (c) shows distribution of all scenrios at hours=6, 12, 18, 24
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
function RTSWindAggregated
    [GenIdx, ExtLoad, CurIdx, GenCost, GenIdxSolar, ExtLoadSolar, CurIdxSolar, GenCostSolar]=RTSDailySummary;
    Time=1:1:24;%Time steps
    Array = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/SolarScenariosAggregated.csv');
    %SolarScenarios320_PV_1.csv']); 
    SizeScenario=size(Array);
    b_array=zeros(1001,24);
    for k=2:SizeScenario(1)
        b=zeros(24,1);
        col = Array(k,:);
        hold on; 
        for i=1:24% put the asset in a array
            j=i+1;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    %% plots the scenarios
    figure();
    subplot(1,3,1)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    hold on;
    plot(Time,b_array(GenIdxSolar,:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Extreme Generation Cost')

    subplot(1,3,2)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    hold on;
    plot(Time,b_array(ExtLoadSolar,:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Load Shedding')

    subplot(1,3,3)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    hold on;
    plot(Time,b_array(CurIdxSolar,:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Extreme Renewable curtailment')

    figure()%%plots the histogram at some hour
    subplot(1,4,1)
    histogram(b_array(2:1001,6),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,2)
    histogram(b_array(2:1001,12),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,3)
    histogram(b_array(2:1001,18),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,4)
    histogram(b_array(2:1001,24),10)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)

    figure()
    plot( b_array(2:1001,1), GenCostSolar,'.b', 'MarkerSize',5)
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    xlabel('Aggregated Scenarios')
    ylabel('Generation Cost')
end