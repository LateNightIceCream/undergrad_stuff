function path_neu = setpath(num)
% Setzen des Suchpasses für bestimmte Aufgaben
% für Matlab
%     path_neu = setpath(num);


% Auswahl
%task(1) =   cellstr('Laborpraktikum Grundlagen der Nachrichten- und Übertragungstechnik');
task(2,1) = cellstr('Versuch Lineare Systeme - LTI');

num = 2;

path_alt = matlabpath;

disp(char(task(num)))
p = ['C:\Users\Student\Praktika\LTISysteme'];
path(p, path_alt);
cd('C:\Users\Student\Praktika\LTISysteme\')
winopen ('C:\Users\Student\Praktika\LTISysteme\Box5-2.txt')

if nargout > 0
    path_neu = matlabpath;
end

