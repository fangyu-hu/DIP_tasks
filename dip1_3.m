Im=imread('Fig3.37(a).jpg')
figure(1)
subplot(1,3,1)
imshow(Im);title('原图')
%中值滤波
I1 = medfilt2(Im,[3 3]);
subplot(1,3,2);
imshow(I1);title('中值滤波');
%高斯平滑滤波
w=fspecial('gaussian')
I2=imfilter(Im,w)
subplot(1,3,3);
imshow(I2);title('高斯平滑滤波');