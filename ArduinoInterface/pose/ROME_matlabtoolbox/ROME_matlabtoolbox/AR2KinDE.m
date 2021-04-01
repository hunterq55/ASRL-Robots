% Function to propagte the kinematics of AR2 6 revolute joint robotic
% mamipulator
function xdot = AR2KinDE(t, x0)
%% Reference Pose and Velocities
global manueverTime
global Robot
% x_ref_coef = 10;
% % x_ref = [x_ref_coef*sin(t)+200; 0*sin(t)+100; 0*sin(t)+200]; 
% xdot_ref = [x_ref_coef*cos(t); x_ref_coef*cos(t); x_ref_coef*cos(t)];
% tr = 5*pi/180*sin(2*pi/10/4.*t) + 60*pi/180;
% theta_ref = [tr; tr; tr];
% tr_dot = 5*pi/180.*cos(2*pi/10/4.*t);
% thetadot_ref = [tr_dot; tr_dot; tr_dot];


q_init = [0.2;-1.396263401595464;1.570796326794897;0.2;0.2;0.2];


[initPos,initOri] = AR2FKZYZ(q_init);


x_ref_coef = 100;
x_ref = [0*sin(t)+initPos(1); 0*sin(t)+initPos(2); x_ref_coef*cos(pi*t/manueverTime)+initPos(3)]; 
x_ref = [x_ref_coef*sin(t)+initPos(1); x_ref_coef*sin(t)+initPos(2); x_ref_coef*sin(t)+initPos(3)]; 
x_ref = [initPos(1);initPos(2);initPos(3)];


xdot_coef = 100;
xdot_ref = [0*cos(t); 0*cos(t); -xdot_coef*pi/manueverTime*sin(pi*t/manueverTime)];
xdot_ref = [xdot_coef*cos(t);xdot_coef*cos(t); xdot_coef*cos(t)];
xdot_ref = [0;0;0];

thetr = 105*(pi/180)*(sin((pi*t/manueverTime)-90*(pi/180)));
thetr = pi/4*sin(t);
theta_ref = [initOri(1); thetr+initOri(2); initOri(3)];
theta_ref = [thetr+initOri(1); thetr+initOri(2); thetr+initOri(3)];
theta_ref = [initOri(1);initOri(2);initOri(3)];

thetr_dot = 105*(pi/180)*pi/manueverTime*(cos((pi*t/manueverTime)-90*(pi/180)));
thetr_dot = pi/4*cos(t);
thetadot_ref = [thetr_dot; thetr_dot; thetr_dot];
thetadot_ref = [0; 0; 0];

Binv = eul2jac(theta_ref);
omega_ref = Binv*thetadot_ref;
% fprintf('%d\n',omega_ref*180/pi)
%% System variables
q = x0(1:6);
ep = x0(7:9);
eo = x0(10:12);
J = Jacobian0_analytical(q);
[~, theta] = AR2FKZYZ(q);
C_ref = eul2r(theta_ref');
Crot = eul2r(theta');
[~,L] = getOrientErr(C_ref, Crot);
omega_ref;
Kp = 1*eye(3);
Ko = 1*eye(3);
%% Differential Equations
qdot = pinv(J)*[xdot_ref + Kp*ep; pinv(L)*(L'*omega_ref + Ko*eo)];
errdot = [xdot_ref; L'*omega_ref] - [eye(3), zeros(3); zeros(3), L]*J*qdot;
xdot = [qdot; errdot];
end


