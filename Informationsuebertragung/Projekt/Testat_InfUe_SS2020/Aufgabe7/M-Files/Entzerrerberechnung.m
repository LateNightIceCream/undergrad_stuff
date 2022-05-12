% Unvollständiger Ansatz zur Entzerrer-Berechnung (Zero-Forcing)!!


N=4;            % N+1 Koeffizienten werden berechnet!!!! [els_0...els_n]
L=2;            % Länge Kanalimpulsantwort

h0=2/sqrt(5);   % Kanalkoeffizienten 
h1=1/sqrt(5);


h=[h1 h0];      % Kanalimpulsantwort

% Aufstellen der Faltungsmatrix:
%H=[h0 0 0 0 0;...
%   h1 h0 0 0 0;...
%   0 h1 h0 0 0;...
%   0 0 h1 h0 0;...
%   0 0 0 h1 h0;...
%   0 0 0 0 h1];

% Aufstellen der Faltungsmatrix automatisiert:


Hh=H';
i=[1 0 0 0 0 0];  %Bsp.

els=inv(Hh*H)*(Hh*i') % Entzerrerberechnung (Berechnung der inversen Faltungsmatrix)  

