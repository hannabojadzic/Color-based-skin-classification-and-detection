resizedImage = imread('Slika15.jpg');
[m n] = size(resizedImage)
       while(m > 750 && n > 750)
            resizedImage = imresize(resizedImage, 0.8);
            [m n] = size(resizedImage);
       end
       imshow(resizedImage)
       imwrite(resizedImage, 'resizedImage_Slika15.jpg');