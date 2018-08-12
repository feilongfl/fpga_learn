clc
clear

imgarr(10000) = 0;
image = imread('img.bmp');
for i = 1: 100
    for j = 1:100
        imgarr(j + 100*(i - 1)) = image(j,i);
    end
end
imgarr