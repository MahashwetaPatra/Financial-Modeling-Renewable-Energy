%
% NOTE: Calls all assets for a date and illustrating the 
% actual (blue), superimposed with the 6-hour Intraday forecasts (red)
% + scenario means+95$\%$ bands (orange)
%
% HIST:  - 2nd Dec, 2021: Created by Patra
%         
%=========================================================================
tic
%function IllustrationIDAll=IllustrationIDAll(year, assettype)
files = dir('Scovilleriskpartners/CSV/IntraDay1/SimDat_20170101/wind/*.csv');
s=length(files);
year=20171212;
%file=dir(strcat('Scovilleriskpartners/CSV/IntraDay1/SimDat_',num2str(year),'/',assettype,'/.*csv'));
assetall=zeros(1003,6,s);
for day=1:4
    T1=1+6*(day-1);T2=T1+5;T=T1:1:T2;
    parfor asset=1:s
        files = dir(strcat('Scovilleriskpartners/CSV/IntraDay1/SimDat_',num2str(year),'/wind/*.csv'));
        filename=files(asset).name;%give the column number for the particular asset 
        name=strcat('Scovilleriskpartners/CSV/Intraday',num2str(day),'/SimDat_',num2str(year),'/wind/',filename);
        Array = readtable(name);%getting the DA scenarios
        for k=2:1003
            b=zeros(6,1);
            col = Array(k,:);
            for i=1:6% put the asset in a array
                j=i+2;
                b(i,1)=col{1,j};
                assetall(k,i,asset)=b(i,1);
            end    
        end
    end
    sum2=assetall(:,:,1);
    parfor i=2:s
        all=assetall(:,:,i);
        size(all);
        sum2=sum2+all;
    end
    Array=sum2;
    size(Array);
    forcastArray =Array(3,:);actualArray=Array(2,:);
    SizeScenario=size(Array);
    b_array=Array(4:1003,:);
    bm=mean(b_array);% calculating the mean of all the scenarios
    LowerBound=zeros(6,1);UpperBound=zeros(6,1);
    parfor k=1:6
        sizecolumn=sort(b_array(:,k));
        LowerBound(k)=sizecolumn(25);
        UpperBound(k)=sizecolumn(975);
    end
    %IllustrationIDAll=
    figure(1);
    plot(T,forcastArray, '-r','LineWidth',1)   
    hold on;
    plot(T,actualArray, '-b','LineWidth',1) 
    hold on;
    x2 = [T, fliplr(T)];
    figure(1)
    xlabel('Time (hours)'); 
    ylabel('Energy (MW)'); 
    set(gca, 'GridLineStyle', ':') %dotted grid lines
    set(gca,'FontSize',18,'LineWidth',1.5)
    fill(x2, [bm, fliplr(UpperBound')], 0.6 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
    fill(x2, [bm, fliplr(LowerBound')], 0.6 * ones(1, 3), 'linestyle', 'none', 'facealpha', 0.4);
end
%end
toc
