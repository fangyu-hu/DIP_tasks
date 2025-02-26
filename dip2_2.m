I=imread('Fig4.11(a).jpg');
subplot(1,3,1);
imshow(I);title('原图');

%理想低通滤波器
[M,N]=size(I);
fno=fft2(I);
fnos=fftshift(fno);
D0=15;%截止频率
%lpf
for i = 1:499
    for j = 1:499
        distance = sqrt((i-256)^2+(j-256)^2);
        if distance <= D0
            h = 1;
        else
            h = 0;
        end
        I1(i,j) = h*fnos(i,j);
    end
end
%傅里叶反变换
i1 = ifftshift(I1);
I1f= ifft2(i1);
subplot(1,3,2);imshow(abs(I1f),[]);title('理想低通滤波器');

%高斯滤波
[img_w,img_h,img_channel] = size(I);
for channel=1:1:img_channel
img=I(:,:,channel);
core_size=5;%奇数卷积核
sigma=1;%标准差
%%
%生成高斯核
core_xy=(core_size+1)./2;
for x=1:1:core_size
    for y=1:1:core_size
        
        r2=sqrt(abs(x-core_xy))+sqrt(abs(y-core_xy));
        kernel(x,y)=exp((-r2)./(2.*sigma*sigma));
    end
end
kernel=kernel./sum(sum(kernel));

core_size=size(kernel,1);
core_xy=(core_size+1)./2;
%%
expert_size=(size(kernel,1)-1);%补零大小
img_data=uint8(zeros(size(img,1)+expert_size,size(img,2)+expert_size));
for x=1:1:size(img,1)
    for y=1:1:size(img,2)
        img_data(x+(expert_size./2),y+(expert_size./2))=img(x,y);
        
        
    end
end

%%
%卷积
img_data2=img_data;%临时变量
for x=core_xy :1:size(img_data,1)-core_xy+1
    for y=core_xy :1:size(img_data,2)-core_xy+1
        a=[];%设置临时变量，保存每个卷积子块对应的值
       
        for i=-core_xy+1:1:core_xy-1
            for j=-core_xy+1:1:core_xy-1
                a(i+core_xy,j+core_xy)=kernel(i+core_xy,j+core_xy)*img_data(x+i,y+j)  ;
                
            end
        end
         img_data2(x,y)=sum(sum(a));
         
    end
end

img_data2=imcrop(img_data2,[expert_size./2+1 expert_size./2+1 size(img,2)-1 size(img,1)-1]);
%位置和区域大小
%I1(:,:,channel)=img_data2;
end
subplot(1,3,3);imshow(img_data2);title('高斯滤波');
