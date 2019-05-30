function [pos,e,traj] = fourCircles(Motor1)

pause(5);

%NatNet Connection
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

%Platform Geometry
L = .115;
theta = 0;
R = .05;

%Rotation Matrix
pTheta = [-sin(theta)               cos(theta)          L;
          -sin((pi/3)-theta)       -cos((pi/3)-theta)   L;
           sin((pi/3)+theta)       -cos((pi/3)+theta)   L;];

%PID
Kp = 5*.1;
Ki = .2*.1;

Kp = [.5 0 0;
      0 -.5 0;
      0 0 -.5;];
Ki = [.02 0 0;
      0 -.02 0;
      0 0 -.02;];


%Main Loop
timestep = .02;
index = 0;
errorSum = 0;

tic;
while(toc <= 2*pi*4)  %will do one complete cycles
    if (toc >= timestep*index)   
       
        trajectory = [cos(.25*toc);sin(.25*toc);0;];
        trajectoryPrime = [-.25*sin(.25*toc);.25*cos(.25*toc);0;];
    
        data = natnetclient.getFrame;
		
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end
        
        yawyeet = data.RigidBody(1).qy;
        pitchyeet = data.RigidBody(1).qz;
        rollyeet = data.RigidBody(1).qx;
        scalaryeet = data.RigidBody(1).qw;
        q = quaternion(rollyeet,yawyeet,pitchyeet,scalaryeet);
        qRot = quaternion(0,0,0,1);
        q = mtimes(q,qRot);
        a = EulerAngles(q,'zyx');
        theta = a(2);

        position = [data.RigidBody(1).x;-data.RigidBody(1).z;theta;];
        error = position - trajectory;
        errorSum = errorSum + error*timestep;

        
                pTheta = [-sin(theta)               cos(theta)          L;
          -sin((pi/3)-theta)       -cos((pi/3)-theta)   L;
           sin((pi/3)+theta)       -cos((pi/3)+theta)   L;];
        
        setpointMetSec = pTheta*(trajectoryPrime - Kp*error - Ki*errorSum);
        setpointRadSec = setpointMetSec/R;
        
        Motor1.updateMotors(setpointRadSec);
        
        %Display Funct ions
        %disp(position);
        %disp(setpointRadSec);
        disp(error);
        %disp(trajectory);
        
        index = index + 1;
        pos(:,index) = position;
        e(:,index) = error;
        traj(:,index) = trajectory;
    end
end

Motor1.updateMotors([0.0,0.0,0.0])

e = transpose(e);
pos = transpose(pos);
traj = transpose(traj);
plot(e);
legend('X','Z','Theta');

% plot(pos);
% hold on;
% plot(traj);
% hold off;

end


