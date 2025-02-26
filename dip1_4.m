F40=imread('Fig3.40(a).jpg');
F10=imread('Fig10.10(a).jpg');
figure(1)
subplot(1,2,1);imshow(F40);
subplot(1,2,2);imshow(F10);

w4=fspecial('laplacian',0);
w8=[1 1 1;1 -8 1;1 1 1] %对角线掩膜

figure(2);
img_f10=imfilter(F10,w4,'replicate');
img_f40=imfilter(F40,w4,'replicate');
img_out10=F10-img_f10;
img_out40=F40-img_f40;
subplot(2,2,1);imshow(img_out40);title('图3.40非对角线掩膜');
subplot(2,2,2);imshow(img_out10);title('图10.10非对角线掩膜');

img_F10=imfilter(F10,w8,'replicate');
img_F40=imfilter(F40,w8,'replicate');
img_out11=F10-img_F10;
img_out41=F40-img_F40;
subplot(2,2,3);imshow(img_out41);title('图3.40对角线掩膜');
subplot(2,2,4);imshow(img_out11);title('图10.10对角线掩膜');
