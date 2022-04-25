function ProbNew=ScatterPlot(b_array,  score,  GenIdx)

%% plot Net load vs Gen cost and shows the respresentative scenarios on top of that

NetLoadGWh=sum(b_array,2);
[MaxNetLoad, NetLoadIdx]=sort(NetLoadGWh);
figure();
subplot(1,2,1)
plot(NetLoadGWh,score(:,1),'.blue','MarkerSize',10);
hold on;
plot(NetLoadGWh(GenIdx),score(GenIdx,1),'.red','MarkerSize',5);
legend('Net Load-Score1','High cost', 'Location','southeast')
xlabel('Net Load Gwh')
ylabel('Score1')

subplot(1,2,2)
% we take 20 samples from highest 20 net load, next 30 samples we take
% using conditions on the next highest net load samples.
i=20;j=30;
check=sort(MaxNetLoad(1000-i-j:1000-i)./score(NetLoadIdx(1000-i-j:1000-i),1));
check1=check(10);%we remove 10 points from the scatter plots, which has x/y value high
numbers=0;

IArray=NetLoadIdx(1000-i:1000);
plot(MaxNetLoad(1000-i:1000),score(NetLoadIdx(1000-i:1000),1),'.blue','MarkerSize',10);
hold on;
while numbers<j
    ratio=MaxNetLoad(1000-i)/score(NetLoadIdx(1000-i),1);
    if (ratio>check1)
        plot(MaxNetLoad(1000-i),score(NetLoadIdx(1000-i),1),'.blue','MarkerSize',10);
        hold on;
        numbers=numbers+1;
        IArray=[IArray;NetLoadIdx(1000-i)];
    end
    i=i+1;
end
plot(NetLoadGWh(GenIdx),score(GenIdx,1),'.red','MarkerSize',5);
ProbNew=length(intersect(IArray,GenIdx))/length(GenIdx);
corrcoef(NetLoadGWh,score(:,1));
xlabel('Net Load Gwh')
ylabel('Score1')
%legend('Net Load-Score1','High cost')
end