% Unvollständiger Ansatz zur Entzerrer-Berechnung (Zero-Forcing)!!


N=4;   % N+1 Koeffizienten werden berechnet!!!! [els_0...els_n]
L=2;   % Länge Kanalimpulsantwort

h0=1;   % Kanalkoeffizienten   !!der Aufgabenstellung anpassen!!
h1=0;


h=[h0 h1];      % Kanalimpulsantwort
hf=fliplr(h);   % Kanalimpulsantwort zeitlich gespiegelt

% Aufstellen der Faltungsmatrix manuell:
H=[h0 0 0 0 0;...
  h1 h0 0 0 0;...
  0 h1 h0 0 0;...
  0 0 h1 h0 0;...
  0 0 0 h1 h0;...
  0 0 0 0 h1];



Hh=H';
i=[1 0 0 0 0 0];  % Bsp.Vektor der Nyquistbedingung

els=inv(Hh*H)*(Hh*i') % Entzerrerberechnung (Berechnung der inversen Faltungsmatrix)  

%% Fehlerabschätzung:

%---  Kontrolle (FIR-Filterung der Impulsantwort)

i % zum Vergleich

%---   Fehlerleistung (Summe quadr. Abweichung)

%--- Rauscheinfluss ---( Summe der Entzerrer-Koeffizienten-Quadrate )

%