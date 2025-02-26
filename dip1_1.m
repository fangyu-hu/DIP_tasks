I = imread('Fig3.10(b).jpg');
figure(1)
subplot(2,2,1)
imshow(I)
%均衡化增强
I1 = histeq(I)
subplot(2,2,2)
imshow(I1)
%灰度变换
I2 = imadjust(I,[0 1],[1 0]);
subplot(2,2,3)
imshow(I2)
%锐化空域滤波（拉普拉斯增强）
% w=fspecial('laplacian',0.2)
w = [-1,-1,-1;-1,8,-1;-1,-1,-1]
i = imfilter(I,w,'replicate')
I3 = I+i;
subplot(2,2,4)
imshow(I3)

