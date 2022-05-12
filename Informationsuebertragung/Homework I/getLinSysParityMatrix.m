function H = getLinSysParityMatrix(generatorMatrix) 
  
  nrows = rows(generatorMatrix);    % = k
  ncols = columns(generatorMatrix); % = n
  
  I = eye(ncols - nrows); % eye(n-k)
  
  P = generatorMatrix(1:nrows, (nrows+1):ncols); % extraction
  
  H = [P', I];
  
endfunction