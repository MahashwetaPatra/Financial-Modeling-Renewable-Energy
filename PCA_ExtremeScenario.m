%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenario =PCA_ExtremeScenario(year, assettype, filename,Array,numExtremeScen);
T1=1:1:24; %Time steps
scenario_num=size(Array);
b_array=[];
parfor k=4:scenario_num(1)
    b=[];
    col = Array(k,:);
    hold on; 
    for i=1:24 % put the asset in a array
        j=i+2;
        b=[b;col{1,j}];
    end
    
    for i=1:24
        b_array(k,i)=b(i);
    end    
end
figure(1);
subplot(1,2,1)
plot(T1,b_array,'Color', [0.7 0.7 0.7],'markersize',5);
hold on;
[c_array,I]=sort(b_array,'ascend');
size_c_array=size(c_array);
index=[];lowerB=[];
bm=mean(b_array);% calculating the mean of all the scenarios
PCA_ExtremeScenario=plot(T1,bm,'.-black','markersize',20);
hold on;
LowerBound=[];UpperBound=[];
for k=1:24
    sizecolumn=sort(b_array(:,k));
    LowerBound=[LowerBound;sizecolumn(50)];
    UpperBound=[UpperBound;sizecolumn(950)];
end
plot(T1,LowerBound,'-black','LineWidth',2);
hold on;
plot(T1,UpperBound,'-black','LineWidth',2);  
[coeff,score]=pca(b_array);
subplot(1,2,2);
A=[score(:,1),score(:,2)];
plot(score(:,1),score(:,2), '.green', 'markersize', 5);
x=score(:,1);y=score(:,2);
j = boundary(x,y,1.0);
%j = convhull(x,y);
hold on;
plot(x(j),y(j),'.b','markersize',10);
strValues =strtrim(cellstr(num2str([j],'%d')));
text(x(j),y(j),strValues);
hold on;
sizej=size(j);

plot(score(100,1),score(100,2), '.b', 'markersize', 20);

points=0.0;
for k=1:size(j);
    m=j(k);
    check=x(k);
    if (check<0 & points<numExtremeScen);
        points=points+1;
        subplot(1,2,1)
        plot(T1,b_array(m,:),'-blue','markersize',10)
        hold on;
    end
end
plot(T1,b_array(100,:),'blue','LineWidth',2.0)
points;

for i=1:24
index=[index;I(4,i)];
lowerB=[lowerB;b_array(I(4,i),:)];
subplot(1,2,1);
plot(T1,b_array(I(4,i),:),'-red','markersize',10);
hold on;
end
[coeff,score]=pca(lowerB);
subplot(1,2,2);
plot(score(:,1),score(:,2), '.red', 'markersize', 20);
end