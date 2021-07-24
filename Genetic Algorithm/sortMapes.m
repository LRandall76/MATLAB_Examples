function [GENETIC_SUBJECTS] = sortMapes(GENETIC_SUBJECTS)
    % Works by picking first variable and doing a binary search
    % Every variable is compared with every other variable
    % Arguably the most complicated code in all of this
    
    %% Initialize Variables
     lowest = GENETIC_SUBJECTS(1,:);
     n = 1;
     m = 2;
     
    %% Loop
    % Loop with (n*(n+1))/2 time
    for j = 1 : ((size(GENETIC_SUBJECTS,1) - 1) * size(GENETIC_SUBJECTS,1))/2
      
        if lowest(1,size(GENETIC_SUBJECTS,2)) > GENETIC_SUBJECTS(m, size(GENETIC_SUBJECTS,2))
        temp = GENETIC_SUBJECTS(m,:);
        GENETIC_SUBJECTS(m,:) = lowest;
        GENETIC_SUBJECTS(n,:) = temp;
        lowest = temp;
        end
        
        if mod(m,size(GENETIC_SUBJECTS,1))== 0
        n = n +1;
        lowest = GENETIC_SUBJECTS(n,:);
        m = n;
        end
        
        m = m + 1;
        
    end
end

