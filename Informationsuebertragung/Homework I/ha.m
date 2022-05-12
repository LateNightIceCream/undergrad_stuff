clc;
clear all;

dmin = 3;
basicWords = [1 1 1;
              1 0 1;
              1 1 0;]

%-------------------------

G = getLinSysGeneratorMatrix(basicWords, dmin) % n

i = [0 1 0];                   % Quellvektor

c = mod( i * G, 2);            % codierter Informationsvektor

%f = OandZ(columns(c), 0.1);    % Fehlervektor
f = [0 0 0 0 1 0];

d = mod( c + f, 2);           % Empfangsvektor

H = getLinSysParityMatrix(G)  % Kontrollmatrix

s = mod( d * H', 2)'          % syndrom, s = f * H'


% Bestimmung der Fehlerposition
% https://mathworks.com/matlabcentral/answers/286890-how-do-i-find-the-submatrix-of-a-matrix
szA = size(H);
szB = size(s);
szS = szA - szB + 1;
tf = false(szA);
for r = 1:szS(1)
    for l = 1:szS(2)
        tf(r,l) = isequal(H(r:r+szB(1)-1,l:l+szB(2)-1),s) ;
    end
end
[rout, fehlerposition] = find(tf);

% Fehlervektor generieren
fdach = zeros(1,columns(d));
for(k = 1:columns(d))
  if(k == fehlerposition)
    fdach(k) = 1;
  endif
endfor

d_corrected = mod(d + fdach, 2); % Berechnung der Korrektur

idach = d_corrected(1:(columns(G)-rows(G))); % Dekodierung, systematischer code

disp("------------------------------")
disp("Sender")
disp("------------------------------")
disp("Informationswort:"), disp(i)
disp("")
disp("gesendetes Codewort:"), disp(c)

disp("")
disp("------------------------------")
disp("Kanal")
disp("------------------------------")
disp("Fehlervektor:"), disp(f)

disp("")
disp("------------------------------")
disp("Empfänger")
disp("------------------------------")
disp("Empfangene Folge:"), disp(d)
disp("")
disp("Bestimmter Fehlervektor:"), disp(fdach)
disp("")
disp("Daraus geschätzte Folge:"), disp(d_corrected)
disp("")
disp("Dekodiertes Informationswort:"), disp(idach)

