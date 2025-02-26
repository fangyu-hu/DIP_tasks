clear
clc
close all
 
img = imread('Fig0637(a).tif');
subplot(1,3,1);imshow(img);title('RGB');
 
I = rgb2hsv(img);  % 将RGB图像转换为HSV空间
I_eq = histeq(I(:,:,3));  % 对I通道进行均衡化处理
 
S_adjusted = I(:,:,2) * 1.5;  % 增加饱和度分量，可以调整倍数
S_adjusted(S_adjusted > 1) = 1;  % 确保饱和度在合理范围内（0到1之间）
I(:,:,2) = S_adjusted;  % 将调整后的饱和度分量赋值给原始图像的饱和度通道
 
processed_image = hsv2rgb(I);  % 将HSV图像转换回RGB空间
subplot(1, 3, 2); imshow(I_eq); title('I通道均衡化');
subplot(1, 3, 3); imshow(processed_image); title('增加饱和度');