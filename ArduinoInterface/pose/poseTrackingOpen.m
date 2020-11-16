function qSaved = poseTrackingOpen(path_AR2_J,Stepper1)
%path is the position of the arm that you want to initially drive the arm
%to and hold for the duration of the demonstration
%path_AR2_J is of length (1,1:6)


%Stepper1 is the stepper motor object that defines the stepper motors in
%matlab using the custom library

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
Robot = SerialLink(L);

%% Arm initialization
statesArray_AR2_J = [path_AR2_J(1),path_AR2_J(2),path_AR2_J(3)...
               path_AR2_J(4),path_AR2_J(5),path_AR2_J(6)...
               .25,.25,.25,.25,.25,.25];
Stepper1.updateStates(statesArray_AR2_J);

command0_AR2_J = path_AR2_J(1:6);

[command0_AR2_W_pos, command0_AR2_W_ori] = AR2FKZYZ(command0_AR2_J);

%Gains
Kp = eye(3);
Ko = eye(3);

%% Path Definitons - updated per experiment, need a better implementation for this
function xdot_r = xdot_ref(t)
    xdot_coef = 10;
%     xdot_coef = 0;
    xdot_r = [xdot_coef*cos(t); xdot_coef*cos(t); xdot_coef*cos(t)];
end

function theta_ref = theta_ref(t)
%     thetr = 5*pi/180*sin(2*pi/10/4.*t) + 60*pi/180;
    thetr=0;
    theta_ref = [thetr; thetr; thetr];
end

function thetadot_ref = thetadot_ref(t)
%     thetr_dot = 5*pi/180.*cos(2*pi/10/4.*t);
    thetr_dot=0;
    thetadot_ref = [thetr_dot; thetr_dot; thetr_dot];
end

%% NatNet Connection
% not needed for open loop

% natnetclient = natnet;
% natnetclient.HostIP = '127.0.0.1';
% natnetclient.ClientIP = '127.0.0.1';
% natnetclient.ConnectionType = 'Multicast';
% natnetclient.connect;
% 
% if ( natnetclient.IsConnected == 0 )
% 	fprintf( 'Client failed to connect\n' )
% 	fprintf( '\tMake sure the host is connected to the network\n' )
% 	fprintf( '\tand that the host and client IP addresses are correct\n\n' )
% 	return
% end
% 
% model = natnetclient.getModelDescription;
% if ( model.RigidBodyCount < 1 )
% 	return
% end

%% Precalculations
%Ri- inital orentation
%Rf - final orentation

%Rotiation matrix  Rif=[Rix, Riy, Riz]'*[Rfx, Rfy, Rfz] = [1 2 3;
%                                                          4 5 6;
%                                                          7 8 9;];
%for Ri=Rf, Rif=I
Rif=eye(3);

nuef=acos((Rif(1,1)+Rif(2,2)+Rif(3,3)-1)/2);     %angle of rotation about axis r
r=1/(2*sin(nuef) * [Rif(3,2)-Rif(2,3);Rif(1,3)-Rif(3,1);Rif(2,1)-Rif(1,2);]);      %unit vector of the axis of rotation

%eul vectors are defined by the orentation of the end effector in terms of zyx rotations
    %reference eul angle defined by PHI, THETA, PSI.

eul0_ref=command0_AR2_W_ori;
euldot0_ref=[0;0;0;];

%these change based on the path
% eul0_ref=command0_AR2_W_ori;
% euldot0_ref=[0;0;0;];

Binv = eul2jac(eul0_ref);
omega_ref = Binv*euldot0_ref;
C_ref = eul2r(eul0_ref');

%% Final Checks - Before proceeding, make sure you don't break anything 
disp('Final Checks Before Experiment')
pause(2)
disp(' ')
disp('Press Any Key to Continue')
disp(' ')
disp('Rigid Body Defined in Motive?')
pause
disp('Weights In Place?')
pause
disp('Are you Ready? Experiment Will Start Immediately After Key Press.')
pause
disp('Executing!')

%% Main
i=1;
tic
while(toc<10)  
    %on first iteration, initialize variables that constantly update
    if (i == 1)
        %%FIX THESE VARIABLES
        err = getError_init(command0_AR2_W_pos, eul0_ref, command0_AR2_J);
        ep=err(1:3);
        eo=err(4:6);
        q=command0_AR2_J;
        x=[q; ep; eo];
    end
    tTime=toc;
    
%     xdot_ref = [xdot_coef*cos(tTime); xdot_coef*cos(tTime); xdot_coef*cos(tTime)];
%     tr = 5*pi/180*sin(2*pi/10/4.*tTime) + 60*pi/180;
%     tr=0;
%     theta_ref = [tr; tr; tr];
%     tr_dot = 5*pi/180.*cos(2*pi/10/4.*tTime);
%     tr_dot=0;
%     thetadot_ref = [tr_dot; tr_dot; tr_dot];



%     calculate xdot_global theta_global(orientaiton) thetadot_(global) through forward kinematics
%     this is where the loop will be closed

    

    %timestep
    h = 0.01;
    
%     basis for RK4 solver
%     k_1 = xdot;
%     k_2 = xdot+0.5*h*k_1;
%     k_3 = xdot+0.5*h*k_2;
%     k_4 = xdot+k_3*h;
%     x = xdot + ((1/6)*(k_1+2*k_2+2*k_3+k_4)*h); 

    k_1 = AR2KinDE(x,xdot_ref(tTime),theta_ref(tTime),thetadot_ref(tTime));
    k_2 = AR2KinDE(x+0.5*h*k_1,xdot_ref(tTime+0.5*h),theta_ref(tTime+0.5*h),thetadot_ref(tTime+0.5*h));
    k_3 = AR2KinDE((x+0.5*h*k_2),xdot_ref(tTime+0.5*h),theta_ref(tTime+0.5*h),thetadot_ref(tTime+0.5*h));
    k_4 = AR2KinDE((x+k_3*h),xdot_ref(tTime+h),theta_ref(tTime+h),thetadot_ref(tTime+h));
    x = x + ((1/6)*(k_1+2*k_2+2*k_3+k_4)*h); 

    q=x(1:6);
    q_dot=k_1(1:6);
    err=x(7:12);

    qSaved(i,:)= [tTime, q', q_dot',err'];
    
    statesArray_AR2_J = [q(1),q(2),q(3),q(4),q(5),q(6),q_dot(1),q_dot(2),q_dot(3),q_dot(4),q_dot(5),q_dot(6)];
    Stepper1.updateStates(statesArray_AR2_J);

    
%   should we close the loop here?
    %update after
%     J = JacobionAR2(q);

%     J = JacobionAR2tool(q);
    %these will be read from the camera system
%     xdot_ref=J*qdot;
%     [~, theta_ref] = AR2fk(q);
%     [~, thetadot_ref] = AR2fk(qdot);

%     [~, theta_ref] = AR2fkine(q);
%     [~, thetadot_ref] = AR2fkine(qdot);
    
    i=i+1;
end
Stepper1.default("REST");
figure(1)
plot(qSaved(:,1),qSaved(:,2:7)*180/pi)
xlabel('time [sec]')
ylabel('Configuration variables [deg]')
legend('q_1', 'q_2', 'q_3', 'q_4', 'q_5', 'q_6')


end
