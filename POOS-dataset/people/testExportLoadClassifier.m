classiferTest1 = load('classifierSvmWithoutOutliers.mat')
classifierTest = classiferTest1.classifierSvmWithoutOutliers

% Predikcija koriste?i istrenirani klasifikator i testni skup slika
handwrittenDir = fullfile('C:','Users','wetan','Desktop','POOSProjekat5','POOS-dataset','people','testljudi');
testSet = imageDatastore(handwrittenDir, 'IncludeSubfolders', true,'LabelSource', 'foldernames');
numImages = numel(trainingSet.Files);
numImages2 = numel(testSet.Files);
testFeatures = [];
for i = 1:numImages2
img = readimage(testSet, i);
%img = rgb2gray(img);
% Korak preprocesiranje - kreiranje maske uzorka
%img = imbinarize(img);
% Ekstrakcija HOG osobina slike

testFeatures= [testFeatures; rgbDesc(img)]
end
testFeatures =  filloutliers(testFeatures,'next','median','ThresholdFactor',2)
testLabels = testSet.Labels;
predictedLabels = predict(classiferTest, testFeatures);
% Tabelarni prikaz rezultata predikcije klasifikatora
confMat = confusionmat(testLabels, predictedLabels);
acc=(confMat(1,1) + confMat(2,2))/(confMat(2,1)+confMat(1,2)+confMat(2,2)+confMat(1,1))
sen = (confMat(1,1))/(confMat(1,1)+confMat(2,1))
sp = (confMat(2,2))/(confMat(2,2)+confMat(1,2))