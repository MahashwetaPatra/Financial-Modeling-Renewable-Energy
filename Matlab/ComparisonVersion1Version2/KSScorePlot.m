%% Compares the KS score for version1 and version2. Run script KSScoreVersion1Version2
function KSScorePlot=KSScorePlot(version1Solar, version2Solar, version1Wind, version2Wind)
x=zeros(8,1);
y=ones(8,1);
figure;
for i=1:length(version2Wind)
    p(1)=x(i);v(1)=version1Wind(i);
    p(2)=y(i);v(2)=version2Wind(i);
    plot(p,v,'-o', 'LineWidth',2)   
    hold on;
end
grid on;
hold on;
title('KS-score for Wind assets, Version1-vs-Version2')
legend('FW', 'N', 'NC', 'S', 'W')


KSScorePlot = figure;
for i=1:length(version2Solar)
    p(1)=x(i);v(1)=version1Solar(i);
    p(2)=y(i);v(2)=version2Solar(i);
    plot(p,v,'-o', 'LineWidth',2)
    hold on;
end
grid on; 
title('KS-score for Solar assets, Version1-vs-Version2')
legend('C', 'FW', 'N', 'NC', 'S', 'SC', 'W')
end