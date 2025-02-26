clc;clear;close all;
I=imread('cliparts.png');
suj=strel('square',10);
subplot(1,3,1)
imshow(I);
title("原图");
subplot(1,3,2)
I1=imerode(I,suj);
imshow(I1)
title("腐蚀图像");
subplot(1,3,3)
edge1=I-I1;
imshow(edge1)
title("边缘");