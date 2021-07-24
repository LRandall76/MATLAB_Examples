function [MATRIXMaster,LOADMaster, lastday] = readIn()

%% READ IN TEMPERATURE
filename            = "air temp max.xlsx";
[TEMP]              = tempRead(filename);
 
%% READ IN LOAD
filename            = "20120101-20190814 CAISO Actual Load.xlsx";
[DATE, LOADMaster]       = dataRead(filename);       % Read in File
[MATRIXMaster, lastday]  = returnMatrix(DATE, LOADMaster, TEMP);       % Get MATRIX from DATE and LOAD  
[MATRIXMaster, LOADMaster]    = chopOff(MATRIXMaster, LOADMaster);   % Chop Off the initial few years

% Delete Temporary Files
delete "MATRIXMaster.txt";
delete "LOADMaster.txt";
delete "lastday.txt";

% Save for Later Use
writematrix(MATRIXMaster,"MATRIXMaster.csv");
writematrix(LOADMaster,"LOADMaster.csv");
writematrix(lastday,"lastday.csv");

% If Excel
lastday = datetime(lastday,'ConvertFrom','datenum') - caldays(1) + calyears(1900); % Used for Simulating

%% Read Values From EXCEL if Data is already Stored
MATRIXMaster = readmatrix("MATRIXMaster.txt");
LOADMaster = readmatrix("LOADMaster.txt");
lastday = datetime("30-Jun-2019 23:00:00");
MATRIXMaster(9078:9100,:) = [];

% Add Year Column
for i = 1 : length(MATRIXMaster)
   if i >= 8661
    MATRIXMaster(i,9) = LOADMaster(i - 8660);
   else
    MATRIXMaster(i,9) = 45000;
   end
end

% Add 2 Weeks Prior Column
for i = 1 : length(MATRIXMaster)
   if i >= 337
    MATRIXMaster(i,11) = LOADMaster(i - 336);
   else
    MATRIXMaster(i,11) = 45000;
   end
end

% Add 3 Weeks Prior Column
for i = 1 : length(MATRIXMaster)
   if i >= 505
    MATRIXMaster(i,12) = LOADMaster(i - 504);
   else
    MATRIXMaster(i,12) = 45000;
   end
end


% Add 4 Weeks Prior Column
for i = 1 : length(MATRIXMaster)
   if i >= 673
    MATRIXMaster(i,13) = LOADMaster(i - 672);
   else
    MATRIXMaster(i,13) = 45000;
   end
end


end

