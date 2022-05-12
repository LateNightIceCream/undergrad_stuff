
% Auswahl
task(1) = cellstr('Test InfUe Aufgabe 9');
disp(char(task(1)))

% aktuelle Suchpfade für Modelle und M-Files auf Verzeichnis dieser 
% Start-Datei setzen

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

load signalsA9


% Modelle öffnen
Aufgabe9





