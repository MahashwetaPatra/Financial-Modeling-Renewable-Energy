function coefficient1=coefficient1(Array)
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
[coeff]=pca(b_array);%doing the principal component analysis 
coefficient1=coeff;
end