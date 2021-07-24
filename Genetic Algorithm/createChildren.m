function [GENETIC_SUBJECTS] = createChildren(GENETIC_SUBJECTS,childsize, remain)   
% Chooses Random Subject to Mate with
mate = randperm(remain, childsize); % array of random indexs for mates

 %% Outer Loop -- For Number of Children being Created
 for j = 1 : (childsize)
     
       gsize = size(GENETIC_SUBJECTS,1) + 1;
          
       %% Inner Loop for Giving Variables to All Parameters in New Child
        for k = 1 :size(GENETIC_SUBJECTS,2)
            
           % Check if Loop is on Neuron Vector or Level of Decomp 
           if k >= 3 && k <= 10
           % Uses Fixed Weighted Sum to Calculated Numbers
               GENETIC_SUBJECTS(gsize,k) = round(GENETIC_SUBJECTS(j,k) * 0.6 + GENETIC_SUBJECTS(mate(j),k) * 0.4);     
               
           % Must be Other Parameter -- For other parameters we give 60% chance of higher scoring mate to pass genes   
           else
                 m = randperm(10,1); % Pull a Random Number
                 
                if m >= 5            % 60% for Winner
                 GENETIC_SUBJECTS(gsize,k) = GENETIC_SUBJECTS(j,k);
                else                 % 40% for Loser
                 GENETIC_SUBJECTS(gsize,k) = GENETIC_SUBJECTS(mate(j),k);
                end 
                
           end
           
       end
 end

end

