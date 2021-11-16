%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test 
%          plot the histograms for the KS score in figure 2
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%         
%=========================================================================

function IntraDayKSAll=KSScoreValuesWind;
IntraDayKS=[]; IntraDayKS2=[];IntraDayKS3=[]; IntraDayKS4=[];
for Assetnumber=1:115 %calls all the assets from intraday 1,2,3 & 4
    column=Assetnumber+1;
    Array = readtable('Output/Percentiles/IntraDayNew1/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS=[IntraDayKS;h p ksstat cv];
    
    Array = readtable('Output/Percentiles/IntraDayNew2/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS2=[IntraDayKS2;h p ksstat cv];

    Array = readtable('Output/Percentiles/IntraDayNew3/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS3=[IntraDayKS3;h p ksstat cv];

    Array = readtable('Output/Percentiles/IntraDayNew4/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
    file=Array{:,column};
    [h,p,ksstat,cv] = kstest(file,[file unifcdf(file,0,100)]);
    IntraDayKS4=[IntraDayKS4;h p ksstat cv];

end

IntraDayKSAll=[IntraDayKS(:,3) IntraDayKS2(:,3) IntraDayKS3(:,3) IntraDayKS4(:,3)];
figure(2);
subplot(2,2,1)
histogram(IntraDayKS(:,3),20)
xlim([0,0.3])
ylim([0,40])
title('Intra Day 1')

subplot(2,2,2)
histogram(IntraDayKS2(:,3),20)
xlim([0,0.3])
ylim([0,40])
title('Intra Day 2')

subplot(2,2,3)
histogram(IntraDayKS3(:,3),20)
xlim([0,0.3])
ylim([0,40])
title('Intra Day 3')

subplot(2,2,4)
histogram(IntraDayKS4(:,3),20)
xlim([0,0.3])
ylim([0,40])
title('Intra Day 4')

end