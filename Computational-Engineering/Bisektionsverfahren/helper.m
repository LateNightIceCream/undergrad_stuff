clear bisektion
%fun = @(x) x.^2 - x - 0.5;
function returnval = fun(p)
  returnval = p.^2 - p - 0.5;
  return;
endfunction
mkoctfile --mex bisektion.c