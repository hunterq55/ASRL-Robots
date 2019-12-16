function plotCoupled(orbitReference,pose_GV,)
%[pose_GV,error_GV,pos_AR2_W,error_AR2_W,traj_AR2_W,traj_AR2_G,time,offset]

%pose_GV in meters

%pos_AR2_W in mm

%traj_AR2_W in mm

%traj_AR2_G in meters

orbitMeasured = zeros(size(orbitReference));

orbitMeasured(:,1) = pos_AR2_G(:,2)+21.12*1000*cosd(30);
orbitMeasured(:,2) = ;


%% Plotting Position Graph
figure
hold on
plot3(orbitReference(:,1),orbitReference(:,2),orbitReference(:,3));
plot3();
hold off

%% Plotting Error Graphs
error=orbitReference-orbitMeasured;


end