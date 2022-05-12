x = [-2:0.01:2];
epsilon = 0.00001;

fun = @(x) x.^2 - x - 0.5;

plot(x, fun(x))

xA = -1;
xB = 0;
maxIterations = 100;

if( fun(xA) * fun(xB) >= 0 )
  disp("Kein Vorzeichenwechsel im Startintervall!")
end

for k = 1:maxIterations
  
  xM = (xA + xB) / 2;
  
  if( (fun(xA) * fun(xM)) < 0 )
    xB = xM;
  else
    xA = xM;
  end
  
  if( abs(xA - xB) <= epsilon )
    disp("Zielgenauigkeit erreicht!")
    break
  end
  
  if( k == maxIterations )
    disp("Maximale Anzahl an Iterationen erreicht.")
  end
  
endfor

x = (xA + xB) / 2, k