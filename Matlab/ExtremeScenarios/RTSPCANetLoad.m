%
% NOTE:    Run the core PCA analysis on RTS Net Load scenarios
%          From the high PC1 component, vatic output, i.e. high generation cost,
%          Load shedding are predicted
% HIST:  - 20 Mar, 2022: Created by Patra
%=========================================================================  
function Probability=RTSPCANetLoad(FileDir, RepScenario, Month)
Time=1:1:24;% Time steps
%% Vatic Output
[GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen,l]=RTSDailySummaryFunction(Month);
[MaxCurt, CurtIdx]=sort(Curtailment);
[MaxLoad, LoadIdx]=sort(LoadShed);
[MaxGen, GenIdx]=sort(GenCost);
avggencost=mean(GenCost);
avgcurt=mean(Curtailment);

%% Plot the distribution of the vatic output
%HistogramVaticoutput(GenCost, LoadShed, Curtailment);

%% Input scenarios
Array1 = readtable(strcat(FileDir,Month,"\\LoadScenariosAggregated.csv"), 'VariableNamingRule','preserve'); 
Array2 = readtable(strcat(FileDir,Month,"\\WindScenariosAggregated.csv"), 'VariableNamingRule','preserve'); 
Array3 = readtable(strcat(FileDir,Month,"\\SolarScenariosAggregated.csv"), 'VariableNamingRule','preserve'); 
SizeScenario=size(Array1);

b_array1=zeros(1000,24);
b_array2=zeros(1000,24);
b_array3=zeros(1000,24);

for k=1:SizeScenario(1)
    b1=zeros(24,1);
    col1 = Array1(k,:);
    b2=zeros(24,1);
    col2 = Array2(k,:);
    b3=zeros(24,1);
    col3 = Array3(k,:);
    for i=1:24% put the asset in a array
        j=i;
        b1(i)=col1{1,j};
        b_array1(k,i)=b1(i);
        b2(i)=col2{1,j};
        b_array2(k,i)=b2(i);
        b3(i)=col3{1,j};
        b_array3(k,i)=b3(i);
    end
end
NetLoad=b_array1-b_array2-b_array3;
[coeff,score]=pca(NetLoad);
%PlotPCA=PCAPlot(Time,coeff,score, CurtIdx);

[ExtPC, index]=sort(score(:,1));
Ext=index(1:RepScenario);
Ext2=index(1000-RepScenario:1000);

%a1=find(abs(score(:,2))<10);
%a2=find(abs(score(:,3))<10);
%IdxCommon=[index(950:1000);a2];

A=GenCost(Ext2);
B=MaxGen(1000-length(Ext2):1000);
PGenCost=length(intersect(A,B))/length(Ext2);

Acurt=Curtailment(Ext);
Bcurt=MaxCurt(1000-RepScenario:1000);
PCurt=length(intersect(Acurt,Bcurt))/RepScenario;

[MaxLoad, LoadIdx]=sort(LoadShed);
A=LoadShed(index(1000-RepScenario:1000));
B=MaxLoad(1000-RepScenario:1000);
PLoadShed=length(intersect(A,B))/RepScenario;

LoadShedExt=LoadShed(index(1000-RepScenario:1000));
ln=find(LoadShedExt>0);
l2=length(ln);
commonLoadShed=l2/RepScenario;
%PCAVaticPlot(score,Curtailment,CurtIdx,MaxCurt, GenCost,GenIdx, MaxGen, Ext, Ext2,LoadShed, LoadShedExt);
[Probability]=[PGenCost PCurt PLoadShed commonLoadShed];
end