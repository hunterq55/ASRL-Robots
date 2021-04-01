
function theta_ref = theta_ref(t)
global maneuverTime
%     thetr = 5*pi/180*sin(2*pi/10/4.*t) + 60*pi/180;
%     thetr=0;
%     theta_ref = [thetr; thetr; thetr];
    thetr = 105*(pi/180)*(sin((pi*t/manueverTime)-90*(pi/180)));
    theta_ref = [0; thetr; 0];

end