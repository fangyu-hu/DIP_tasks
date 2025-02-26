clc;clear;close all;
J=imread('Fig0918(a).tif');
subplot(3,2,1)
imshow(J);
title("原图");
I=im2bw(J,0.8) 
subplot(3,2,2)
imshow(I);
title("分割图");

se=strel('disk',1);
O=imopen(I, se);

se=strel('disk',8);
C=imclose(O, se);
subplot(3,2,3);
imshow(C);
title('形态学去噪') ;

% 连通分量分析
[labeledImage, numLabels] = bwlabel(C, 8);
% 获取连通分量的面积信息
stats = regionprops(labeledImage, 'Area');
% 去除面积小于200的连通分量
for i = 1:numLabels
if stats(i).Area < 200
labeledImage(labeledImage == i) = 0;
end
end
subplot(3,2,4);
imshow(labeledImage);
title('通道分量提取') ;
% 利用伪彩色图像处理技术显示
coloredLabels = label2rgb(labeledImage, 'jet', 'k', 'shuffle');
subplot(3,2,5);
imshow(coloredLabels);
title('伪彩色处理') ;