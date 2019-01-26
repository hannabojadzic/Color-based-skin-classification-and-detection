
detector = vision.CascadeObjectDetector('stopSignDetector.xml');
MyFolderInfo = dir('Validacija');
for i=3:size(MyFolderInfo)
    MyFolderInfo(i,1).name
img = imread(strcat('Validacija\\', MyFolderInfo(i).name));
[m n] = size(img)
       while(m > 500 && n > 500)
            img = imresize(img, 0.8);
            [m n] = size(img);
       end
bbox = step(detector,img);
%J = imcrop(img,bbox);
%imwrite(J, strcat('ljudi\\',strcat(MyFolderInfo(i).name,'cropped.jpg')));
 detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'covjek');
 figure; imshow(detectedImg);
end