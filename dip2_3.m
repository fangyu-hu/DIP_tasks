I=imread('Fig0459(a)(orig_chest_xray).tif');
subplot(1,3,1);imshow(I);title('原图');
%空域增强
w8=[1 1 1;1 -8 1;1 1 1] %对角线掩膜
I1=imfilter(I,w8,'replicate');
img_out1=I-I1;
subplot(1,3,2);imshow(img_out1);title('空域增强');

%频域增强
s=fftshift(fft2(im2double(I)));
[a,b]=size(s);
d0=10; % 高斯高通滤波器的截止频率D0设置为10
a0=round(a/2);
b0=round(b/2);
for i=1:a
    for j=1:b
        distance=sqrt((i-a0)^2+(j-b0)^2);    % 高斯高通滤波器公式H(u,v)=e^-[D^2(u,v)/2*D0^2] 
        h=1-(exp(-(distance^2)/(2*(d0^2)))); % exp表示以e为底的指数函数
        s(i,j)=h*s(i,j);% 频域图像乘滤波器的系数
    end
end

s=real(ifft2(ifftshift(s)));% 最后进行二维傅里叶反变换转换为时域图像
subplot(1,3,3),imshow(s,[]); 
title('高斯高通滤波');