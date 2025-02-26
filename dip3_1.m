I = imread("homework5-1.jpg");
subplot(2,3,1)
% imshow(I)
I1 = imfilter(I,fspecial('average',3));
imshow(I1);title("3*3算术均值滤波器");

subplot(2,3,2)
I2= imfilter(I,fspecial('average',5));
imshow(I2);title("5*5算术均值滤波器");

subplot(2,3,3)
I3= imfilter(I,fspecial('average',9));
imshow(I3);title("9*9算术均值滤波器");

subplot(2,3,4)
I4 = geometry_fspecial(I,3,3);
imshow(I4);title("3*3几何均值滤波器")

subplot(2,3,5)
I5 = geometry_fspecial(I,5,5);
imshow(I5);title("5*5几何均值滤波器")

subplot(2,3,6)
I6 = geometry_fspecial(I,9,9);
imshow(I6);title("9*9几何均值滤波器")

function im2 = geometry_fspecial(im,m,n)
%几何均值滤波
% 输入:
%           x：输入二维图像矩阵
%           m,n：滤波掩膜尺寸
% 输出：
%           im2：输出图像矩阵，数据类型与输入相同

    if ~isa(im,'double')
        im1 = double(im)/255;
    else 
        im1 = im;
    end
    im2 = exp( imfilter(log(im1),ones(m,n),'replicate') ).^(1/m/n); % 几何均值滤波
    im2 = im2uint8(im2);   % 数据类型转换 
end