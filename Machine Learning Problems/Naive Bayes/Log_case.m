close all;
clear all;
clc;
%% Loading the Data
% Train_X=load('DENSE.TRAIN.X_50.txt');
% Train_Y=load('DENSE.TRAIN.Y_50.txt');

% Train_X=load('DENSE.TRAIN.X.1400');
% Train_Y=load('DENSE.TRAIN.Y.1400');

Train_X=load('DENSE.TRAIN.X');
Train_Y=load('DENSE.Y.TRAIN.Y');

Test_X=load('DENSE.TEST.X');
Test_Y=load('DENSE.TEST.Y');

%Tokens=load('TOKENS_LIST');
%% Constants
M = size(Train_X,2); %% Number of Words
o=815;
Train_Size = size(Train_X,1);
Spam_Index = find(Train_Y(:)==1);
Not_Spam_Index = find(Train_Y(:)==-1);
P_y_Spam = length(Spam_Index)/Train_Size;   % Prior Probability (Spam)
P_y_Not_Spam = length(Not_Spam_Index)/Train_Size;   % Prior Proabability (Not Spam)

%% Training
% Computing the Conditional Word Distributions (P(W_j/Y_i=y))
Total_word_count_Spam=0;
for j=1:M
    Sum=0;
    for k=1:length(Spam_Index)
        Sum=Sum+Train_X(Spam_Index(k),j);
    end
    Total_word_count_Spam=Total_word_count_Spam+(1+Sum);
end

Total_word_count_Not_Spam=0;
for j=1:M
    Sum=0;
    for k=1:length(Not_Spam_Index)
        Sum=Sum+Train_X(Not_Spam_Index(k),j);
    end
    Total_word_count_Not_Spam=Total_word_count_Not_Spam+(1+Sum);
end


for j=1:M
    Sum=0;
    for k=1:length(Spam_Index)
        Sum=Sum+Train_X(Spam_Index(k),j);
    end
    P_w_y_Spam(j)=log((1+Sum)/Total_word_count_Spam);
end

for j=1:M
    Sum=0;
    for k=1:length(Not_Spam_Index)
        Sum=Sum+Train_X(Not_Spam_Index(k),j);
    end
    P_w_y_Not_Spam(j)=log((1+Sum)/Total_word_count_Not_Spam);
end

%% Testing
for i=1:size(Test_X,1)
    P_di_y_Spam(i)=0;
    for j=1:M
        P_di_y_Spam(i)=P_di_y_Spam(i)+(P_w_y_Spam(j)*Test_X(i,j));
    end
end

for i=1:size(Test_X,1)
    P_di_y_Not_Spam(i)=0;
    for j=1:M
        P_di_y_Not_Spam(i)=P_di_y_Not_Spam(i)+(P_w_y_Not_Spam(j)*Test_X(i,j));
    end
end

for i=1:size(Test_X,1)
%     P_y_1_di(i)=P_di_y_Spam(i)/(P_di_y_Spam(i)+P_di_y_Not_Spam(i));
%     P_y_0_di(i)=P_di_y_Not_Spam(i)/(P_di_y_Spam(i)+P_di_y_Not_Spam(i));
if (P_di_y_Spam(i)>=P_di_y_Not_Spam(i))
    Result(i)=+1;
else
    Result(i)=-1;
end
end

Acc=length(find(Test_Y'-Result==0));
Err=(800-Acc)*100/800;
