I = imread('Fig1039(a).tif');
subplot(121);imshow(I);title('ԭͼ');
se = graythresh(I)
IBW = im2bw(I, se);
subplot(122);imshow(IBW);title('I��');


