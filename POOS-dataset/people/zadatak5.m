function[] = zadatak5(putanja)
primjeniPoboljsanja(putanja)
%izdvajanje samo lica
detector = vision.CascadeObjectDetector('stopSignDetector.xml');
MyFolderInfo = dir(putanja);
for i=3:size(MyFolderInfo)
    MyFolderInfo(i,1).name
img = imread(strcat(putanja, '\\', MyFolderInfo(i).name));
bbox = []
bbox = step(detector,img)
size(bbox,1)
if size(bbox,1) == 1
J = imcrop(img,bbox);
imwrite(J, strcat('ValidacijaCropped\\',MyFolderInfo(i).name));
 detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'covjek');
 %figure; imshow(detectedImg);
else
    a=1
end
end

%deskriptori boja
[desc1, desc2] = getDescriptors('ValidacijaCropped')

%predikcija boja
%load classifier
classiferTest1 = load('classifierSvmWithoutOutliers.mat');
classifierTest = classiferTest1.classifierSvmWithoutOutliers;
%predict labels
predictedLabels = predict(classifierTest, desc1)

%insert boxes
j = 1
for i=3:size(MyFolderInfo)
    MyFolderInfo(i,1).name
img = imread(strcat(putanja, '\\', MyFolderInfo(i).name));
bbox = []
bbox = step(detector,img)
size(bbox,1)
if size(bbox,1) == 1
J = imcrop(img,bbox);
%imwrite(J, strcat('ValidacijaCropped\\',MyFolderInfo(i).name));
 detectedImg = insertObjectAnnotation(img,'rectangle',bbox,strcat('covjek - ', char(predictedLabels(j))));
 figure; imshow(detectedImg);
 j = j+1;
else
    imshow(img);
    a=1
end
end



end

function[] = primjeniPoboljsanja(putanja)
MyFolderInfo = dir(putanja);
for i=3:size(MyFolderInfo)
    MyFolderInfo(i,1).name
img = imread(strcat(strcat(putanja, '\\'), MyFolderInfo(i).name));
[m n] = size(img)
       while(m > 500 && n > 500)
            img = imresize(img, 0.8);
            [m n] = size(img);
       end
I = imadjust(img, [0.01 0.99],[]);
%bbox = step(detector,img);
%J = imcrop(img,bbox);
imwrite(I, strcat( 'ValidacijaPoboljsanje\\',strcat(MyFolderInfo(i).name,'.jpg')));
 %detectedImg = insertObjectAnnotation(img,'rectangle',bbox,'covjek');

end
end


function [desc1, desc2] = getDescriptors(putanja)
%syntheticDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat5','POOS-dataset','people','ljudi');
validationSet = imageDatastore(putanja, 'IncludeSubfolders', true,'LabelSource', 'foldernames');
numImages = numel(validationSet.Files);
validationFeatures = [];
for i = 1:numImages
img = readimage(validationSet, i);

validationFeatures= [validationFeatures; rgbDesc(img)]
end
validationFeatures =  filloutliers(validationFeatures,'next','median','ThresholdFactor',2)

desc1 = validationFeatures;

validationFeatures2 = [];
for i = 1:numImages
img = readimage(validationSet, i);

validationFeatures2= [validationFeatures2; rgbDesc2(img)]

end
validationFeatures2 =  filloutliers(validationFeatures2,'next','median','ThresholdFactor',2)
desc2 =validationFeatures2;
%testLabels = validationSet.Labels;
end