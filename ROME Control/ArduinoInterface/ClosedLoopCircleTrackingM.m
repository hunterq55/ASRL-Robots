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
Kp = 5;
Ki = .2;


%Main Loop
timestep = .02;
index = 0;
errorSum = 0;

tic;
while(1)  
    if (toc >= timestep*index)       
        trajectory = [cos(.25*toc);sin(.25*toc);0;];
        trajectoryPrime = [-.25*sin(.25*toc);.25*cos(.25*toc);0;];
    
        data = natnetclient.getFrame;
		
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end
        
        position = [data.RigidBody(1).x*1000;data.RigidBody(1).y*1000;0;];
        error = position - trajectory;
        errorSum = errorSum + error*timestep;
        
        setpointMetSec = pTheta*(trajectoryPrime - Kp*error - Ki*errorSum);
        setpointRadSec = setpointMetSec/R;
        
        Motor1.updateMotors(setpointRadSec);
        index = index + 1;
    end
end

       
