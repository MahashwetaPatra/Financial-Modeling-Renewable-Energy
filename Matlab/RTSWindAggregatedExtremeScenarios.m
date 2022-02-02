%
% NOTE:    (a)Calls the four wind asset, from a day and take the summation of all the assets
%          (b) Identify the extreme scenarios (those that yield the 5%
%          highest cost), shows them on aggregated assets
%           (c) shows distribution of all scenrios at hours=6, 12, 18, 24
% HIST:  - 4 Jan, 2022: Created by Patra
%=========================================================================
function RTSWindAggregatedExtremeScenario
    [GenIdx, ExtLoad, CurIdx, GenCost, LoadShed]=RTSDailySummary;
    Time=1:1:24;%Time steps
    Array = readtable('ORFEUSRTS/type-pwrset-jan20-20211229T210546Z-001/type-pwrset-jan20/WindScenariosAggregated.csv');
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
    figure(3);
    grid on;
    subplot(1,3,1)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    grid on;
    hold on;
    max(GenIdx)
    plot(Time,b_array(max(GenIdx),:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    grid on;
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Extreme Generation Cost')

    subplot(1,3,2)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    hold on;
    plot(Time,b_array(ExtLoad,:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Load Shedding')

    subplot(1,3,3)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    hold on;
    plot(Time,b_array(CurIdx,:),'Color', [0.45 0.45 0.45],'markersize',5) %plot the mean of all scenarios
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Extreme Renewable curtailment')

    figure(4)%%plots the histogram at some hour
    subplot(1,4,1)
    histogram(b_array(2:1001,6),10)
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,2)
    histogram(b_array(2:1001,12),10)
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,3)
    histogram(b_array(2:1001,18),10)
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    subplot(1,4,4)
    histogram(b_array(2:1001,24),10)
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)

    figure(5)
    plot( b_array(2:1001,1), GenCost,'.b', 'MarkerSize',5)
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',12,'LineWidth',1.0)
    xlabel('Aggregated Scenarios')
    ylabel('Generation Cost')

    %% plots all the scenarios
    figure(6);
    Extreme=[];
    subplot(1,3,1)
    for i=2:1001
        if (b_array(i,2)>1000 & b_array(i,6)>1500 & b_array(i,13)<200 & b_array(i,23)>500)
            plot(Time,b_array(i,:),'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
            hold on
            %set(gca, 'GridLineStyle', ':') %dotted grid lines
            set(gca,'FontSize',10,'LineWidth',1.0)
            title('Extreme Generation Cost')
            Extreme=[Extreme;i];
        end
    end
    size(Extreme);
    ExGenCost=[];
    for i=1:length(Extreme)
        ExGenCost=[ExGenCost;GenCost(i)];
    end
    size(ExGenCost)
    min(ExGenCost)
    max(ExGenCost)

    Ext=[];bm=mean(b_array);
    subplot(1,3,2)

    extreme=zeros(20,24);point=0.0;
range=max(max(b_array));
thresold=range*0.15;
for i=2:1001
    check=length(find((b_array(i,:)<bm)<1));
    fluc1=[];
    for hours=1:23
        fluc1=[fluc1; abs(b_array(i,hours+1)-b_array(i,hours))];
        bcheck(hours)=1800;
    end
    bcheck(24)=1800;
    check=length(find((b_array(i,:)<bcheck)<1));
    avgfluc1=mean(fluc1);
    if (avgfluc1>thresold)
    %if (max(avgfluc1)>1000)% && check==0 )
            %&& b_array(i,7)>800 & b_array(i,16)<800)
        point=point+1;
        extreme(point,:)=b_array(i,:);
        Ext=[Ext;i];
    end
end
plot(Time,b_array(ExtLoad(6:10),:),'.-b')
grid on;
hold on;
ExtDef=LoadShed(Ext)
%plot(Time,extreme,'.-r')
% plot(Time,b_array(49,:),'.-b')
% plot(Time,b_array(223,:),'.-b')
 numberset=point;
 length(Ext);
 LoadShed(Ext);

%  subplot(1,3,2)
%     for i=2:1001
%         hours=1:14; hours2=15:23;
%         if (b_array(i,hours)<1200)
%             %if (b_array(i,hours2)>1000)
%             plot(Time,b_array(i,:),'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
%             hold on
%             %set(gca, 'GridLineStyle', ':') %dotted grid lines
%             set(gca,'FontSize',10,'LineWidth',1.0)
%             title('Extreme Generation Cost')
%             Extreme=[Extreme;i];
%             %end
%         end
%     end
%     size(Extreme)
%     ExLoadShed=[];
%     for i=1:length(Extreme)
%         ExLoadShed=[ExLoadShed;LoadShed(i)];
%     end
%     ExLoadShed
%     min(ExLoadShed)
%     max(ExLoadShed)
    
    %plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    %set(gca,'FontSize',10,'LineWidth',1.0)
    %title('Load Shedding')

    subplot(1,3,3)
    plot(Time,b_array,'Color', [0.7 0.7 0.7],'markersize',5) %plot the mean of all scenarios
    %set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',10,'LineWidth',1.0)
    title('Extreme Renewable curtailment')

end
