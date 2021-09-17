function [coeff,sum_explained]=latent(Array)
%T1=1:1:24;%Time steps
b_array=[];
for k=3:1000%Reading all the scenarios and putting in arrays
    b=[];
    col = Array(k,:);
    for i=1:24
        j=i+2;
        b=[b;col{1,j}];
    end
    for i=1:24
        b_array(k,i)=b(i);
    end
end
size(b_array);% bm is the final array of all scenarios
bm=mean(b_array);%calculating the mean of the scenarios
[coeff,score,latent, tsquared, explained]=pca(b_array);%doing the principal component analysis 
coeff(:,1);
cumsum(explained);
sum_explained=explained(1)+explained(2)+explained(3)+explained(4);
col1 = Array(1, :); %Data of the Actuals
col2 = Array(2,:); % Data of the Forecast
b=[];
for i=1:24
    j=i+2;
    b=[b;col1{1,j}];
end
b=[];
for i=1:24
    j=i+2;
    b=[b;col2{1,j}];
end
end