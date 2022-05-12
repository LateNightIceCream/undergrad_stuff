% Auswahl

task(1) = cellstr('Test InfUe Aufgabe 2');

disp(char(task(1)))

path_alt = matlabpath;
cf = pwd;
cf1= [cf,';'];
if ispc  
   mp = [cf,'\Models;'];
   mp1= [cf,'\Models\'];
   mf = [cf,'\M-Files;'];
end
if isunix  
   mp = [cf,'/Models;'];
   mp1= [cf,'/Models/'];
   mf = [cf,'/M-Files;'];
end

p = [cf1,mp,mf];
path(p, path_alt);

cd(mp1);

% Parameterdatei 

clear

close_system ('NoiseLib_2019',0)
close_system ('GeneralASKLib',0)
load file1
load file2

% Simulationsparameter


% ASK-Signalpunkte

sig2bp =[-1 1];             %Signalkonstellation 2-ASK bipolar

sigdem2 =sig2bp;             %Konstellation 2ASK bipolar 

% Modelle öffnen
Aufgabe2




