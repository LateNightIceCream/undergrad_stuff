% Aufgabe Ausgleichsrechnung
clear;
close all;

points = sortrows(load("-ascii", "daten.dat"), 1);

X = points(:,1);
Y = points(:,2);


%xvals = min(X):0.01:max(X);

%scatter(X,Y)

% LINEARE REGRESSION

% linear
p = polyfit(X,Y,1);

% p(2) : Y intercept
% p(1) : slope

knoppers = polyval(p,X);

% quadratic
p = polyfit(X,Y,2);

unicorn = polyval(p,X);

% residuen
knoppersRes = Y - unicorn;
unicornRes  = Y - unicorn;

subplot( 2, 1, 1 )
plot(X, knoppers,
     X, unicorn,
     X,Y,'o');
     

subplot( 2, 1, 2 )
plot(X, knoppersRes, 'o',
     X, unicornRes, 'x');
     
# NICHTLINEARE REGRESSION

p = polyfit(log(X),log(Y), 1);

a = exp(p(2));
b = p(1);

schnibi = @(x) a.*exp(b.*x);

figure
plot(X, schnibi(X))
