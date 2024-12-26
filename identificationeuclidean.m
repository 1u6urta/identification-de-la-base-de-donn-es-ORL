function tid = identification()
    load('Mattrain.mat', 'Mattrain');
    load('Mattest.mat', 'Mattest');
    load('seuil.mat', 'seuil');

    % Initialisation des listes pour sauvegarder les distances
    total_tests = size(Mattest, 1);
    correct_matches = 0;
    
    % Fonction pour récupérer la classe d'un vecteur donné
    get_class = @(index) ceil(index / 5); 
    
    for i = 1:total_tests 
        vecteur_test = Mattest(i, :); 
        class_test = get_class(i);  
        
        min_distance = Inf;
        predicted_class = -1;
        
        for j=1:size(Mattrain,1)
            dist = norm(vecteur_test - Mattrain(j, :));
            if dist < min_distance 
                min_distance = dist;
                predicted_class = get_class(j);
            end
        end
        if predicted_class == class_test
            correct_matches = correct_matches + 1;
        end
        
    end
    tid = (correct_matches / total_tests) * 100;
    save('tid.mat', 'tid');
end