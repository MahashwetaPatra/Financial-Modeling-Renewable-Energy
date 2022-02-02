%
% NOTE: This is for calculating the extreme scenarios for wind data
%
% HIST:  - 27 Sep, 2021: Created by Patra
%=========================================================================
function PCA_ExtremeScenarioWind =PCA_ExtremeScenarioWind(Array)
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
bm=mean(b_array);% calculating the mean of all the scenarios
extreme=[];point=0.0;
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
        extreme=[extreme;b_array(i,:)];
    end
end
PCA_ExtremeScenarioWind=point;
end
