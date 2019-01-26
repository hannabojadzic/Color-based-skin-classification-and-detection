[a,b,data] = xlsread('Regioniinteresa.csv');
data_koordinate = data(:,6)
data_name = data(:,1)
data_region = data(:,5)
%data_koordinate(2)
%char(data_koordinate(2))
%json_data = char(data_koordinate(2))
i = 2
broj = size(data_koordinate)

while i~= 4 %broj(1)+1
       brr = num2str(data_region{i})
    picture_name = char(data_name(i))
    json_data = char(data_koordinate(i))
if json_data ~= "{}"    
k = strfind(json_data,'"x":');
y = strfind(json_data,',"y":');
x = json_data(k+4:y-1)
z = strfind(json_data,',"width":');
y = json_data(y+5:z-1)
kraj_width  = strfind(json_data,',"height":');
width = json_data(z+9:kraj_width-1)
height = json_data(kraj_width+10:end-1)
%naziv = 'people/';
if exist( char(data_name(i)), 'file') == 2
img = imread( char(data_name(i)));
%rez = img;
%rez(:,:,1) = uint8(double(rez(:,:,1)).*BW);
%rez(:,:,2) = uint8(double(rez(:,:,2)).*BW);
%rez(:,:,3) = uint8(double(rez(:,:,3)).*BW);
%rezz = [uint8(BW), [1 1 1]]



shadow_lab = rgb2hsv(img);
shadow_lab(:,:,3) = shadow_lab(:,:,3)*1.46;
%shadow_lab(:,:,2) = shadow_lab(:,:,2)/255;
%shadow_lab(:,:,1) = shadow_lab(:,:,1);
shadow_lab(:,:,3) = adapthisteq(shadow_lab(:,:,3));
%shadow_lab(:,:,2) = histeq(shadow_lab(:,:,2))/2;
%shadow_lab(:,:,1) = histeq(shadow_lab(:,:,1));
shadow_histeq = hsv2rgb(shadow_lab);

figure; 
imshow(shadow_histeq);
a = strcat(strcat('alternative4_' ,brr), char(data_name(i)))
imwrite(shadow_histeq, a);
end
end
i = i+1;
end