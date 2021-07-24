function [GENETIC_SUBJECTS, BOUNDS] = createSubjects(subcount)

 
% GENETIC_SUBJECTS(n) = [ALGOR(1-9), WAVE(1-22), LEVEL(1-7), Neurons1(1-30), Neurons2, ..., Neurons6, MATRIXMaster[1](0-1), MATRIXMaster[2], ..., MATRIXMaster[10], MAPE]
BOUNDS =[1,1,1,1,0,0,0,0,0; 1, 2, 4, 30, 30, 30, 30, 30, 30]; % 2x2 Matrix that gives bounds of GA. Used in Mutation and Child Functions

%% Begin Loop
for i = 1 : subcount 
    
    % Sets Algorithm, Wave, and Level
    SUBJECT = [randperm(9,1),randperm(2,1),randperm(4,1)];

    % How Many Layers in the Hidden Layer as well as How Many Neurons in Each
    % Layer
    layersdeep = randperm(6,1);
    
    for j = 1 :layersdeep
        layers(j) = randperm(30,1);
    end
    
    if layersdeep ~= 6
        for j = 1 : 6 - layersdeep
        layers(layersdeep + j) = 0;
        end
    end
    
    
    % TESTING PURPOSES ONLY
    %SUBJECT(1) = 1; 
    %SUBJECT(2) = 1;   
    %SUBJECT(2) = 15;   
%       layers = [30,30,0,0,0,0];

    % Concatonates the algorith, wave, and level, to the array of neurons
    SUBJECT = horzcat(SUBJECT,layers);


    % Decides how many Columns Used in MATRIXMaster (Inputs are BinaryVals)
    for j = 1: 13
        binary(j) = randi([0 1]);
    end  
    
    SUBJECT = horzcat(SUBJECT, binary);
    
    % TESTING PURPOSES ONLY    
%     SUBJECT(18) = 0;
%     SUBJECT(19) = 0;
 

    GENETIC_SUBJECTS(i,:) = SUBJECT;
end
% Original Genes Before Alteration
writematrix(GENETIC_SUBJECTS, "GENES1.txt");   
end

