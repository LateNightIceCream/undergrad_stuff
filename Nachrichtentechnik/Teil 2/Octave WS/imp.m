% generate a zero padded impulse around tcenter
function pulseVector = imp(t, tcenter, twidth) 

  Tsample = t(2)-t(1);

  pulseVector = sign(sin(2.*pi./(2.*twidth).*t));
  pulseVector = pulseVector(2:(twidth/Tsample)); % 2: bc first element is 0

  padleft  = zeros(1, floor(tcenter/Tsample-twidth/(2*Tsample))+1);
  padright = zeros(1, (length(t) - floor((tcenter+twidth/2)/Tsample)));

  pulseVector = [padleft, pulseVector, padright];
  
endfunction