clc
clear

imgarr(10000) = 0;
image = imread('img.bmp');
for i = 1: 100
    for j = 1:100
        imgarr(i + 100*(j - 1)) = image(i,j);
    end
end
imgarr