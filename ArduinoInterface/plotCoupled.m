function plotCoupled(orbitReference,traj_AR2_G,time)
%traj_AR2_G in mm
%orbitReference in meters
orbitMeasured = zeros(size(orbitReference));

orbitMeasured(:,1) = traj_AR2_G(:,2);
orbitMeasured(:,2) = -traj_AR2_G(:,1);
orbitMeasured(:,3) = traj_AR2_G(:,3);

orbitMeasured=orbitMeasured/1000;

offset=orbitReference(1,:)-orbitMeasured(1,:);

for i = 1:length(orbitMeasured(:,1))
    
orbitMeasured(i,:) = orbitMeasured(i,:) + offset;

end
%% Plotting Position Graph
figure
hold on
plot3(orbitReference(:,1),orbitReference(:,2),orbitReference(:,3));
plot3(orbitMeasured(:,1),orbitMeasured(:,2),orbitMeasured(:,3));
hold off

%% Plotting Error Graphs
error=orbitReference-orbitMeasured;
figure
plot(time,error(:,1)*1000)

figure
plot(time,error(:,2)*1000)

figure
plot(time,error(:,3)*1000)

end