function v = getCodewords(generatorMatrix)
 
  v = zeros(1,columns(generatorMatrix));

  for( i = 1:(2^(rows(generatorMatrix))-1)  )
  
    u = de2bi(i, rows(generatorMatrix), "left-msb");

    v = [v; u * generatorMatrix];
  
  endfor

  v = mod(v, 2);
  
endfunction