clear all;
close all;
clc;
%% 
load('nhouse.mat');
m=size(nhouse,1);
n=size(nhouse,2);
for k=1:3
    whouse(:,:,k)=w3t(nhouse(:,:,k));
end
for k=1:3
    for i=2:m-1
        for j=2:n-1
                SS_N=sum(sum(whouse(i-1:i+1,j-1:j+1).^2)); % Any other point inside the image
                X_cap(i,j,k)=(max((SS_N/9)-150)/(SS_N/9))*whouse(i,j,k);
        end
    end
end
X_cap(512,:,:)=X_cap(511,:,:);
X_cap(:,512,:)=X_cap(:,511,:);
for k=1:3
    denoised_house(:,:,k)=w3i(X_cap(:,:,k));
end

figure();
subplot(1,2,1);imshow(nhouse/255);title('Noisy Image');
subplot(1,2,2);imshow(denoised_house/255);title('Denoised Image');
