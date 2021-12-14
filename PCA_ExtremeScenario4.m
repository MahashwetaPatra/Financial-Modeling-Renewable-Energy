%
% NOTE: This is for calculating the shows the boundary of score phase space plot, i.e., showig the extreme scenarios 
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenario4 =PCA_ExtremeScenario4(Array)
T1=1:1:24; %Time steps
scenario_num=size(Array);
b_array=zeros(1000,24);
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
extreme=zeros(20,24);point=0.0;
range=max(max(b_array));
thresold=range*0.01;
for i=4:scenario_num(1)
    check=length(find((b_array(i,:)<bm)<1));
    avgfluc=0.0;
    for hours=1:23
        avgfluc=avgfluc+abs(b_array(i,hours)-b_array(i,hours+1));    
    end
    avgfluc=avgfluc/23;
    if (check==0 && avgfluc>thresold)
        point=point+1;
        extreme(point,:)=b_array(i,:);
    end
end
plot(T1,extreme,'.-b')
numberset=point
end