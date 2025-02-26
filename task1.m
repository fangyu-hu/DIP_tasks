I = imread('Fig10.10(a).jpg');
subplot(421);imshow(I,[]);title('‘≠Õº');
h = fspecial('average',[5 5]);
Imean = imfilter(I,h);
subplot(422);imshow(Imean,[]);title('5*5æ˘÷µ¬À≤®');
Isobel = edge(Imean,'sobel');
subplot(423);imshow(Isobel,[]);title('sobel');
Icanny = edge(Imean,'canny');
subplot(424);imshow(Icanny,[]);title('canny');
se = strel('diamond',3);
Isesobel = imdilate(Isobel,se);
subplot(425);imshow(Isesobel,[]);title('sobel≈Ú’Õ');
Iersobel = imerode(Isesobel,se);
subplot(426);imshow(Iersobel,[]);title('sobel≈Ú’Õ∏Ø ¥');

Isecanny = imdilate(Icanny,se);
subplot(427);imshow(Isecanny,[]);title('canny≈Ú’Õ');
Iercanny = imerode(Isecanny,se);
subplot(428);imshow(Iercanny,[]);title('canny≈Ú’Õ∏Ø ¥');










