%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% from https://sourceforge.net/p/octave/communications/ci/default/tree/inst/
function b = de2bi(d, n, f)
  
  d = d(:);

  power = ones (length (d), 1) * (2 .^ [0 : n-1] );
  d = d * ones (1, n);
  b = floor (rem (d, 2*power) ./ power);
  
  if (strcmp (f, "left-msb"))
    b = b(:,columns (b):-1:1);
  elseif (!strcmp (f, "right-msb"))
    error ("de2bi: invalid option '%s'", f);
  endif

endfunction