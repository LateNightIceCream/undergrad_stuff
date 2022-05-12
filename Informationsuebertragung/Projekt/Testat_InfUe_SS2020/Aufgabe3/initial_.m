% Startinitialisierung der Verzeichnisse

task(1) = cellstr('Test InfUe Aufgabe 3');

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

close_system ('GeneralASKLib',0)
close_system ('NoiseLib_2019',0)
close_system ('Rectfilter_2012',0)


% Parameterdatei für Simulink-Übung
%
% Basisband
%

clear

% Simulationsparameter

Tbit5_0 = 1/5000;     %5.0 kBit
Tbit2_5 = 1/2500;     %2.5 kBit
N=16;                 % Anzahl Samples/Symbol  
Tsk =   Tbit5_0/N;   % 16x upsampling, Kanalsimulationsschrittweite  


% ASK-Signalpunkte
M=2;                         %Initialisierung Symbolzahl (versch.ASKs)
sig2up =[0 1];              %Signalkonstellation 2-ASK unipolar
sig2bp =[-1 1];             %Signalkonstellation 2-ASK bipolar
sig4   =ASKpunkte(4);       %Signalkonstellation 4-ASK
sig16  =ASKpunkte(16);      %Signalkonstellation 16-ASK

%BER-Anfangsparameter/ Anpassung im Programm
nAuge  = 13;                 %Abtastpunkt in der Symbolfolge
nsteps = 1210;               %Versatz Sender/Empfänger 
nAuge2 = 12;                 %Erstinitialisierung 2-ASK   
nsteps2= 608;                %dito
sigdem = sig4;               %Signalvektor
sigdem2 =sig2bp;             %Konstellation 2ASK bipolar 
sigdem2up =sig2up;           %Konstellation 2ASK unipolar   


% Modelle öffnen
Aufgabe3_Bausteine
Aufgabe3



