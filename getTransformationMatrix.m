function [offset] = getTransformationMatrix(theta,rotation)
%GETTRANSFORMATION This function obtains the transformation from the global
%frame to the AR2 workspace using the optiTrack camera system. Theta is
%specified as a 6x1 matrix containing the current joint angle states.
%   Detailed explanation goes here

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

initialStatesWork = manipFK(theta');
initialStatesWork(4:6) = 0;
%rotation matrix for how global rotates to reach work frame
rot=[cos(rotation) 0 0;
     0 sin(rotation) 0
     0      0     1];
%% Obtaining global frame position for 10 seconds and averaging
index = 1;
tic
while toc <= 10
    data = natnetclient.getFrame;
        if (isempty(data.LabeledMarker(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end
    statesWorld(index,1:6) = [data.LabeledMarker(1).x data.LabeledMarker(1).z data.LabeledMarker(1).y 0 0 0]*1000;
    index = index + 1;
end

averageStatesWorld = sum(statesWorld)/length(statesWorld);
offset = averageStatesWorld\rot - initialStatesWork';

end

