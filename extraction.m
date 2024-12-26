function [Mattrain, Mattest] = extraction()
    %chemin_im = 'C:\\Users\\dell latitude\\Desktop\\BioSec\\ORL database\\s%d\\%d.pgm';
    %chemin_resultat_train = 'C:\\Users\\dell latitude\\Desktop\\train\\%d_%d.fp';
    %chemin_resultat_test = 'C:\\Users\\dell latitude\\Desktop\\test\\%d_%d.fp';
    
    chemin_im = 'C:\\Users\\Hp\\Desktop\\MATLAB\\ORL database\\s%d\\%d.pgm';
    chemin_resultat_train = 'C:\\Users\\Hp\\Desktop\\MATLAB\\train\\%d_%d.fp';
    chemin_resultat_test = 'C:\\Users\\Hp\\Desktop\\MATLAB\\test\\%d_%d.fp';


    num_subjects = 40;
    num_images_par_subject = 10;
    Mattrain = [];
    Mattest = [];

    for subject = 1:num_subjects
        for img_index = 1:num_images_par_subject
            img_path = sprintf(chemin_im, subject, img_index);
            
            if isfile(img_path) % Vérifier si le fichier existe
                img = imread(img_path);
            else
                error(['Fichier non trouvé : ', img_path]);
            end

            img_d = double(img);
            [c, s] = wavedec2(img_d, 3, 'coif1');
            dimension = s(1, :);
            dimX = dimension(1);
            dimY = dimension(2);
            v = c(1:dimX * dimY);
            if img_index <= 5
                train_path = sprintf(chemin_resultat_train, subject, img_index);
                fid = fopen(train_path, 'w');
                fprintf(fid, '%3.0f\n', v);
                fclose(fid);
                Mattrain = [Mattrain; v];
            else
                test_path = sprintf(chemin_resultat_test, subject, img_index);
                fid = fopen(test_path, 'w');
                fprintf(fid, '%3.0f\n', v);
                fclose(fid);
                Mattest = [Mattest; v];
            end
        end
    end

    save('Mattrain.mat', 'Mattrain');
    save('Mattest.mat', 'Mattest');
end

