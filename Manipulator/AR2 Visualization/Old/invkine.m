%tester values - pos 300 10 150 0 0 0
%                ang 1.909 -32.907 128.086 180 -174.821 1.90915

function J=invkine(Robot,pos,cur)

%initialize J
J = zeros(1,6);

%homogeneous transform matrix T - [R p] - 4x4
                                % [0 1]

T = transl(pos(1),pos(2),pos(3)) * rpy2tr(pos(4), pos(5), pos(6), 'rad');

T(1,1) = T(1,1)*-1;
T(3,3) = T(3,3)*-1;

%cur vector - current angles in degrees

%pos vector - current x y z, rx ry rz 


%DH param finder-------------------------------------------
%access DH params - Robot.links(1,1).a
%DH=[theta alpha d a]
DH1=[Robot.links(1,1).theta, Robot.links(1,1).alpha, Robot.links(1,1).d ,Robot.links(1,1).a];
DH2=[Robot.links(1,2).theta, Robot.links(1,2).alpha, Robot.links(1,2).d ,Robot.links(1,2).a];
DH3=[Robot.links(1,3).theta, Robot.links(1,3).alpha, Robot.links(1,3).d ,Robot.links(1,3).a];
DH4=[Robot.links(1,4).theta, Robot.links(1,4).alpha, Robot.links(1,4).d ,Robot.links(1,4).a];
DH5=[Robot.links(1,5).theta, Robot.links(1,5).alpha, Robot.links(1,5).d ,Robot.links(1,5).a];
DH6=[Robot.links(1,6).theta, Robot.links(1,6).alpha, Robot.links(1,6).d ,Robot.links(1,6).a];
%----------------------------------------------------------
%TRANFORMATION MATRIX-----------------------------
R06 = T;

REMR06 = [-1 0 0 0;
        -sind(180)*cos(DH6(2)) cosd(180)*cos(DH6(2)) sin(DH6(2)) 0;
        sind(180)*sin(DH6(2)) -cosd(180)*sin(DH6(2)) cos(DH6(2)) -DH6(3); 
        0 0 0 1];
   
R05 = R06*REMR06;

%quadrant calc

if pos(1)>0 && pos(2)>0
    quad = 1;
elseif pos(1)>0 && pos(2)<0
    quad = 2;
elseif pos(1)<0 && pos(2)<0
    quad = 3;
elseif pos(1)<0 && pos(2)>0
    quad = 4;
else
    quad = 0;
end

%calc for J1 
J1ang=atand(R05(2,4)/R05(1,4));

if quad == 1 || quad == 0
    J(1) = J1ang;
elseif quad == 2
    J(1) = J1ang;
elseif quad == 3
    J(1) = J1ang-180;
elseif quad == 4
    J(1) = J1ang+180;
% else
%     error('invalid motion');
end

%for the two different configs fwd(1) and mid(2)    
%initialize all variables

%pX will be the same value for both
%pY will be the same value for both
pXa1 = zeros(1,2);
pa2H = zeros(1,2);
%pa3H will be the same value for both
thetaA= zeros(1,2);
thetaB= zeros(1,2);
thetaC= zeros(1,2);
%thetaD FWD does not exist
%thetaE will be the same value for both
J2ang = zeros(1,2);
J3ang= zeros(1,2);
J4ang= zeros(1,2);
J5ang= zeros(1,2);
J6ang= zeros(1,2);


pX=sqrt((R05(1,4)^2)+(R05(2,4)^2));

pY=R05(3,4)-DH1(3);

pXa1(1)=pX-DH1(4);
pXa1(2)=-pXa1(1);  
    
pa2H(1)=sqrt((pXa1(1)^2)+(pY^2));    
pa2H(2)=sqrt((pXa1(2)^2)+(pY^2));    

pa3H=sqrt((DH3(4)^2)+(DH4(3)^2));

thetaA(1)=atand(pY/pXa1(1));
thetaA(2)=acosd(((DH2(4)^2)+(pa2H(2)^2)-(DH4(3)^2))/(2*DH2(4)*pa2H(2)));

