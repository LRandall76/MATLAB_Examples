%Neural Network Code Using A Feed Forward Network
%08/09/2020
clc
clear all;

%% Loop Variables
ALGOR  = ["trainlm","trainbfg","trainrp","trainscg","traincgb","traincgf","traincgp","trainoss","traingdx"];
WAVES  = ["db10","sym8"];

%% GENETIC ALGORTIHM
iterations = 100; % How Many Loops the GA will perform
subcount = 100; % ***must be multiple of ten*** as code uses 10% to calculate Mutation Subjects

% Clear Away Previous Indexing Files
for i = 1:iterations   
     if isfile( i + ".txt")
        delete( i + ".txt")
     end
end    



%% Info on Structure of GA Subject 
% GENETIC_SUBJECTS(n) = [ALGOR(1-9), WAVE(1-22), LEVEL(1-7), Neurons1(1-30), Neurons2, ..., Neurons6, MATRIXMaster[1](0-1), MATRIXMaster[2], ..., MATRIXMaster[10], MAPE]
[GENETIC_SUBJECTS, BOUNDS] = createSubjects(subcount);

 
%% Read In() -- Simply Reads in variables from .xlsx or .txt files. Calculating Functions are Commented Out.
  [MATRIXMaster, LOADMaster, lastday] = readIn();
  
%% Outer Testing Loop -- Reruns all Subjects
for z = 1 : iterations
   
  %% Inner Testing Loop -- Tests Individual Subject
   parfor i = 1: size(GENETIC_SUBJECTS,1)
       
       
        %% Variables In Use
    AlgorithmUsed   = "trainlm";                            % Algorithm
    wname           = WAVES(GENETIC_SUBJECTS(i,2));         % Wavelet
    level           = GENETIC_SUBJECTS(i,3);                % Level of Wavelet Decomposition
    epoch           = 100;                                  % Epochs
    layers          = GENETIC_SUBJECTS(i,5:10);             % Vector of Neurons for Hidden Layers
    
 
    
      
        %% MAIN BLOCK
        
    % Check if Hour before Load and Wave Before Load are used in
    % calculations. (Hour and Week are most complicated variables to work with in all of the code)
    [year, week] = checkWavelet(GENETIC_SUBJECTS, i);
   

    % Decompose Wave
    [MATRIX, LOAD] = waveDecomposition(LOADMaster, MATRIXMaster, wname, level, year, week); 



    % Finds how many Columns in MATRIXMaster are Removed by GA
    % Makes work easier later
    [zeros, level, MATRIX] = findZeros(GENETIC_SUBJECTS, MATRIX, level, i);

       
    % Randomizes Input Variables 
    [train_input, train_output, test_input, test_output] = randomizeData(MATRIX, LOAD);  

    % Train and Test Network
    [MAPE, NET, train_inputNN] = fitnetwaveNetwork(train_input, train_output, test_input, test_output, AlgorithmUsed, level, epoch, layers, zeros, year, week);
     % Store MAPE in Vector for GA Later  
 
 
    % Simulate Future
    MAPE = simFuture(level, MATRIX, LOAD, lastday, year, week, zeros, GENETIC_SUBJECTS, i, train_inputNN, LOADMaster);
    MAPES(i,1) = MAPE;
   
%     %% Display Parameters
        disp("***************************************");
        disp("Subject:*********")
        disp(i);
        disp("END OF PROGRAM");
        disp("***************************************");
        
   end
    % Store MAPE in Row w/ Subject
    GENETIC_SUBJECTS(:,size(GENETIC_SUBJECTS,2)) = MAPES(:,1);   
   
   
   
    %% Begin GA Optimization  
    [GENETIC_SUBJECTS] = sortMapes(GENETIC_SUBJECTS); % Sort by lowest MAPE 
    writematrix(GENETIC_SUBJECTS, "GENES.xlsx");      % Write out to Excel
    
    % Parameters (30% Breed, 10% Mutated)
    childsize  = size(GENETIC_SUBJECTS,1) * .3; % Child Count
    mutatesize = size(GENETIC_SUBJECTS,1) * .1; % Mutation Count
    kill = childsize + mutatesize;              % Number of Subjects to Eliminate
    remain = (size(GENETIC_SUBJECTS,1) - kill); % Number of Subjects Remaining
    
    % Eliminate Low Scoring Subjects (Lowest 40%)
    GENETIC_SUBJECTS((1 + remain):size(GENETIC_SUBJECTS,1),:) = []; 

    % Recreate Eliminated From Children and Mutants
    [GENETIC_SUBJECTS]= createChildren(GENETIC_SUBJECTS,childsize, remain);
    [GENETIC_SUBJECTS]= createMutations(GENETIC_SUBJECTS,mutatesize, remain, BOUNDS);


    %% Cout Iteration
    disp("#######################################");
    disp("#######################################");
    disp("##########Iteration : ");
    disp(z);
    disp("#######################################");
    disp("#######################################");
    
    %% Create File w/ Name as Index of Current Iteration
    if z > 1
    oldfile = z - 1;
    oldfile = oldfile + ".txt";
    delete (oldfile)
    end
    writematrix(z, z + ".txt")
  
end

	%% Write Results to a File
    writematrix(GENETIC_SUBJECTS, "GENES_DONE.txt");    
       
        
        
        
        
        
        
        
        
        

