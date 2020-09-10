%% AR2 robotic manipulator closed loop resolved rate algorithm
clear; close all; clc;
%% Robot Definition
d1 = 169.77;    a1 = 64.2;  alpha1 = -90*pi/180;    
d2 = 0;         a2 = 305;   alpha2 = 0;             
d3 = 0;         a3 = 0;     alpha3 = 90*pi/180;     
d4 = -222.63;   a4 = 0;     alpha4 = -90*pi/180;    
d5 = 0;         a5 = 0;     alpha5 = 90*pi/180;     
d6 = -36.25;    a6 = 0;     alpha6 = 0;  

L(1) = Link([0 d1 a1 alpha1], 'R');
L(2) = Link([0 d2 a2 alpha2], 'R');
L(3) = Link([0 d3 a3 alpha3], 'R');
L(4) = Link([0 d4 a4 alpha4], 'R');
L(5) = Link([0 d5 a5 alpha5], 'R');
L(6) = Link([0 d6 a6 alpha6], 'R');
global Robot
global xref_old
told = 0;
xref_old = zeros(3,1);
Robot = SerialLink(L);

%% Initial conditions and error calculations
ti = 0;
x_ref_init = [10*sin(ti)+200; 10*sin(ti)+100; 10*sin(ti)+200]; 
xdot_ref_init = [10*cos(ti); 10*cos(ti); 10*cos(ti)];
tr = 5*pi/180.*(2*pi/10/4*ti) + 60*pi/180;
theta_ref_init = [tr; tr; tr];
q_init = [28 -28 145 25 30 30]'*pi/180;
err = getError_init(x_ref_init, theta_ref_init, q_init);
X0 = [q_init; err];
%% Simulation Setup
tspan = [0 10];
options = odeset('RelTol',1e-8,'AbsTol',1e-10);
[t, X] = ode45(@AR2KinDE, tspan, X0, options); 
%% Output
q = X(:,1:6);
err = X(:,7:12);
%% Plots
figure(1)
plot(t,q*180/pi)
xlabel('time [sec]')
ylabel('Configuration variables [deg]')
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5', 'q_6')

for i = 1:length(t)
   ex(i) = X(i,7);
   ey(i) = X(i,8);
   ez(i) = X(i,9);
   eth1(i) = X(i,10);
   eth2(i) = X(i,11);
   eth3(i) = X(i,12);
end
figure(2)
plot(t,ex)
hold on
plot(t,ey)
hold on
plot(t,ez)
xlabel('time [sec]')
ylabel('Position error')
legend('x error', 'y error', 'z error')
figure(3)
plot(t,eth1)
hold on
plot(t,eth2)
hold on
plot(t,eth3)
xlabel('time [sec]')
ylabel('Orientation error')
legend('\theta_4 error', '\theta_5 error', '\theta_6 error')

% 
% for i = 1: length(t)
%    q = X(i,1:6);
%    [pos, orient] = AR2fkine(q);
%    x(i) = pos(1);
%    y(i) =  pos(2);
%    z(i) = pos(3);
%    th1(i) = orient(1);
%    th2(i) = orient(2);
%    th3(i) = orient(3);
% end
% 
% xr = 10*sin(t)+200; 
% tr = 5*pi/180.*sin(2*pi/10/4*t) + 60*pi/180;
% 
% figure(2)
% plot(t, xr,'r'); hold on 
% plot(t,x)
% legend('Ref', 'actual')
% 
% figure(3)
% plot(t,xr-100,'r'); hold on
% plot(t,y)
% legend('Ref', 'actual')
% figure(4)
% plot(t,xr,'r'); hold on
% plot(t,z)
% legend('Ref', 'actual')
% 
% 
% figure(5)
% plot(t,tr*180/pi,'r');
% hold on
% plot(t,th1*180/pi)
% legend('Ref', 'actual')
% 
% figure(6)
% plot(t,tr*180/pi,'r');
% hold on
% plot(t,th2*180/pi)
% legend('Ref', 'actual')
% 
% figure(7)
% plot(t,tr*180/pi,'r');
% hold on
% plot(t,th3*180/pi)
% legend('Ref', 'actual')
