function [ S ] = pinvs( s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
m=size(s,1);
n=size(s,2);
S=zeros(n,m);

for i=1:m
    for j=1:n
        if(s(i,j)~=0)
            S(i,j)=1/s(i,j);
        end
    end
end       
end
