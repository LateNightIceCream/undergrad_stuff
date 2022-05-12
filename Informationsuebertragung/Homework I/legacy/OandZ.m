%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% generate a random 1 dim. matrix of ones and zeroes

function M = OandZ(n, flipProbability)
  
  % n:
  % length of matrix/ number of bits
  
  % flipProbability:
  % each bit's probability of flipping/being a 1
  
  % initialize M
  M = zeros(1,n);
  
  for i=(1:n)
    
    % random float between 0 and 1 to decide wheter to flip a bit
    randNum = rand(1);
    
    if(randNum < flipProbability)
      
      % flip bit
      M(i) = 1;
    
    endif
 
  endfor

endfunction 