I=imread("noiselena.jpg");
subplot(1,2,1);
imshow(I);title("原图")
I1=Alpha_filter(I)
subplot(1,2,2);
imshow(I1);title("阿尔法修正滤波");

function Y = Alpha_filter(im1)
    d=3;                                      %滤波模板大小，d=3,5,7......
    r=floor(d/2);                             %图像填充大小
    im2 = padarray(im1,[r,r],'symmetric');    %原图扩充，边界像素能得到处理
    [m,n]=size(im2);   
    im3=zeros(size(m,n));
    d2=3;                                      %去除最大最小值个数
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
