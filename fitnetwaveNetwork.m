function [MAPE, NET, train_inputNN] = fitnetwaveNetwork(train_input, train_output, test_input, test_output, AlgorithmUsed, level, epoch, layers, zeros, year, week)
disp("Running Wavelet Neural Network");

%% Adjusts Hidden Layer Variable to be Inputted
ws = size(layers,2);
for w = 1 : size(layers, 2)
     wp = ws - w + 1; 
     if layers(wp) == 0
     layers(wp) = [];
     end  
end

%% Neural Network Factors
goal            = 1e-10;                     % Accuracy
%fail            = 5000;                      % Validation Checks
fail            = 6;                      % Validation Checks
NET             = cell(level, 1);            % Variable to Store Trained NETS

%% Training Block
disp("--------NETWORKS TRAINED--------");
for z = 0: level    

    nocell = 0;
    
   train_inputNN = train_input(1:8 - zeros ,:);
   test_inputNN  = test_input(1:8 - zeros ,:);

   if year 
   
   train_inputNN(9 - zeros,:) = train_input(9 - zeros + z,:);
   test_inputNN(9 - zeros,:)  = test_input(9 - zeros + z,:);
   
   else
     nocell = nocell + 1;  
   end
   
   for j = 1: length(week)
    if week(j) 
   
      train_inputNN(9 + j - nocell - zeros,:) = train_input(9 + j - nocell + level * (j - nocell) - zeros + z,:);
      test_inputNN(9 + j - nocell - zeros,:)  = test_input( 9 + j - nocell + level * (j - nocell) - zeros + z,:);
   
    else
      nocell = nocell + 1;  
    end
   end


 
 %% Set Parameters
 net_n = fitnet(layers, AlgorithmUsed);
 net_n.trainParam.epochs   = epoch;                                            
 net_n.trainParam.goal     = goal;   
 net_n.trainParam.max_fail = fail;   
  net_n.trainParam.mu_max       = power(10,40);  

 
 %% Train
[net_n]                    = train(net_n, train_inputNN, train_output(z + 1,:));  


% Displays Networks Trained
disp(z + 1); 
%Save Network in Cell Vector
NET{z + 1} = net_n;
 
%% Simulation
Pred(z + 1,:) = (sim(net_n, test_inputNN));

end

save NET{z};



%% Reconstruction of Various Leveled Neural Networks
% Pred
    Forecasted = 0;
    for z = 1: level + 1
    Forecasted = Pred(z,:) + Forecasted;
    end

% Actual
    Actual = 0;
    for z = 1: level + 1
    Actual = test_output(z,:) + Actual;
    end


%% Plotting Data

subplot(3,1,1) % Used if you want to Graph Multiple Graphs on Same Window
plot(Forecasted,'r')
hold on

plot(Actual,'b')
hold off
title("FORECASTED ON ACTUAL");

subplot(3,1,2)
plot(Forecasted,'r')
title("FORECASTED");

subplot(3,1,3)
plot(Actual,'b')
title("ACTUAL");


%% Aquire MAPE
n   = length(Forecasted); 
sum = 0;
for z = 1:n 
 sum    = sum + abs(( Actual(z) - Forecasted(z) ) / Actual(z));
end
 MAPE   = sum * 100 / n;
 
%% Display MAPE
disp('vvvvvvvvvvvvvvvvvvv');
disp('MAPE:');
disp(MAPE);
disp('vvvvvvvvvvvvvvvvvvv');
end

