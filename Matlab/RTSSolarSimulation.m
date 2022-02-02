%
% NOTE:    (a)Calls a solar asset, from a day and for that assets, shows
%           the scenarios and  
%          (b) Identify the extreme scenarios (those that yield the 5%
%          highest cost) and shows them on the scenarios
%           (c) shows distribution of all scenrios at hours=6, 12, 18, 24
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
function RTSSolarSimulation
    Time=1:1:24;%Time steps
    Array = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/SolarScenariosAggregated.csv'); 
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
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',18,'LineWidth',1.5)

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
end
