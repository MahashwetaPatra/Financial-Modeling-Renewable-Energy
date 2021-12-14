%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenario =PCA_ExtremeScenario(Array)
T1=1:1:24; %Time steps
scenario_num=size(Array);
b_array=zeros(1000,24);
parfor k=4:scenario_num(1)
    b=zeros(24,1);
    col = Array(k,:);
    for i=1:24 % put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end    
end
bm=mean(b_array);% calculating the mean of all the scenarios
figure(1);
subplot(1,3,1)
PCA_ExtremeScenario=plot(T1,bm,'.-black','markersize',20);
hold on;
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
for k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(50);
    UpperBound(k)=sizecolumn(950);
end
x2 = [T1, fliplr(T1)];
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)
fill(x2, [bm, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bm, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);

[coeff,score]=pca(b_array);
subplot(1,3,2);
plot(score(:,1),score(:,2), '.green', 'markersize', 5);
hold on;
subplot(1,3,3);
plot(T1,coeff(:,1), '-black', 'markersize', 10);
hold on;
plot(T1,coeff(:,2), '-blue', 'markersize', 10);
x=score(:,1);y=score(:,2);%x1=score(:,3);y1=score(:,4);
j = boundary(x,y,1.0);
%j = convhull(x,y);
hold on;
subplot(1,3,2);
plot(x(j),y(j),'.b','markersize',10);
strValues =strtrim(cellstr(num2str((j),'%d')));
text(x(j),y(j),strValues);
hold on;
points=0.0;
for k=1:size(j)
    m=j(k); 
    points=points+1;
    subplot(1,3,1)
    plot(T1,b_array(m,:),'-blue','markersize',10)
    hold on;
end
boundarypoint=points   
end