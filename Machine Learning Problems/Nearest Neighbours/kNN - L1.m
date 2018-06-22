clear all 
close all
clc
%%

load('mnist_data.mat');
rng(25);
test_index=randsample([1:size(test,1)],100);
for K=1:4:13
    for index=1:size(test_index,2)
        Rep_test=repmat(test(test_index(index),2:end),size(train,1),1);
        Sub_matrix=Rep_test-train(:,2:end);
        norm_matrix(:,1)=sqrt(sum(abs(Sub_matrix),2));
        norm_matrix(:,2)=train(:,1);
        sort_matrix=sortrows(norm_matrix);
        unique_k=unique(sort_matrix(1:K,2));
        [val,idx]=(max(histc(sort_matrix(1:K,2),unique_k)));
        Classify_index(index,uint8(K/4)+1)=unique_k(idx);
    end
end

%% Accuracy Check
for K=1:4
    Accuracy(K)=0;
    for index=1:size(test_index,2)
        if(Classify_index(index,K)==test(test_index(index),1))
            Accuracy(K)=Accuracy(K)+1;
        end
    end
end


 