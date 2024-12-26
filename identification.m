function tid = knn_identification(K)

    if nargin < 1  % nargin gives the number of input arguments
        K = 1; % Default value
    end
    load('Mattrain.mat', 'Mattrain');
    load('Mattest.mat', 'Mattest');
    load('seuil.mat', 'seuil');

    % Initialisation des listes pour sauvegarder les distances
    total_tests = size(Mattest, 1);
    trainLabels = [];
    testLabels = [];
    
    % Fonction pour r�cup�rer la classe d'un vecteur donn�
    get_class = @(index) ceil(index / 5); 
    
    for i = 1:total_tests
        testLabels = [testLabels ; get_class(i)];
    end
    
    for i = 1:size(Mattest, 1) 
        trainLabels = [trainLabels ; get_class(i)];
    end 
        
    MattrainNorm = normalize(Mattrain);
    MattestNorm = normalize(Mattest);
    %cityblock /// euclidean
    
    knnModel = fitcknn(MattrainNorm, trainLabels, 'NumNeighbors', K, 'Distance', 'cityblock');
    predictedLabels = predict(knnModel, MattestNorm);
    
    knnModeleuclidean = fitcknn(MattrainNorm, trainLabels, 'NumNeighbors', K, 'Distance', 'euclidean');
    predictedLabelseuclidean = predict(knnModeleuclidean, MattestNorm);
    
    tid = sum((predictedLabels == testLabels)) / total_tests * 100;
    tideuclidean = sum((predictedLabelseuclidean == testLabels)) / total_tests * 100;
    
    fprintf('Pr�cision globale du mod�le KNN avec la distance de Manhattan : %.2f %%\n', tid);
    fprintf('Pr�cision globale du mod�le KNN avec la distance euclidienne : %.2f %%\n', tideuclidean);
    save('tid.mat', 'tid');
end