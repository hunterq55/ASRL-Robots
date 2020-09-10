function poseTrackingArm(path_AR2_J,Stepper1)
%path is the position of the arm that you want to initially drive the arm
%to and hold for the duration of the demonstration
%path_AR2_J is of length (1,1:6)


%Stepper1 is the stepper motor object that defines the stepper motors in
%matlab using the custom library

pause(5);

%% NatNet Connection
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

%% Setup
% Arm initialization
statesArray_AR2_J = [path_AR2_J(1,2),path_AR2_J(1,3),path_AR2_J(1,4)...
               path_AR2_J(1,5),path_AR2_J(1,6),path_AR2_J(1,7)...
               .25,.25,.25,.25,.25,.25];
Stepper1.updateStates(statesArray_AR2_J);

command0_AR2_J = path_AR2_J(1,1:6);

command0_AR2_W = AR2fk(command0_AR2_J);

%Gains
Kp = eye(3);
Ko = eye(3);

%% Main
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
eul0_ref=command0_AR2_w(4:6);
euldot0_ref=[0;0;0;];

Binv = eul2jac(eul0_ref);
omega_ref = Binv*euldot0_ref;
C_ref = eul2r(eul0_ref');


i=1;
while(true)
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
    eul = EulerAngles(quat,'zyx');
    
    Crot = eul2r(eul'); %measured from cameras
    
    %on first iteration, initialize variables that constantly update
    if (i == 1)
        %%FIX THESE VARIABLES
        err = getError_init(command0_AR2_W(1:3), eul0_ref, command0_AR2_J);
        ep=err(1:3);
        eo=err(4:6);
        J = JacobionAR2(command0_AR2_J);
    end
    
    % Vectors of the rotation matricies
    nd = C_ref(:,1);
    sd = C_ref(:,2);
    ad = C_ref(:,3);
    ne = C(:,1);
    se = C(:,2);
    ae = C(:,3);
    % Skew Symmetric matrix representation
    S_nd = Vec2Skew(nd);
    S_sd = Vec2Skew(sd);
    S_ad = Vec2Skew(ad);
    S_ne = Vec2Skew(ne);
    S_se = Vec2Skew(se);
    S_ae = Vec2Skew(ae);
    % Ouputs
    eo = 0.5*(cross(ne,nd) + cross(se,sd) + cross(ae,ad));
    L = -0.5*(S_nd*S_ne + S_sd*S_se + S_ad*S_ae);
    
    %Solving Diff Eq
    qdot = pinv(J)*[xdot_ref + Kp*ep; pinv(L)*(L'*omega_ref + Ko*eo)]; %qdot - angle of joints vel
    errdot = [xdot_ref; L'*omega_ref] - [eye(3), zeros(3); zeros(3), L]*J*qdot; %error vel
    xdot = [qdot; errdot]; %full output vel
    
    %HOW DO I SOLVE THIS DIFF EQ?????
    %
    %
    %
    %
    %
    %
    %
    %
    
    
    ep=err(1:3);
    eo=err(4:6);
    J = JacobionAR2(q);
    i=i+1;
end



end