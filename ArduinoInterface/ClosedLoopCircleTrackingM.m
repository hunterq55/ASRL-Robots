
%Platform geometry
L = .115;
theta = 0;

%Rotation matrix
pTheta = [-sin(theta)               cos(theta)          L;
          -sin((pi/3)-theta)       -cos((pi/3)-theta)   L;
           sin((pi/3)+theta)       -cos((pi/3)+theta)   L;];
       
