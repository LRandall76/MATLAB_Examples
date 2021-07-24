function [year, week] = checkWavelet(GENETIC_SUBJECTS, i)
% Finds if Week Before Load and/or Hour Before Load are used
     
            year = GENETIC_SUBJECTS(i,18);
            
            for j = 1 : 4
            week(j) = GENETIC_SUBJECTS(i,17 + j);
            end
end

