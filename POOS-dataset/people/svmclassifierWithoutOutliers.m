syntheticDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat5','POOS-dataset','people','ljudi');
handwrittenDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat5','POOS-dataset','people','testljudi');
trainingSet = imageDatastore(syntheticDir, 'IncludeSubfolders', true,'LabelSource', 'foldernames');
testSet = imageDatastore(handwrittenDir, 'IncludeSubfolders', true,'LabelSource', 'foldernames');
numImages = numel(trainingSet.Files);
numImages2 = numel(testSet.Files);
trainingFeatures = [];
for i = 1:numImages
img = readimage(trainingSet, i);
%img = rgb2gray(img);
% Korak preprocesiranje - kreiranje maske uzorka
%img = imbinarize(img);
% Ekstrakcija HOG osobina slike

trainingFeatures= [trainingFeatures; rgbDesc(img)];
end
trainingFeatures
trainingFeatures =  filloutliers(trainingFeatures,'next','median','ThresholdFactor',2)
%trainingFeatures =  filloutliers(trainingFeatures,'nearest','mean')
testFeatures = [];
for i = 1:numImages2
img = readimage(testSet, i);
%img = rgb2gray(img);
% Korak preprocesiranje - kreiranje maske uzorka
%img = imbinarize(img);
% Ekstrakcija HOG osobina slike

testFeatures= [testFeatures; rgbDesc(img)];

end
testFeatures =  filloutliers(testFeatures,'next','median','ThresholdFactor',2)
%testFeatures

%[B,TF] = rmoutliers(testFeatures,'mean')
%for i= TF
 %   if i == 1
  %      testLabels = testLabels([1:i, i+1:end]);
   % end
%end
% Dobavljanje imena klasa trening skupa
trainingLabels = trainingSet.Labels
testLabels = testSet.Labels

% Treniranje SVM klasifikatora - K(K – 1)/2 SVM klasifikatora, gdje je k
% broj unikatnih klasa
classifierSvmWithoutOutliers = fitcecoc(trainingFeatures, trainingLabels);

% Predikcija koriste?i istrenirani klasifikator i testni skup slika
predictedLabels = predict(classifierSvmWithoutOutliers, testFeatures);
% Tabelarni prikaz rezultata predikcije klasifikatora
confMat = confusionmat(testLabels, predictedLabels);

% Tabelarni prikaz performansi klasifikatora
%helperDisplayConfusionMatrix(confMat)
acc=(confMat(1,1) + confMat(2,2))/(confMat(2,1)+confMat(1,2)+confMat(2,2)+confMat(1,1))
sen = (confMat(1,1))/(confMat(1,1)+confMat(2,1))
sp = (confMat(2,2))/(confMat(2,2)+confMat(1,2))