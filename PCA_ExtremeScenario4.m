%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenario4 =PCA_ExtremeScenario4(Array,numExtremeScen)
T1=1:1:24; %Time steps
scenario_num=size(Array);
b_array=zeros(1003,24);
parfor k=4:scenario_num(1)
    b=zeros(24,1);
    col = Array(k,:);
    hold on; 
    for i=1:24 % put the asset in a array
        j=i+2;
        b(i)=col{1,j};
        b_array(k,i)=b(i);
    end    
end
PCA_ExtremeScenario4=figure(4);
subplot(1,2,1);
%plot(T1,b_array,'Color', [0.7 0.7 0.7],'markersize',5);
hold on;
bm=mean(b_array);% calculating the mean of all the scenarios
subplot(1,2,1);
plot(T1,bm,'.-black','markersize',20);
hold on;
LowerBound=zeros(24,1);UpperBound=zeros(24,1);
parfor k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound(k)=sizecolumn(50);
    UpperBound(k)=sizecolumn(950);
end
hold on
x2 = [T1, fliplr(T1)];
xlabel('Time (hours)'); 
ylabel('Energy (MW)'); 
set(gca, 'GridLineStyle', ':') %dotted grid lines
set(gca,'FontSize',18,'LineWidth',1.5)

fill(x2, [bm, fliplr(UpperBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
fill(x2, [bm, fliplr(LowerBound')], 0.7 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);

extreme=zeros(numExtremeScen,24);point=0.0;
for i=4:scenario_num(1)
    check=length(find((b_array(i,:)<bm)<1));
    if check==0
        point=point+1;
        extreme(point,:)=b_array(i,:);
    end
end
size(extreme)
subplot(1,2,1);
plot(T1,extreme,'.-blue','markersize',5);

[coeff,score]=pca(b_array);
subplot(1,2,2);
plot(score(:,1),score(:,2), '.green', 'markersize', 5);
hold on;

x=score(:,1);y=score(:,2);
j = boundary(x,y,1.0);
%j = convhull(x,y);
hold on;
subplot(1,2,2);
plot(x(j),y(j),'.r','markersize',10);
%strValues =strtrim(cellstr(num2str([j],'%d')));
%text(x(j),y(j),z(j),strValues);
hold on;
sizej=size(j);
[coeff,score]=pca(extreme);
subplot(1,2,2);
plot(score(:,1),score(:,2), '.blue', 'markersize', 10);
hold on;
end