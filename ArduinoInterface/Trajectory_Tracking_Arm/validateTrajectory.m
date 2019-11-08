function [total,J(1),J(2),J(3),J(4),J(5),J(6)] = validateTrajectory(trajectory)
%VALIDATETRAJECTORY Takes a trajectory in joint frames and determines validity.
%   trajectory is specified as a 13 column array, with the first column = time,
%   the subsequent 6 columns = angular position of each joint in radians,
%   and the final 6 columns = angular velocity of each joint in radians/sec.
%   total will return 1 if entire trajectory is valid, 0 otherwise. The
%   remaining 6 return values will return 1 if the trajectory is valid for that
%   joint, otherwise the difference between the trajectory and the limit for the
%   largest trajectory overshoot for that joint.

degToRad = (pi/180);

% Counter clockwise limits from the zero
CCWLimit(1) = (170)*degToRad;
CCWLimit(2) = (42)*degToRad;
CCWLimit(3) = (89)*degToRad;
CCWLimit(4) = (165)*degToRad;
CCWLimit(5) = (105)*degToRad;
CCWLimit(6) = (155)*degToRad;

% Clockwise limits from the zero
CWLimit(1) = -(170)*degToRad;
CWLimit(2) = -(90)*degToRad;
CWLimit(3) = -(51)*degToRad;
CWLimit(4) = -(165)*degToRad;
CWLimit(5) = -(105)*degToRad;
CWLimit(6) = -(155)*degToRad;

J(6) = zeros(6);

for i = 1:6
  for j = 1:length(trajectory(:,i))
    if trajectory(j,i) >= CCWLimit(i)
      diff = trajectory(j,i) - CCWLimit(i);
      if diff > abs(J(i)
        J(i) = diff;
      end
    elseif trajectory(j,i) <= CWLimit(i)
      diff = trajectory(j,i) - CWLimit(i);
      if abs(diff) > abs(J(i))
        J(i) = diff;
      end
    end
  end
end

total = 1;
for i = 1:6
  if abs(J(i)) > 0;
    total = 0;
    break
  end
end

end
