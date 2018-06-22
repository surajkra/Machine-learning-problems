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
    for i=1:m
        for j=1:n
            if (i==1 || j==1 || i==m || j==n)   % Identifying the image border
                if((i==1 && j==1) || (i==m && j==n) || (i==m && j==1) || (i==1 && j==n))    % Identifying the corners
                    if(i==1 && j==1)
                        SS_N=sum(sum(whouse(i:i+1,j:j+1).^2));
                    elseif(i==m && j==n)
                        SS_N=sum(sum(whouse(i-1:i,j-1:j).^2));
                    elseif(i==m && j==1)
                        SS_N=sum(sum(whouse(i-1:i,j:j+1).^2));                        
                    else
                        SS_N=sum(sum(whouse(i:i+1,j-1:j).^2));
                    end
                    X_cap(i,j,k)=(max(0,(SS_N/4)-150)/(SS_N/4))*whouse(i,j,k);
                else                                % Identifying edges
                    if(j==1)
                        SS_N=sum(sum(whouse(i-1:i+1,j:j+1).^2));
                    elseif(i==1)
                        SS_N=sum(sum(whouse(i:i+1,j-1:j+1).^2));
                    elseif(i==m)
                        SS_N=sum(sum(whouse(i-1:i,j-1:j+1).^2));
                    else
                        SS_N=sum(sum(whouse(i-1:i+1,j-1:j).^2));
                    end                        
                    X_cap(i,j,k)=(max(0,(SS_N/6)-150)/(SS_N/6))*whouse(i,j,k);
                end
            else
                SS_N=sum(sum(whouse(i-1:i+1,j-1:j+1).^2)); % Any other point inside the image
                X_cap(i,j,k)=(max((SS_N/9)-150)/(SS_N/9))*whouse(i,j,k);
            end
        end
    end
end

for k=1:3
    denoised_house(:,:,k)=w3i(X_cap(:,:,k));
end

figure();
subplot(1,2,1);imshow(nhouse/255);title('Noisy Image');
subplot(1,2,2);imshow(denoised_house/255);title('Denoised Image');
