function G = getLinSysGeneratorMatrix(basicWords, dmin)
  
  G = [eye(columns(basicWords)), basicWords];
  
  
  if(minimumHammingWeight(G) < dmin)
    disp("Minimum Hamming distance/weight not possible");
  endif
  
endfunction