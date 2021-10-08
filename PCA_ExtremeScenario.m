%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenario =PCA_ExtremeScenario(year, assettype, filename,Array);
T1=1:1:24; %Time steps
scenario_num=size(Array);
b_array=[];
for k=3:scenario_num(1)
    b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24 % put the asset in a array
        j=i+2;
        b=[b;col{1,j}];
    end
    figure(1)
    subplot(1,2,1)
%    plot(T1,b,'Color', [0.7 0.7 0.7],'markersize',5)
%    hold on;
    for i=1:24
        b_array(k,i)=b(i);
    end
end
size(b_array);%final array of scenarios and time
bm=mean(b_array);% calculating the mean of all the scenarios
PCA_ExtremeScenario=plot(T1,bm,'.-black','markersize',20)
hold on;
LowerBound=[];UpperBound=[];
for k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound=[LowerBound;sizecolumn(50)];
    UpperBound=[UpperBound;sizecolumn(950)];
end
plot(T1,LowerBound,'-black','LineWidth',2)
hold on;
plot(T1,UpperBound,'-black','LineWidth',2)  
[coeff,score]=pca(b_array);
subplot(1,2,2)
A=[score(:,1),score(:,2)];
plot(score(:,1),score(:,2), '.green', 'markersize', 5)
x=score(:,1);y=score(:,2);
j = boundary(x,y,1.0);
hold on;
plot(x(j),y(j));
strValues =strtrim(cellstr(num2str([j],'%d')));
text(x(j),y(j),strValues); 
for k=1:size(j)
    m=j(k);
    subplot(1,2,1)
    plot(T1,b_array(m,:),'LineWidth',0.02)
    hold on;
end
end