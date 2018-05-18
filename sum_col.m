function [ somme ] = sum_col( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

somme = [1:size(img,2)];
for i=1:size(img,2)
    somme(i) = sum(img(:,i))/size(img,1);
end

end

