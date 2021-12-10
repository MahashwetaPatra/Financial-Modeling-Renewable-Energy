%
% NOTE:    Calls all the assets, and for each assets does the Kolmogorov-Smirnov test 
%          plot the histograms for the KS score in figure 2
%          
%
% HIST:  - 15 Nov, 2021: Created by Patra
%         
%=========================================================================
tic
IntraDayKS=zeros(115,4);
for day= 1:5
    parfor Assetnumber=1:115 %calls all the assets from intraday 1,2,3 & 4
        column=Assetnumber+1;
        if day==5
            Array = readtable('Output/Percentiles/DA/Asset/Percentiles_Scoville_wind.csv');% calls all the assets from a folder
        else
            Array = readtable(strcat('Output/Percentiles/IntraDayNew',num2str(day),'/Asset/Percentiles_Scoville_wind.csv'));% calls all the assets from a folder
        end
        file=Array{:,column};
        [h,p,ksstat,cv]  = kstest(file,[file unifcdf(file,0,100)]);
        IntraDayKS(Assetnumber,:)=[h,p,ksstat,cv] ;
    end  
    figure(2);
    subplot(1,5,day)
    histogram(IntraDayKS(:,3),20)
    %xlim([0,0.3])
    %ylim([0,40])
    if day==5
        title('DA')
    else
        title(strcat('Intra Day',num2str(day)))
    end
end
toc