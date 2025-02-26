
originalImage = imread('Fig0637(a).tif');
 
redComponent = originalImage(:,:,1);
greenComponent = originalImage(:,:,2);
blueComponent = originalImage(:,:,3);
 
% 显示R、G、B分量的灰度图像
figure;
 
subplot(2, 2, 1);
imshow(redComponent);
title('红色分量灰度图');
 
subplot(2, 2, 2);
imshow(greenComponent);
title('绿色分量灰度图');
 
subplot(2, 2, 3);
imshow(blueComponent);
title('蓝色分量灰度图');
 
% 显示原始图像的灰度图
grayImage = rgb2gray(originalImage);
 
subplot(2, 2, 4);
imshow(grayImage);
title('原始图像灰度图');