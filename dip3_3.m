I=imread("Fig0505(a)(applo17_boulder_noisy).tif");
subplot(2,2,1);
imshow(I);title("原图");
subplot(2,2,2);
I1=gaussion(I);
imshow(I1);title("高斯带阻滤波");
subplot(2,2,3);
I2=BBEF(I);
imshow(I2);title("巴托沃斯带阻滤波");
subplot(2,2,4);
I3=gos(I);
imshow(I3);title("空域的高斯平滑滤波");

function Y = BBEF(I)
    s=fftshift(fft2(im2double(I)));
    [N1,N2]=size(s);%求二维傅里叶变换后图像大小
    n=3;            % 将巴特沃斯带阻滤波器的阶数n设置为3
    W=300;           % 将巴特沃斯带阻滤波器的带宽W设置为300
    d0=180;          % 将巴特沃斯带阻滤波器的截止频率D0设置为180
    n1=round(N1/2);
    n2=round(N2/2);
    for i=1:N1      %双重for循环计算频率点(i,j)与频域中心的距离D(i,j)=sqrt((i-round(N1/2)^2+(j-round(N2/2)^2))
        for j=1:N2 
            distance=sqrt((i-n1)^2+(j-n2)^2);
            if distance==0 
                h=0; 
            else
                h=1/(1+((distance*W)/(distance*distance-d0*d0))^(2*n));% 根据巴特沃斯带阻滤波器公式为1/(1+[(D(i,j)*W)/(D^2(i,j)-D0^2)]^2n)
            end
            s(i,j)=h*s(i,j);% 频域图像乘滤波器的系数
        end
    end
    % real函数取元素的实部
    s=real(ifft2(ifftshift(s)));% 最后进行二维傅里叶反变换转换为时域图像
    Y=s;
end

function Y = gaussion(I)
    s=fftshift(fft2(im2double(I)));
    [a,b]=size(s);
    W=300;  % 将高斯带阻滤波器的带宽W设置为300
    d0=180; % 将高斯带阻滤波器的截止频率D0设置为180
    a0=round(a/2);
    b0=round(b/2);
    for i=1:a
        for j=1:b
            distance=sqrt((i-a0)^2+(j-b0)^2);    % 根据高斯带阻滤波器公式H(u,v)=1-e^-(1/2)[(D^2(u,v)-D^20)/D(u,v)*W] 
            h=1-exp(-0.5*((distance^2-d0^2)/(distance*W))^2); % exp表示以e为底的指数函数
            s(i,j)=h*s(i,j);% 频域图像乘滤波器的系数
        end
    end

    Y=real(ifft2(ifftshift(s)));% 最后进行二维傅里叶反变换转换为时域图像

end
function Y=gos(I)
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
    Y=img_data2;
    end
end