function ClosedLoopCircleTracking

%%Setup

%Bluetooth address = 98D311FC1C8E

%Arduino
%%a = arduino;
%Motor1 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D2','D23'});
%Motor2 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D19','D27'});
%Motor3 = addon(a,'MatlabMotorLibrary/EncoderAddon',{'D18','D25'});

%NatNet

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

%Rotation matrix definitions
L = .115;
theta = 0;
index = 0;
R = .05;

pTheta1 = -sin(theta);
pTheta2 = cos(theta);
pTheta3 = L;
pTheta4 = -sin((pi/3)-theta);
pTheta5 = -cos((pi/3)-theta);
pTheta6 = L;
pTheta7 = sin((pi/3)+theta);
pTheta8 = -cos((pi/3)+theta);
pTheta9 = L;

%Outer loop gains
Kp = 5;
Ki = .2;

tic;
while(1)  
    if (toc >= .02*index)
        
        xPath = cos(.25*toc);
        yPath = sin(.25*toc);
        thetaPath = 0;
        
        xPathPrime = -.25*sin(.25*toc);
        yPathPrime = .25*cos(.25*toc);
        thetaPathPrime = 0;
        
        metSec1 = pTheta1*(xPathPrime) + pTheta2*(yPathPrime) + pTheta3*(thetaPathPrime); 
        metSec2 = pTheta4*(xPathPrime) + pTheta5*(yPathPrime) + pTheta6*(thetaPathPrime);
        metSec3 = pTheta7*(xPathPrime) + pTheta8*(yPathPrime) + pTheta9*(thetaPathPrime);
        
        %%Outer loop
        
        %NatNet  
        data = natnetclient.getFrame; % method to get current frame
		
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end
        
        xPosition = data.RigidBody(1).x*1000;
        yPosition =  data.RigidBody(1).y*1000;
        thetaPosition = 0;
        
        xError = xPosition - xPath;
        yError = yPosition - yPath;
        thetaError = thetaPosition - thetaPath;
        
        xErrorSum = xErrorSum + xError*.02;
        yErrorSum = yErrorSum + yError*.02;
        thetaErrorSum = thetaErrorSum + thetaError*.02;
        
        setpointRadSec1 = metSec1/R;
        setpointRadSec2 = metSec2/R;
        setpointRadSec3 = metSec3/R;
        
        
        Motor1.updateMotors([setpointRadSec1,setpointRadSec2,setpointRadSec3]);
        
        index = index + 1;
    end   
end
end