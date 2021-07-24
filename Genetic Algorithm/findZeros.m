function [zeros,level, MATRIX] = findZeros(GENETIC_SUBJECTS, MATRIX,level, i)
   zeros = 0;
   %% Finds Number of Columns Taken out of MATRIXMaster by GA
   % Stores this number in zeros
    for j = 0 : 7
             if(GENETIC_SUBJECTS(i,17 - j) == 0)
              MATRIX(:,8 - j) = [];
              zeros  = zeros + 1;
             end
    end
 
    %% Checks if Hour Before Load and Week Before Load are not used
    % Basically detects if we need to use wavelets
    if GENETIC_SUBJECTS(i,22) == 0 &&  GENETIC_SUBJECTS(i,21) == 0 && (GENETIC_SUBJECTS(i,20) == 0) && GENETIC_SUBJECTS(i,19) == 0 && (GENETIC_SUBJECTS(i,18) == 0)
    level = 0;
    end
    
end

