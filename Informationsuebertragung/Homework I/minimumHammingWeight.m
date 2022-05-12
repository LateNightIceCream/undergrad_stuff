function wmin = minimumHammingWeight(codewords)

  weight = columns(codewords);
  
  for(i = 1:rows(codewords) )
  
  currentWeight = 0;
  
    for(j = 1:columns(codewords))
    
      currentWeight += codewords(i, j);
  
    endfor
  
  if(currentWeight < weight && currentWeight != 0)
    weight = currentWeight;
  endif
  
  endfor
  
  wmin = weight;
  
endfunction