function PCA_Aggregated=PCA_Aggregated(sizeZones,ZoneName,ZoneType)
Matrix=[];b_array=[];sum_array=0;coeff_matrix=[];
T1=1:1:24;%Time steps
for p=1:sizeZones
    Array = readtable(ZoneName(p).name);
    for k=3:1000
        a=[];b=[];
        col = Array(k,:);
        hold on; 
        for i=1:24% put the asset in a array
            j=i+2;
            a=[a;T1(i)];
            b=[b;col{1,j}];
        end
        for i=1:24
            a_array(k,i)=a(i);
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