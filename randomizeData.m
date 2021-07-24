function [train_input, train_output, test_input, test_output] = randomizeData(MATRIX, LOAD)
disp("Randomizing");
   
%% Gets Number For Testing Set and Training Set
% Ratio 60% n 40%
% For Now Using Exact Numbers is Easier than Using Matlabs Strange Float Calculations

%% Randomizing
train_input     = MATRIX(1:38179,:); 
train_output    = LOAD(1:38179,:);

train_input(1:8660,:)     = [];
train_output(1:8660,:)    = [];

N = length(train_input);
M = fix(N*0.6);              
ceil(M);

% Works By Initializing an Array with numbers (1 to size(MATRIX,1))
% Then uses each value as an index 
for i = 1: N - M

 index                  = randperm(N - i, 1);
 test_input(i,:)        = train_input(index,:); 
 train_input(index, :)  = [];
 test_output(i,:)       = train_output(index,:);
 train_output(index,:)  = [];
 
end

 
%% Transpose
train_input     = train_input';
train_output    = train_output'; 
test_input      = test_input';
test_output     = test_output'; 


end

