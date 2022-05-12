% Auswahl

task(1) = cellstr('Test InfUe Aufgabe 7');

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

close_system ('NoiseLib_2019',0)
close_system ('GeneralASKLib',0)

% Simulationsparameter
fs = 48e3;
ts = 1/fs;

Tbit5_0 = 2*4.8*ts;     %5.0 kBit
% Tbit2_5 = 4*4.8*ts;   %2.5 kBit
Tsk     = Tbit5_0/16;   % Sim-Schrittweite des Kanals
fs1     = 1/Tsk;        % Abtastfrequenz des Kanals
dt      = Tsk;          % dito
%fs2     = 40e3;         % Abtastfrequenz der TP-Filter
%Ts      = 1/fs2;        % Abtastperiode der TP-Filter
W       = 22e3;         % 2W = Bandbreite des Rauschsignals

% Entwerfen der Rausch-Tiefpassfilter
n_filter = 128;
%htp = fir1(n_filter, 2*W/fs1);

% ASK-Signalpunkte
%M=2;                         %Initialisierung Symbolzahl (versch.ASKs)
%sig2up =[0 1];              %Signalkonstellation 2-ASK unipolar
sig2bp =[-1 1];             %Signalkonstellation 2-ASK bipolar
%sig4   =ASKpunkte(4);       %Signalkonstellation 4-ASK
%sig16  =ASKpunkte(16);      %Signalkonstellation 16-ASK

%BER-Anfangsparameter/ Anpassung im Programm
%nAuge  = 13;                 %Abtastpunkt in der Symbolfolge
%nsteps = 1210;               %Versatz Sender/Empfänger 
%nAuge2 = 12;                 %Erstinitialisierung 2-ASK   
%nsteps2= 608;                %dito

sigdem2 =sig2bp;             %Konstellation 2ASK bipolar 


% Modelle öffnen
Aufgabe7
Aufgabe7_Bausteine




