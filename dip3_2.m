I=imread("Fig0507(a)(ckt-board-orig).tif");
subplot(3,3,1)
imshow(I);title("原图");
subplot(3,3,2)
I1=imnoise(I,'salt & pepper',0.25);
imshow(I1);title("添加椒盐噪声");
subplot(3,3,3)
I2=imnoise(I1,"gaussian");
imshow(I2);title("添加椒盐和高斯噪声");
subplot(3,3,4)
I3=medfilt2(I1,[5,5]);
imshow(I3);title("5*5中值滤波");
subplot(3,3,5)
I4=adapmedian_filter(I1,3);
imshow(I4);title("自适应中值滤波");
subplot(3,3,6)
I5 = Alpha_filter(I2);
imshow(I5);title("阿尔法修正滤波");
subplot(3,3,7)
I6 = imfilter(I2,fspecial('average',5));
imshow(I6);title("算术均值滤波");
subplot(3,3,8)
I7 = geometry_fspecial(I2,3,3); 
imshow(I7);title("几何均值滤波");
subplot(3,3,9)
I7 = wiener2(I2,[5,5]);
imshow(I7);title("维纳滤波");


function Z = adapmedian_filter(X, Smax)
% 函数对输入图像进行邻域窗口大小可变的自适应中值滤波
%  函数输入
%        X：输入二维图像矩阵
%        smax：中值滤波邻域窗口的最大值，必须是大于1的奇数
%  函数输出
%        Z：输出图像矩阵，数据类型与输入相同，smax必须是大于1的奇数
if (Smax<=1) | (Smax/2 == round(Smax/2)) | (Smax ~= round(Smax))
    error('smax必须是大于1的奇数')
end
if size(X,3)~=1
    error('图像应为二维矩阵')
end
if ~isa(X,'double')
    X = double(X)/255;  % 数据类型 
end
[M, N] = size(X);
% 初始化
Z = X;  Z(:)=0;
LevelA = false(size(X));   % 初始化，同X的 全0逻辑矩阵
% 开始滤波
for k=3:2:Smax
    Zmin = ordfilt2(X,1,ones(k,k),'symmetric' );   % 排序滤波
    Zmax = ordfilt2(X,k*k,ones(k,k), 'symmetric'); % 排序滤波
    Zmed = medfilt2(X,[k,k], 'symmetric');         % 中值滤波
    % 判断是否进入B层
    LevelB = (Zmed>Zmin)&(Zmax>Zmed)&LevelA;  % 判断A层
    ZB = (X > Zmin) & (Zmax > X);
    outputZxy = LevelB & ZB;    % 交运算
    outputZmed = LevelB & ~ZB;  % 交运算
    Z(outputZxy) = X(outputZxy);            % 赋值
    Z(outputZmed) = Zmed(outputZmed);       % 赋值
    LevelA = LevelA  | LevelB; % 非运算
    if all(LevelA(:))
        break;
    end
end
Z(~LevelA) = Zmed(~LevelA); % 赋值
Z = im2uint8(Z);  % 类型转化
end

function Y = Alpha_filter(im1)
    d=3;                                      %滤波模板大小，d=3,5,7......
    r=floor(d/2);                             %图像需要填充的大小
    im2 = padarray(im1,[r,r],'symmetric');    %对原图像进行扩充，使得图像边界像素能够得到处理
    [m,n]=size(im2);   
    im3=zeros(size(m,n));
    d2=3;                                      %去除最大最小值的个数
    for i=r+1:m-r
        for j=r+1:n-r
            h=double(im2(i-r:i+r,j-r:j+r));
            h1=reshape(h,[1,d^2]);         %将h矩阵中的数重新排列为一维矩阵
            h2=sort(h1,'ascend');          %对矩阵h1进行升序排列，即从小到大排列
            h3=h2(1,d2+1:d^2-d2);          %去除部分最大最小值后的矩阵
            im3(i,j)=sum(sum(h3))/(d^2-2*d2) ;       %修正阿尔法均值滤波
        end
    end
    im3=im3(r+1:m-r,r+1:n-r);
    im3=uint8(im3);
   Y=im3;
end

function X = geometry_fspecial(im,m,n)
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
    X = exp( imfilter(log(im1),ones(m,n),'replicate') ).^(1/m/n); % 几何均值滤波
    X = im2uint8(X);   % 数据类型转换 
end
