function [imgout] = imlogfil(img, c )
    imgout = c * log(double(img)+1);
end
