L(1) = Link([0 169.77 64.2 -1.5707], 'R');
L(2) = Link([0 0 305 0], 'R');
L(3) = Link([0 0 0 1.5707], 'R');
L(4) = Link([0 -222.63 0 -1.5707], 'R');
L(5) = Link([0 0 0 1.5707], 'R');
L(6) = Link([0 -36.25 0 0], 'R');
% create an object called robot from class SerialLink
Robot = SerialLink(L);
Robot.name = "AR2";

Robot.dyn(1)