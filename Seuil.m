function seuil = Seuil()
    load('Mattrain.mat', 'Mattrain');
    load('Mattest.mat', 'Mattest');

    % Initialisation des listes pour sauvegarder les distances
    n_classes = 40;
    distances_intra = [];
    distances_extra = [];

    % Fonction pour récupérer la classe d'un vecteur donné
    get_class = @(index) ceil(index / 5); 
    
    % Calcul des distances intra-classes
    for i_test = 1:size(Mattest, 1)
        class_test = get_class(i_test);
        for i_train = 1:size(Mattrain, 1)
            if get_class(i_train) == class_test
                dist = norm(Mattest(i_test, :) - Mattrain(i_train, :));
                distances_intra = [distances_intra; dist];
            end
        end
    end
    
    % Calcul des distances extra-classes
    for i_test = 1:size(Mattest, 1)
        class_test = get_class(i_test); 
        for i_train = 1:n_classes
            if i_train ~= class_test
                dist = norm(Mattest(i_test, :) - Mattrain((i_train - 1) * 5 + 1, :));
                distances_extra = [distances_extra; dist];
            end
        end
    end
    % Calcul du seuil
    seuil = (max(distances_intra) + min(distances_extra)) / 2;
    
    save('seuil.mat', 'seuil');
end