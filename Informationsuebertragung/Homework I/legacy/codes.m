clear all;

global n    = 6;
global m    = 3;
global hmin = 4;

#global hmin = 2^n/2^m; % = 2^(n-m)



if(hmin > 2^n/2^m) 


  %% error: hmin zu groß

endif




% generate table with decimals for algorithm
global hamming_table = zeros(2^n);
nums = zeros(n,1);

for(i = 1:(2^n))
  nums(i) = i-1;
endfor

for(i = 1:(2^n))

  for(l = 1:(2^n))
  
    hamming_table(i,l) = hamDistDec(nums(i), nums(l));
  
  endfor

endfor

hamming_table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% check table values for hmin, get pair numbers/columns of that row
function v = getPairValues( rowValue, columnValues )
    
   global hamming_table;
   global n;
   global hmin;
    
   pairValues = 0;
    
    % loop through columns
    o = 0;
    
    for( k=1:length(columnValues) )
   
          p2 = hamming_table(rowValue+1, columnValues(k) + 1);
          
          if(p2 >= hmin) 
          
            o += 1;
            
            pairValues(o) = columnValues(k);
          
          endif
    
    endfor
  
  v = pairValues;
  
endfunction


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% find code containing the most codewords

result = zeros(1);

for (base_value = 0:(2^n-1))

  % get code from table, starting at base_value
  base_pairs = 1;
  
  compareValues = base_value:(2^n-1);

  currentResult(1)  = base_value;
  i = 2;
  while( base_pairs != 0 )

    base_pairs    = getPairValues( base_value, compareValues );

    base_value    = base_pairs(1); % first element is new row value
    
    compareValues = base_pairs(2:length(base_pairs));
    
    currentResult(i) = base_value;
    i+=1;
    
  endwhile
  
  
  currentResult = currentResult(1:(length(currentResult)-1)) % remove last zero

  if( length(currentResult) >= length(result) )
  
    result = currentResult
    
  endif

endfor

result
de2bi(result, n, 'right-msb')



##base_pairs = getPairValues(base_value, base_value:(2^n-1));
##
##%%%
##
##currentPairs    = base_pairs;
##currentRowValue = base_pairs(1);
##
##result(1) = base_value;
##
##i = 1;
##
##while( currentPairs != 0 ) # maybe change
##
##
##  i+=1;
##  
##  currentRowValue = currentPairs(1);
##  
##  result(i) = currentRowValue;
##  
##  prevPairs    = currentPairs;
##  
##  
##  currentPairs = getPairValues(currentRowValue, currentPairs( i:length(currentPairs) ) );
##
##  
##  
##  if(currentPairs == 0)
##  
##    result(i+1) = prevPairs(length(prevPairs)); % respect last value which does not produce further pairs
##  
##  endif
##
##endwhile
##
##% convert result to binary
##
##result
##
##c = de2bi(result, n, 'right-msb')




#getPairValues(3, [2,4,5,6,7] )
  





% generate vector of valid code words
##d = 0;
##
##for p = 2:2^m
##  d(p,1) = (hmin + d(p-1));
##endfor
##
##
##c = de2bi(d, n, 'right-msb');
##
##
##
##%i = OandZ(m, 0.5); % informationsvektor i --> c codewortvektor (?)
##f = OandZ(n, 1/n);  % fehlervektor f
##
##%
##
##G = c;
##
##i = 0;
##
##for k = 1:2^m
##  i(k,1) = k;
##endfor
##
##i = de2bi(i, m, 'right-msb');
##
##c = i'
##
##% Generator Matrix G
##l = eye(m); % identity matrix (m x m)




