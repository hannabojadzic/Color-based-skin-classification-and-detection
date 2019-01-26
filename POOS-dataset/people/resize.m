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
    if(brr == "0")
       b= 2
       resizedImage = imread(picture_name);
       [m n] = size(I)
       while(m > 750 && n > 750)
            resizedImage = imresize(resizedImage, 0.8);
            [m n] = size(resizedImage);
       end
       a = strcat(strcat('resizedImage_' ,picture_name ));
       imshow(resizedImage)
       imwrite(resizedImage, a);
    end
    
    
    i = i+1;
end
