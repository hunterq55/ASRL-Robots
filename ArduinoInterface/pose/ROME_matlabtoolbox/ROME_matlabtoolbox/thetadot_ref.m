function thetadot_ref = thetadot_ref(t)
global manueverTime
%     thetr_dot = 5*pi/180.*cos(2*pi/10/4.*t);
%     thetr_dot=0;
%     thetadot_ref = [thetr_dot; thetr_dot; thetr_dot];
    thetr_dot = 105*(pi/180)*pi/manueverTime*(cos((pi*t/manueverTime)-90*(pi/180)));
    thetr_dot = 0;
    thetadot_ref = [0; thetr_dot; 0];
    
end