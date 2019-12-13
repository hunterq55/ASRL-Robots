function [pos,e,traj,time] = trajectoryTrackingCoupled(path_gv,path_arm,Motor1,Stepper1,refTraj)

pause(15);

%NatNet Connection
natnetclient = natnet;
natnetclient.HostIP = '127.0.0.1';
natnetclient.ClientIP = '127.0.0.1';
natnetclient.ConnectionType = 'Multicast';
natnetclient.connect;

validity = validateTrajectory(path_arm);
if validity(1) == 0
  disp('The given trajectory is invalid');
  return
end

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

%Platform Geometry
L = .13; %distance from platform centroid to wheel
R = .05;  %radius of the wheel

%PID

Kp = 8*.5;
Ki = .4*.5;


Kp = [Kp 0 0;
      0 Kp 0;
      0 0  -Kp;]; %Gains for theta must be negative, not sure why yet

Ki = [Ki 0 0;
      0 Ki 0;
      0 0  -Ki;];

%Main Loop
timestep = path_gv(end,1)/length(path_gv(:,1)); %This is currently set equal to the interval for calculating
                %platform velocity and the inner loop PID update interval.
index = 1;
errorSum = 0;   %A forward euler integration will be performed.

%ARM Initialization

pause(5);
statesArray = [path_arm(1,2),path_arm(1,3),path_arm(1,4)...
               path_arm(1,5),path_arm(1,6),path_arm(1,7)...
               .25,.25,.25,.25,.25,.25];
Stepper1.updateStates(statesArray);
pause(10);

%% Setup: For FK and IK Functions
kp=15;    ki=2*0.038;    kd=0.4;
reference=zeros(length(refTraj(:,1)),3);
referenceVel=zeros(length(refTraj(:,2)),3);

referenceVel(:,3)=refTraj(:,2);
q=zeros(length(path_arm(:,1)),6);
q0=path_arm(1,2:7);
q(1,:)=q0;

initialStatesWork=manipFK(q0);

reference(:,1)=initialStatesWork(1);
reference(:,2)=initialStatesWork(2);


for i=1:length(refTraj(:,1))
   temp=manipFK(path_arm(i,(2:7)));
   reference(i,3)=temp(3);
end

trajectory=zeros(length(path_arm(:,1)),3);
trajectoryGlobal=zeros(length(path_arm(:,1)),3);
trajectoryVel=zeros(length(path_arm(:,1)),3);
error=zeros(length(path_arm(:,1)),3);
time=path_arm(:,1);
data = natnetclient.getFrame;

offset = getTransformation3(q0);

% initWorld = [-data.LabeledMarker(1).x -data.LabeledMarker(1).z data.LabeledMarker(1).y 0 0 0]*1000;
% initWork=reference(1,:);
% offset=initWorld-initWork;

correctedVel=zeros(length(path_arm(:,1)),3);

Ui = zeros(1,3);
index = 1;

tic;
while(toc <= path_gv(end,1))

    if (toc >= path_gv(index,1))

        trajectory = [path_gv(index,2);path_gv(index,3);path_gv(index,4)];
        trajectoryPrime = [path_gv(index,5);path_gv(index,6);path_gv(index,7)];

        data = natnetclient.getFrame;
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end

        yaw = data.RigidBody(1).qy;
        pitch = data.RigidBody(1).qz;
        roll = data.RigidBody(1).qx;
        scalar = data.RigidBody(1).qw;
        q = quaternion(roll,yaw,pitch,scalar);
        qRot = quaternion(0,0,0,1);
        q = mtimes(q,qRot);
        a = EulerAngles(q,'zyx');
        theta = a(2); %yaw angle/rotation about the vertical

        position = [data.RigidBody(1).x;-data.RigidBody(1).z;theta;];
        error_gv = position - trajectory;
        errorSum = errorSum + error*timestep;


        pTheta = [-sin(theta)               cos(theta)          L;
                  -sin((pi/3)-theta)       -cos((pi/3)-theta)   L;
                   sin((pi/3)+theta)       -cos((pi/3)+theta)   L;];

        setpointMetSec = pTheta*(trajectoryPrime - Kp*error_gv - Ki*errorSum);
        setpointRadSec = setpointMetSec/R;

		%ARM Logic
		if index == 1
            error_arm(index,:) = zeros(1,3);

            %error in pos!!!
        else
            error_arm(index,:) = reference(index,:)-trajectory(index,:);
        end
        if index == 1
            %use PID Controller:
            Up=zeros(1,3);
            Ui=zeros(1,3);
            Ud=zeros(1,3);
        elseif index == 2
            Up=kp*(error_arm(index,:));
            Ui= Ui + ki*(error_arm(index,:)*path(1,1));
            Ud=kd*((error_arm(index,:)-error_arm(index-1,:))/path(1,1));
        else
            Up=kp*(error_arm(index,:));
            Ui= Ui + ki*(error_arm(index,:)*path(1,1));
            Ud=kd*(3*(error_arm(index,:)-4*error_arm(index-1,:)+error_arm(index-2,:))/2*path(1,1));
        end   
        u=Up+Ui+Ud;
        %PID part
        correctedVel(index,:)=referenceVel(index,:)+u;
        qdtemp=trajectoryIK3(correctedVel(index,:)',q(index,:));
            
        qd=zeros(1,6);
        qd(2)=qdtemp(1);
        qd(3)=qdtemp(2);
        qd(5)=qdtemp(3);
            
        statesArray = [q(index,1),q(index,2),q(index,3)...
                       q(index,4),q(index,5),q(index,6)...
                       qd(1),qd(2),qd(3)...
                       qd(4),qd(5),qd(6)];
                    
        Stepper1.updateStates(statesArray);
        Motor1.updateMotors(setpointRadSec*1.2);
		
		q(index+1,:)=q(index,:)'+(qd'*path(1,1));

        time(index,:) = toc;
        pos(index,:) = [position(index,1:2) ];
        e(index,:) = [error_gv(index,1:2) error_arm(index,3)];
        traj(index,:) = trajectory;
        index = index + 1;
    end
end


%Set motors back to zero
Motor1.updateMotors([0.0,0.0,0.0]);


end