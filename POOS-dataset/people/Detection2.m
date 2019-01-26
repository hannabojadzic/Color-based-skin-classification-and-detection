[a,b,data] = xlsread('Regioniinteresa.csv');
data_koordinate = data(:,6);
data_name = data(:,1);
data_region = data(:,5);
data_count=data(:,4);
%data_koordinate(2)
%char(data_koordinate(2))
%json_data = char(data_koordinate(2))
i = 2;
broj = size(data_koordinate);
tabela = table();
while i~=  broj(1)+1
    
    brr = num2str(data_region{i});
    picture_name = char(data_name(i));
    json_data = char(data_koordinate(i));
   % imDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat2','POOS-dataset','people', 'people');
    if exist( char(data_name(i)), 'file') == 2
    if json_data ~= "{}" &&  data_count{i}== 1
        k = strfind(json_data,'"x":');
        y = strfind(json_data,',"y":');
        x = json_data(k+4:y-1)
        z = strfind(json_data,',"width":');
        y = json_data(y+5:z-1)
        kraj_width  = strfind(json_data,',"height":');
        width = json_data(z+9:kraj_width-1)
        height = json_data(kraj_width+10:end-1)
        
        %I = imread(strcat(strcat('alternative2_' ,brr ), char(data_name(i))));
        %I2 = imcrop(I,[str2num(x) str2num(y) str2num(width) str2num(height)]);
        tabela = [tabela; {char("C:/Users/wetan/Desktop/POOSProjekat2/POOS-dataset/people/people/"+ data_name(i)), {[str2num(x) str2num(y) str2num(width) str2num(height)]}}];    
    end
    end
    
    i = i+1;
end
tabela
 
%tabela.imDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat2','POOS-dataset','people', 'people');
acfDetector = trainACFObjectDetector(tabela);
img = imread('slika21.jpg');

[bboxes,scores] = detect(acfDetector,img);
for i = 1:length(scores)
   annotation = sprintf('Confidence = %.1f',scores(i));
   img = insertObjectAnnotation(img,'rectangle',bboxes(i,:),annotation);
end

figure
imshow(img)