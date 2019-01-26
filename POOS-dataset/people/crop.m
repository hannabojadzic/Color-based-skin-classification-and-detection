[a,b,data] = xlsread('Regioniinteresa.csv');
data_koordinate = data(:,6);
data_name = data(:,1);
data_region = data(:,5);
%data_koordinate(2)
%char(data_koordinate(2))
%json_data = char(data_koordinate(2))
i = 2;
broj = size(data_koordinate);

while i~=  broj(1)+1
    a = 1
    brr = num2str(data_region{i});
    picture_name = char(data_name(i));
    json_data = char(data_koordinate(i));
    if exist(strcat(strcat('alternative2_' ,brr ), char(data_name(i))), 'file') == 2
    if json_data ~= "{}"      
        k = strfind(json_data,'"x":');
        y = strfind(json_data,',"y":');
        x = json_data(k+4:y-1)
        z = strfind(json_data,',"width":');
        y = json_data(y+5:z-1)
        kraj_width  = strfind(json_data,',"height":');
        width = json_data(z+9:kraj_width-1)
        height = json_data(kraj_width+10:end-1)
        b= 2
        I = imread(strcat(strcat('alternative2_' ,brr ), char(data_name(i))));
        I2 = imcrop(I,[str2num(x) str2num(y) str2num(width) str2num(height)]);
        imshow(I2);
        a = strcat(strcat('crop_' ,brr ), char(data_name(i)));
        imwrite(I2, a);
    end
    end
    
    i = i+1;
end
