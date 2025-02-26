clear
clc
close all
 
img = imread('Fig0637(a).tif');
subplot(2,3,1);imshow(img);title('RGB');
 
img = im2double(img);
 
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
 
imgsize = size(img);
row = imgsize(1);
column = imgsize(2);
 
 
for i=1:1:row
 for j=1:1:column
    maxMatrix(i,j) = max(max(R(i,j),G(i,j)),B(i,j));
    minMatrix(i,j) = min(min(R(i,j),G(i,j)),B(i,j));
 end
end
 
V = maxMatrix;
 
for i=1:1:row
 for j=1:1:column
    if V(i,j) == 0
         S(i,j) = 0;
    else
         S(i,j) = (maxMatrix(i,j)- minMatrix(i,j)) / maxMatrix(i,j);
    end
 end
end
SV = cat(2,S,V);
J=histeq(V);
subplot(2,3,2);imshow(SV);title('不用rbg2hsv的V image');
subplot(2,3,3);imhist(V);title('直方图');
subplot(2,3,4);imshow(J);title('均衡化');
subplot(2,3,5);imhist(J);title('均衡化后直方图');