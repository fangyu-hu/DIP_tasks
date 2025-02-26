I = imread('imgtest.bmp');
subplot(1,3,1)
imshow(I);title('原图')
F = fft2(I); %傅立叶变换
S = abs(I); %取傅立叶变换的频谱
Fc = fftshift(F); %将傅立叶变换的中心移至频谱的中心位置
subplot(1,3,2);
imshow(abs(Fc),[]); title('傅里叶变换频谱')%显示居中之后的频谱
S2 = log(1+abs(Fc)); %使用对数增强居中后的频谱
subplot(1,3,3)
imshow(S2,[]);title('对数增强频谱')

