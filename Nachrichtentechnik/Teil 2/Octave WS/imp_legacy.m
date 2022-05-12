% create impulse
function pulseVector = imp_legacy(t, tcenter, twidth) % a lot slower than imp

  pulseVector = zeros(length(t));
  
  Tsample = (t(2)-t(1));
  
  for(i = 0:Tsample:length(t))
    
    if(( i > (tcenter-twidth./2) ) && ( i < (tcenter+twidth./2) ))
    
     index = int32(i./Tsample);
     
     pulseVector(index) = 1;
    
    endif
    
  endfor
  
endfunction