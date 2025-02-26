
originalImage = imread('Fig0637(a).tif');


hsvImage = rgb2hsv(originalImage);

% 提取H、S、I通道
H = hsvImage(:,:,1);
S = hsvImage(:,:,2);
V = hsvImage(:,:,3);

% 显示变换后的图像及其H、S、I通道
figure;

subplot(2, 2, 1);
imshow(hsvImage);
title('HSV空间');

subplot(2, 2, 2);
imshow(H);
title('H通道');

subplot(2, 2, 3);
imshow(S);
title('S通道');

subplot(2, 2, 4);
imshow(V);
title('V通道');