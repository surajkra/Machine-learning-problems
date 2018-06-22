Code Written in Matlab - Suraj Kiran Raman

%% Loading Data
DataSet=csvread('diabetes_scale.csv');
Train_Data=DataSet(1:500,2:end);
Train_Labels=DataSet(1:500,1);
Test_Data=DataSet(501:768,2:end);
Test_Labels=DataSet(501:768,1);

%% Hard - Margin SVM
Hard_SVM = fitcsvm(Train_Data,Train_Labels,'KernelFunction','linear',...
    'KernelScale',1,'BoxConstraint',1e6);

Hard_Test_predict=predict(Hard_SVM,Test_Data);
Hard_Correct_predict=length(find(Hard_Test_predict==Test_Labels));
Hard_Accuracy=Hard_Correct_predict*100/268;
