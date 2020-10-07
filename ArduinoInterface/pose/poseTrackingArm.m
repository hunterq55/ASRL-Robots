function poseTrackingArm(path_AR2_J,Stepper1)
%path is the position of the arm that you want to initially drive the arm
%to and hold for the duration of the demonstration
%path_AR2_J is of length (1,1:6)


%Stepper1 is the stepper motor object that defines the stepper motors in
%matlab using the custom library

%% Arm initialization
statesArray_AR2_J = [path_AR2_J(1),path_AR2_J(2),path_AR2_J(3)...
               path_AR2_J(4),path_AR2_J(5),path_AR2_J(6)...
               .25,.25,.25,.25,.25,.25];
Stepper1.updateStates(statesArray_AR2_J);

command0_AR2_J = path_AR2_J(1:6);

[command0_AR2_W_pos, command0_AR2_W_ori] = AR2fk(command0_AR2_J);

%Gains
Kp = eye(3);
Ko = eye(3);

%% NatNet Connection

%Before proceeding, final checks that experiment can be run

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

natnetclient = natnet;
natnetclient.HostIP = '127.0.0.1';
natnetclient.ClientIP = '127.0.0.1';
natnetclient.ConnectionType = 'Multicast';
natnetclient.connect;

if ( natnetclient.IsConnected == 0 )
	fprintf( 'Client failed to connect\n' )
	fprintf( '\tMake sure the host is connected to the network\n' )
	fprintf( '\tand that the host and client IP addresses are correct\n\n' )
	return
end

model = natnetclient.getModelDescription;
if ( model.RigidBodyCount < 1 )
	return
end


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

Binv = eul2jac(eul0_ref);
omega_ref = Binv*euldot0_ref;
C_ref = eul2r(eul0_ref');


%Precalculations are done.

%% Main
i=1;
tic
while(toc<60)
    data = natnetclient.getFrame;
    if (isempty(data.RigidBody(1)))
                disp("AR2 Lost Connection");
% 			fprintf( '\tPacket is empty/stale\n' )
% 			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
            Stepper1.default("REST");
            return
    end
    yaw_AR2 = data.RigidBody(1).qy;
    pitch_AR2 = data.RigidBody(1).qz;
    roll_AR2 = data.RigidBody(1).qx;
    scalar = data.RigidBody(1).qw;
    quat = quaternion(roll_AR2,yaw_AR2,pitch_AR2,scalar);
    qRot = quaternion(0,0,0,1);
    quat = mtimes(quat,qRot);
%     eul = EulerAngles(quat,'zyx');
    eul = quat2eul(quat,'zyx');

    C = eul2r(eul); %measured from cameras
    
    %on first iteration, initialize variables that constantly update
    if (i == 1)
        %%FIX THESE VARIABLES
        err = getError_init(command0_AR2_W_pos, eul0_ref, command0_AR2_J);
        ep=err(1:3);
        eo=err(4:6);
        q=command0_AR2_J;
        x=[q; ep; eo];
    end
    
    xdot_ref = zeros(3,1);
    theta_ref = command0_AR2_W_ori;
    thetadot_ref = zeros(3,1);
    
    %timestep
    h = 0.01;
    
    k_1 = AR2KinDE(x,xdot_ref,theta_ref,thetadot_ref);
    q_dot=k_1(1:6);
    k_2 = AR2KinDE(x+0.5*h*k_1,xdot_ref,theta_ref,thetadot_ref);
    k_3 = AR2KinDE((x+0.5*h*k_2),xdot_ref,theta_ref,thetadot_ref);
    k_4 = AR2KinDE((x+k_3*h),xdot_ref,theta_ref,thetadot_ref);
    x = x + ((1/6)*(k_1+2*k_2+2*k_3+k_4)*h); 
    

%     k_1 = xdot;
%     k_2 = xdot+0.5*h*k_1;
%     k_3 = xdot+0.5*h*k_2;
%     k_4 = xdot+k_3*h;
%     x = xdot + ((1/6)*(k_1+2*k_2+2*k_3+k_4)*h); 
%     
    q=x(1:6);
    err=x(7:12);
    
    ep=err(1:3);
    eo=err(4:6);
    
%     J = JacobionAR2(q);
    statesArray_AR2_J = [q(1),q(2),q(3),q(4),q(5),q(6)...
                        q_dot(1),q_dot(2),q_dot(3),q_dot(4),q_dot(5),q_dot(6)];
    Stepper1.updateStates(statesArray_AR2_J);

    i=i+1;
end



end