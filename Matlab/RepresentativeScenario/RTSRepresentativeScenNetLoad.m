%
% NOTE:    Calls an asset, from a day and for that assets
%          calculates representative scenarios. The histogram from all scenarios 
%          and representative scenarios at different hours are compared and it matches well
% HIST:  - 12 Sep, 2021: Created by Patra
%          17th sep cleared and Added more notes to it
%          9th dec: the histogram from all scenarios and representative scenarios 
%          at different hours are compared and it matches well
%=========================================================================

function RTSRepresentativeScenNetLoad=RTSRepresentativeScenNetLoad(FileDir, RepScenario, PF, hours, Month)
[GenIdx, ExtLoad, CurIdx, GenCost, LoadShed, Curtailment,MaxGen]=RTSDailySummaryFunction(Month);

%% Plot the distribution of the vatic output
%HistogramVaticoutput=HistogramVaticoutput(GenCost, LoadShed, Curtailment);

%%get the data in array for particular asset and date
T=1:1:24;%Time steps
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
b_array=b_array1-b_array2-b_array3;
%% plots the scenarios
%Scenarios=PlotScenarios(T, b_array)

%% uses the k-means algorithm
xinit=b_array(1:RepScenario,:); % initialization for the K-means algorithm
[index, Centriod] = kmeans(b_array,RepScenario,'MaxIter',20000,'Start',xinit);
[KmeansIndex,~] = knnsearch(b_array,Centriod,'K',1);

%% Calculates the PCA factors
[coefficient,score]=pca(b_array);

%% calculates the K-means on the PCA four factors
x=[];xinit=[];
for i=1:PF
x= [x, score(:,i)];%, score(:,2), score(:,3),score(:,4)];%size(x)
xinit=[xinit, score(1:RepScenario,i)];%, score(1:RepScenario,2), score(1:RepScenario,3), score(1:RepScenario,4)];
end
[~, CentriodPCA] = kmeans(x,RepScenario,'MaxIter',20000, 'Start',xinit);
[PCAKmeansIndex,~] = knnsearch(x,CentriodPCA,'K',1);

%% Plots the distribution of generation cost for representative scenarios
%CDFPlot(GenCost, RepScenario, KmeansIndex, PCAKmeansIndex);
[~, ~, k1]=kstest2(GenCost, GenCost(1:RepScenario));
[~, ~, k2]=kstest2(GenCost, GenCost(KmeansIndex));
[~, ~, k3]=kstest2(GenCost, GenCost(PCAKmeansIndex));
%legend('GenCost',strcat('Subsampling,','K-S score: ',num2str(k1)),strcat('K-means,','K-S score: ',num2str(k2)),strcat('PCA+Kmeans,','K-S score: ',num2str(k3)),'Location','southeast')
KStest=[k1, k2, k3];

RTSRepresentativeScenNetLoad=KStest;
%% Net load vs Gen Cost
%ScatterPlot=ScatterPlot(b_array, GenCost, KmeansIndex, PCAKmeansIndex);

end