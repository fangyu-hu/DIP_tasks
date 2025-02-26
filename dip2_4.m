image = imread('Fig0462_PET_image.tif');
D0 = 30;
n = 2;
H = double(fspecial('gaussian', size(image), D0));

F = fftshift(fft2(double(image)));

G = F .* H;

g = ifft2(ifftshift(G));


g = real(g);

figure;
subplot(1, 2, 1);
imshow(image, []);


subplot(1, 2, 2);
imshow(g, []);