thetaB(1)=acosd(((DH2(4)^2)+(pa2H(1)^2)-pa3H^2)/(2*DH2(4)*pa2H(1)));
thetaB(2)=atand(pXa1(2)/pY);

%thetaE must be defined first before defining thetaC

%if arctan undefined, use 90 degrees
if DH3(4) == 0
    thetaE=90;
else
    thetaE=atand(DH4(3)/DH3(4));
end

thetaC(1)=180 - acosd(((pa3H)^2+(DH2(4)^2)-(pa2H(1)^2))/(2*abs(DH2(4))*pa3H)) + (90 - thetaE);
thetaC(2)=180 - acosd(((pa3H)^2+(DH2(4)^2)-(pa2H(2)^2))/(2*abs(DH2(4))*pa3H)) + (90 - thetaE);

thetaD = 90-(thetaA(2)+thetaB(2));

J2ang(1)=-(thetaA(1)+thetaB(1));
J2ang(2)=180+thetaD;

J3ang(1)=thetaC(1);
J3ang(2)=thetaC(2);

%J2 and J3 assignments + logic

if pXa1(1) < 0
    J(2) = J2ang(2);
else
    J(2) = J2ang(1);
end

if pXa1(1) < 0
    J(3) = J3ang(2);
else
    J(3) = J3ang(1);
end

%Transform Matrix up to J3

%tool frame considered origin
TOOL=eye(4);

JR1=[cosd(J(1)) -sind(J(1))*cos(DH1(2)) sind(J(1))*sin(DH1(2)) DH1(4)*cosd(J(1));
     sind(J(1)) cosd(J(1))*cos(DH1(2)) -cosd(J(1))*sin(DH1(2)) DH1(4)*sind(J(1));
     0 sin(DH1(2)) cos(DH1(2)) DH1(3);
     0 0 0 1];

JR2=[cosd(J(2)) -sind(J(2))*cos(DH2(2)) sind(J(2))*sin(DH2(2)) DH2(4)*cosd(J(2));
     sind(J(2)) cosd(J(2))*cos(DH2(2)) -cosd(J(2))*sin(DH2(2)) DH2(4)*sind(J(2));
     0 sin(DH2(2)) cos(DH2(2)) DH2(3);
     0 0 0 1];

JR3=[cosd(J(3))-90 -sind(J(3)-90)*cos(DH3(2)) sind(J(3)-90)*sin(DH3(2)) DH3(4)*cosd(J(3)-90);
     sind(J(3)-90) cosd(J(3)-90)*cos(DH3(2)) -cosd(J(3)-90)*sin(DH3(2)) DH3(4)*sind(J(3)-90);
     0 sin(DH3(2)) cos(DH3(2)) DH3(3);
     0 0 0 1];

R01=TOOL*JR1;

R02=R01*JR2;

R03=R02*JR3;

R03=[R03(1,1) R03(1,2) R03(1,3);
      R03(2,1) R03(2,2) R03(2,3);
      R03(3,1) R03(3,2) R03(3,3)];

R03=R03';

RR05=[R05(1,1) R05(1,2) R05(1,3);
      R05(2,1) R05(2,2) R05(2,3);
      R05(3,1) R05(3,2) R05(3,3)];

R36=R03*RR05;

%joints 4 5 and 6 calc logic

J5ang(1)=atan2d(sqrt(1-(R36(3,3)^2)),R36(3,3));
J5ang(2)=atan2d(-sqrt(1-(R36(3,3)^2)),R36(3,3));


if cur(5) >= 0 && J5ang(1) > 0
    J(5)=J5ang(1);
else
    J(5)=J5ang(2);
end

%Corrected
if J(5) > 0
    J(4)=atan2d(R36(2,3),R36(1,3));
else
    J(4)=atan2d(-R36(2,3),-R36(1,3));
end






if R36(3,2)<0
        J(6)=atan2d(-R36(3,2),R36(3,1))-180;
    else
        J(6)=atan2d(-R36(3,2),R36(3,1))+180;
    end

if R36(3,2)<0
        J(6)=atan2d(R36(3,2),-R36(3,1))+180;
    else
        J(6)=atan2d(R36(3,2),-R36(3,1))-180;
    end
en