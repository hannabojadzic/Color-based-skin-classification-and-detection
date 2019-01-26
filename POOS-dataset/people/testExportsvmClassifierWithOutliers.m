
% Predikcija koriste?i istrenirani klasifikator i testni skup slika
predictedLabels = predict(classifierSvmWithOutlier, testFeatures);
% Tabelarni prikaz rezultata predikcije klasifikatora
confMat = confusionmat(testLabels, predictedLabels);

% Tabelarni prikaz performansi klasifikatora
%helperDisplayConfusionMatrix(confMat)
acc=(confMat(1,1) + confMat(2,2))/(confMat(2,1)+confMat(1,2)+confMat(2,2)+confMat(1,1))
sen = (confMat(1,1))/(confMat(1,1)+confMat(2,1))
sp = (confMat(2,2))/(confMat(2,2)+confMat(1,2))