% get hamming distance of two decimals
function d = hamDistDec(dec1, dec2)

  % number of bits needed to represent dec1/dec2
  if(dec1 > dec2)
  
    n=ceil(log(dec1+1)/log(2)); 
  
  else
  
    n=ceil(log(dec2+1)/log(2));
  
  endif

  % convert decimals to binary matrices
  c1 = de2bi(dec1, n, 'right-msb');

  c2 = de2bi(dec2, n, 'right-msb');
  
  % get distance
  d = 0;
  
  for(i = 1:n)
  
    if( c1(i) != c2(i) )
  
      d+=1;
    
    endif
  
  endfor
  
endfunction