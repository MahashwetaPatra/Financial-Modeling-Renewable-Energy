function PCA_Aggregated=PCA_Aggregated(sizeZones,ZoneName,ZoneType)
b_array=zeros(1003,24);sum_array=0;coeff_matrix=[];
T1=1:1:24;%Time steps
for p=1:sizeZones
    Array = readtable(ZoneName(p).name);
    parfor k=3:1000
        b=zeros(24,1);
        col = Array(k,:);
        hold on; 
        for i=1:24% put the asset in a array
            j=i+2;
            b(i)=col{1,j};
            b_array(k,i)=b(i);
        end
    end
    [coeff]=pca(b_array);
    coeff_matrix=[coeff_matrix,coeff(:,1)];  
    sum_array=sum_array+b_array;
end
[coeff]=pca(sum_array);
figure
plot(T1,coeff(:,1),'.-black','markersize',20)%plotting the 1st PCA factor for the sum of the assets in a zone
xlabel('Time (hours)')
ylabel('coeff')
hold on;
plot(T1,coeff_matrix,'-b','markersize',5)%plotting the 1st PCA factor for individual assets
title(ZoneType)
end
