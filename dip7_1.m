Icroporigin = imread('plate.jpg');
% 原图
subplot(2, 2, 1), imshow(Icroporigin); title('原图');
% 灰度图转换
Igray = rgb2gray(Icroporigin);
% 灰度图
subplot(2, 2, 2), imshow(Igray); title('灰度图');
% 二值化分割
level = graythresh(Igray);
BWCrop = im2bw(Igray, level);
% 显示二值图
subplot(2, 2, 3), imshow(BWCrop); title('车牌二值图');
% 形态学处理，提取较大面积的连通分量
SE = strel('rectangle', [5, 5]);
BWCropProcessed = imclose(BWCrop, SE);
% 显示形态学处理后的图
subplot(2, 2, 4), imshow(BWCropProcessed); title('车牌二值图后处理');
% 各连通分量红色boundingbox的绘制
cc = bwconncomp(BWCropProcessed);
stats = regionprops(cc, 'Area', 'BoundingBox');
hold on;
for i = 1:cc.NumObjects
rectangle('position', stats(i).BoundingBox, 'edgecolor', 'r');
bb = stats(i).BoundingBox;
xwidth = bb(3);
ywidth = bb(4);
% 剪切出每个字符区域
Icropletter = imcrop(Igray, bb);
% 在这里可以添加字符识别或其他后续处理的代码
saveas(gcf,'车牌字符定位.png','png');
end
hold off;