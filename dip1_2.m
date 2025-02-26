Im=imread('Fig0312(a)(kidney).tif')
figure(1)
subplot(2,1,1)
imshow(Im)
i=im2double(Im);
if i>=0.5
    if i<=0.7
        I1=0.8;
    else
        I1=i;
    end
else
    I1=i;
end
subplot(2,1,2)
imshow(I1)