% Auswahl

task(1) = cellstr('Test InfUe Aufgabe 8');
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

% Parameter 
clear
close_system ('NoiseLib_2019',0)
close_system ('GeneralASKLib',0)

% Simulationsparameter

Tbit5_0 = 1/5000;     %5.0 kBit
Tsk     = Tbit5_0/16;   % Sim-Schrittweite des Kanals

sig2bp =[-1 1];             % Signalkonstellation 2-ASK bipolar
sigdem2 =sig2bp;            % Konstellation 2ASK bipolar
els=[1 0 0 0 0];            % Initialisierung Entzerrer


% Modelle öffnen
Aufgabe8
Aufgabe8_Bausteine




