close all;
clear all;
clc;
%% Loading Data
DataSet=csvread('diabetes_scale.csv');
Train_Data=DataSet(1:500,2:end);
Train_Labels=DataSet(1:500,1);
Test_Data=DataSet(501:768,2:end);
Test_Labels=DataSet(501:768,1);
%% Soft - Margin SVM
count=0;
SVMModel=cell(20,1);
cross_model=cell(20,1);
rng(42);
for C=0.1:0.1:2
    count=count+1;
    C_Value(count)=C;
    SVMModel{count} = fitcsvm(Train_Data,Train_Labels,'KernelFunction','linear',...
        'KernelScale',1,'BoxConstraint',C,'KFold',5);
    cross_error(count)=kfoldLoss(SVMModel{count});
end
index=find(cross_error==min(cross_error),1);
Best_Model=SVMModel{index};
Best_C=C_Value(index);

Final_SVMModel = fitcsvm(Train_Data,Train_Labels,'KernelFunction','linear',...
    'KernelScale',1,'BoxConstraint',Best_C);

Soft_Test_predict=predict(Final_SVMModel,Test_Data);
Soft_Correct_predict=length(find(Soft_Test_predict==Test_Labels));
Soft_Accuracy=Soft_Correct_predict*100/268;
%% Hard - Margin SVM
%Hard_SVM = fitcsvm(Train_Data,Train_Labels,'Standardize',true,'KernelFunction','linear',...
%    'KernelScale',1,'BoxConstraint',1e6);
Hard_SVM = fitcsvm(Train_Data,Train_Labels,'KernelFunction','linear',...
    'KernelScale',1,'BoxConstraint',1e6);

Hard_Test_predict=predict(Hard_SVM,Test_Data);
Hard_Correct_predict=length(find(Hard_Test_predict==Test_Labels));
Hard_Accuracy=Hard_Correct_predict*100/268;
