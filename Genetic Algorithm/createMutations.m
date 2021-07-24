function [GENETIC_SUBJECTS]= createMutations(GENETIC_SUBJECTS, mutatesize, remain, BOUNDS)
% Subject to be Copied and Altered 
mate = randperm(remain, mutatesize);
 
for i = 1 : (mutatesize)
 
    
    temp = GENETIC_SUBJECTS(mate(i),:);
    
    % Gets 3 Random Genes to Alter
    mutatedparameter = randperm(size(GENETIC_SUBJECTS,2) - 1,3);
   
    %% Alter Variables
    %  Binary Value 
    for k = 1 : size(mutatedparameter)
        if mutatedparameter(k) >= 11 
            if temp(1, mutatedparameter(k)) == 0
            temp(1, mutatedparameter(k)) = 1;
            else
            temp(1, mutatedparameter(k)) = 0; 
            end
    
        % Algor or Wave or Level
        elseif mutatedparameter(k) <= 3 
        temp(1, mutatedparameter(k)) = randperm(BOUNDS(2,mutatedparameter(k)),1);
    
        % Neuron Vector Value -- This Changes all Values in Vector  
        else
        
            layersdeep = randperm(6,1); % Get New Depth Level (1-6)
            % Get New Amount of Neurons Per Depth  
            for j = 1 :layersdeep
                layers(j) = randperm(30,1);
            end
       
            % Add Zeros if Not Max Depth
            if layersdeep ~= 6           
                 for j = 1 : 6 - layersdeep
                 layers(layersdeep + j) = 0;
                 end
            end
        
            % Put New Vector of Neurons back into Copied Subject
            for j = 1: size(layers)
                temp(1, j + 3)= layers(j);
            end
        
        end
    end 
    %% Put Mutated Subject Back in Group
    GENETIC_SUBJECTS(size(GENETIC_SUBJECTS,1) + 1, :) = temp;
 
end

end

