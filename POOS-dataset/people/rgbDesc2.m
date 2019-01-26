function [out1] = rgbDesc2(in)
% Separate to RGB channel
Ir = in(:,:,1);
Ig = in(:,:,2);
Ib = in(:,:,3);
% Extract the background (black) region
Igray = rgb2gray(in);
idx = Igray == 0;
% Calculate average RGB of the region
Rave = mean(Ir(~idx));
Gave = mean(Ig(~idx));
Bave = mean(Ib(~idx));
% Set the region to average RGB
Ir(~idx) = Rave;
Ig(~idx) = Gave;
Ib(~idx) = Bave;
Iout = cat(3,Ir,Ig,Ib);
% View the result
out1 = Rave+Gave+Bave;

end
