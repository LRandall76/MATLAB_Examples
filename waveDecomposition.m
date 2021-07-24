function [MATRIX, LOAD] = waveDecomposition(LOAD, MATRIX, wname, level, year, week)
disp("Decomposing Wave");               
                            
level = 4;

temp = LOAD;

%% Decomp of LOAD
if level
[C,L] = wavedec(LOAD, level, wname);
clear LOAD;
    for i = 1: (level + 1)
      if i == 1
        LOAD(:,i) = wrcoef('a', C, L, wname, level); % Approx
      else
        LOAD(:,i) = wrcoef('d', C, L, wname, i - 1); % Detail
      end
    end
    
	% Plot Data To Help Visualize
    X = [1 : 1: length(LOAD)];
    h =   plot(X, LOAD(:,5),'b');
    hold on
    h =   plot(X, temp, ':k');  
    set(gca,'FontSize',24);
    xlabel('Time (Hours)');
    ylabel('Load (Watts)');
    title('Electrical Load for 2015-2019');
    hold off

    ax = ancestor(h, 'axes');
    ax.XAxis.Exponent = 0;
    ax.YAxis.Exponent = 0;
    xtickformat('%.0f');
    ytickformat('%.0f');


%% Decomp For Matrix + Concatonation
% Decomp of the Year Before Load
for j = 0: length(year) - 1
    if year(j + 1)
    [C,L] = wavedec(MATRIX(:, 9 + j), level, wname);
      for i = 1: (level + 1)
            if i == 1
        AH = wrcoef('a', C, L, wname, level); % Approx
        Y(:, i) = AH;
           else
        DH = wrcoef('d', C, L, wname, i - 1); % Detail
        Y(:, i) = DH;
            end
      end
    MATRIX = horzcat(MATRIX, Y);
    end
end
   


    for j = 0: length(week) - 1
      if week(j + 1)
    % Decomp of the First Week Before Load
    [C,L] = wavedec(MATRIX(:,11 + j), level, wname);

        for i = 1: (level + 1)
            if i == 1
            AW = wrcoef('a', C, L, wname, level); % Approx
            W(:, i) = AW;
            else
            DW = wrcoef('d', C, L, wname, i - 1); % Detail
            W(:, i) = DW;
            end
        end
        MATRIX = horzcat(MATRIX, W);
      end
    end
    
    
   
MATRIX(:,9:14) = []; % Delete Old Waves
end
end

