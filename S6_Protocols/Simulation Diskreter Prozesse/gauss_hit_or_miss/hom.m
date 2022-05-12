clear all;
close all;
clc;
#-------------------------------------------------------------------------------

npoints = 10000;

func = @(x) exp(-x.^2);

a = 5
pointsX = a * (rand(npoints, 1) - 0);
pointsY = rand(npoints, 1);

hits  = 0; 

xvals = 0:0.01:a;

hold on;

#-------------------------------------------------------------------------------

hitIndices = 1;
for (i = 1:npoints)
  
  if (pointsY(i) <= func(pointsX(i)))
    
    hitIndices = [hitIndices; i];
    hits++;
    
  endif

endfor
#-------------------------------------------------------------------------------

indices    = 1:npoints;
hitIndices = hitIndices(2:end);

flags       = ~ismember(indices, hitIndices);
missIndices = indices(flags);

plot(xvals,                 func(xvals));
plot(pointsX(hitIndices),   pointsY(hitIndices),  "og");
plot(pointsX(missIndices),  pointsY(missIndices), "or");

xlabel("Zufalls x");
ylabel("Zufalls y");

hold off;
#-------------------------------------------------------------------------------

A    = hits / npoints
Anum = quad(func, -1, 1) / a
