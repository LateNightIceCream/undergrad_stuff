function [ua,f]=frequenzgang(dateiname)
%function [ua,f]=frequenzgang(dateiname)
%frequenzgang('Name.txt') ruft Daten aus der angegebenen
%.txt-Datei auf und interpretiert die 1.Spalte als Frequenz,
%und die 2.Spalte als Amplitude
%Grafische Darstellung als Amplitudenfrequenzgang

data = load (dateiname);
f  = data(:,1);
ua = data(:,2);
ue = max(ua);                   %näherungsweise ua/ue=1 im Durchlassbereich
uadb = 20*log10(ua/ue);         %Umrechnung in dB
h=semilogx(f,uadb);
grid
ha = get(h(1),'Parent');
set(ha, 'FontSize',14);
                                %Limits nach Bedarf abändern!
xlim([100;15000])

ylabel('u_a in dB')
xlabel('f in Hz')
h = gcf;
p=strfind(dateiname,'txt');     %Dateinamen in Grafik einbinden
if p ~= 0
    teil=dateiname(1:p-2);
else
teil='';
end;
Grafikname=['Amplitudenfrequenzgang ',teil];  
Kurvenname=['Amplitude ',teil];
Plotname=['Frequenzgang ',teil];
set(h,'Name',Grafikname)
title(Plotname)
legend(Kurvenname)

