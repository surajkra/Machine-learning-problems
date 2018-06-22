clear all;
close all;
clc;

%%  Loading Datasets
Train_Data=load('train_features.dat');
Train_Labels=load('train_labels.dat');
Test_Data=load('test_features.dat');
Test_Labels=load('test_labels.dat');

%% Adding the Intercept term
Train_Data_I=zeros(size(Train_Data,1),3);
Train_Data_I(:,1)=1;
Train_Data_I(:,2)=Train_Data(:,1);
Train_Data_I(:,3)=Train_Data(:,2);
Train_Data_I=Train_Data_I';

Test_Data_I=zeros(size(Test_Data,1),3);
Test_Data_I(:,1)=1;
Test_Data_I(:,2)=Test_Data(:,1);
Test_Data_I(:,3)=Test_Data(:,2);
Test_Data_I=Test_Data_I';

X=Train_Data_I;
Y=Train_Labels;
%% Determining Initial Conditions.
W(:,1)=[0 0 0]';
for i=1:size(Train_Labels,1)
    HX(i)=h_x(X(:,i),W(:,1));
end
HX=HX';
L_W(1) = l_w(Y,HX);
W(:,2) = W(:,1)-inv(Hessian_Comp(X,HX))*Grad_Comp(X,HX,Y);
%W(:,2)=[-2 1.7 -0.5]';
for i=1:size(Train_Labels,1)
    HX(i)=h_x(X(:,i),W(:,2));
end
L_W(2) = l_w(Y,HX);
%% Iterations
count=2;
while(abs(L_W(count)-L_W(count-1))>10^(-8))
    W(:,count+1) = W(:,count)-inv(Hessian_Comp(X,HX))*Grad_Comp(X,HX,Y);
    for i=1:size(Train_Labels,1)
        HX(i)=h_x(X(:,i),W(:,count+1));
    end
    L_W(count+1) = l_w(Y,HX);
    count=count+1;
end    
%% Predictions
W_Final=W(:,count);    
for i =1:size(X,2)
    P(i)=1/exp(-1*W_Final'*X(:,i));  
    if(P(i)>=0.5)
        P(i)=1;
    else
        P(i)=0;
    end
end

for j=1:size(W,2)
    for i=1:size(Test_Labels,1)
        HX(i)=h_x(Test_Data_I(:,i),W(:,j));
    end    
    HX=HX';
    L_W_test(j) = l_w(Test_Labels,HX);
end
for i =1:size(Test_Data_I,2)
    P_test(i)=1/exp(-1*W_Final'*Test_Data_I(:,i));  
    if(P_test(i)>=0.5)
        P_test(i)=1;
    else
        P_test(i)=0;
    end
end
accuracy_train=length(find(Y==P'))/900;
accuracy_test=length(find(Test_Labels==P_test'))/100;

figure();
plot(L_W/900);hold on;
plot(L_W_test/100); title('Normalized Training & Testing Error Plots');
legend('Training Error','Test Error');
xlabel('# Iterations');
ylabel('Error');

figure();
plot(L_W);hold on;
plot(L_W_test); title('Training & Testing Error Plots');
legend('Training Error','Test Error');
xlabel('# Iterations');
ylabel('Error');


