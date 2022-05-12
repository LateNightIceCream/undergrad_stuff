%% Test InfUe Aufgabe 1
% 

clear all;
clc
close all
load('A1_daten')

% histogram
delta = 1;
Hi = -5:delta:5;
hx1 = hist(n1,Hi);
hx1 = hx1/(N*delta);

xt = 1:1:length(n2);

hold on;

obj = n1;
plot(xt, obj.^2)
RMS = mean(obj.^2) + zeros(1, 1000);
variance = var(obj) + zeros(1,1000);
plot(xt, variance);
mean(obj)

RMS(1)
variance(1)

plot(xt, RMS);

hold off;


figure
bar(Hi,hx1,'y'), grid
ylabel('norm. Histogram, f_X(n1) \rightarrow'); xlabel('n1 \rightarrow');

delta = 1;
Hi = -5:delta:5;
hx2 = hist(n2,Hi);
hx2 = hx2/(N*delta);

%figure
%bar(Hi,hx2,'y'), grid
%ylabel('norm. Histogram, f_X(n2) \rightarrow'); xlabel('n2 \rightarrow');


% Berechnung Mittelwert und Varianz n1,n2 (Formeln vervollst�ndigen!!)

xmue1  = mean(n1);   %Formeln??
var_n1 = mean((n1 - xmue1).^2); % var(n1)
fprintf('\n')
fprintf('linear mean1: %5.2f\n',xmue1)
fprintf('variance1   : %5.6f\n',var_n1)

xmue2 = 0;
var_n2 = 0;
fprintf('\n')
fprintf('linear mean2: %5.2f\n',xmue2)
fprintf('variance2   : %5.2f\n',var_n2)