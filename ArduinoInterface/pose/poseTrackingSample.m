%1 get init pose

%2 pre calculations

%3 in loop solve ode


%1 + 2 out of for loop

%data.RigidBody(2)

%assume J is defined here

thetaIC=[q1;q2;q3;q4;q5;q6];

theta_ref = thetaIC;
thetadot_ref = zeros(6,1);

%add angles
traj_AR2_G(index,:) = [data.RigidBody(2).z data.RigidBody(2).x data.RigidBody(2).y]*1000;

%fix offset, how to do transform? do i need to do a C matrix transform
%again?
traj_AR2_W(index,:) = traj_AR2_G(index,:) - offset;


[x_init, theta_init] = AR2fkine(thetaIC);

Binv = eul2jac(theta_ref);
omega_ref = Binv*thetadot_ref;

%assuming inital error is zero

X0=zeros(12,1);

% 3 - in ode loop
%consider changing this to make faster
[~, theta] = AR2fkine(q);

C_ref = eul2r(theta_ref');
Crot = eul2r(theta');
[~,L] = getOrientErr(C_ref, Crot);

%gains
Kp = eye(3);
Ko = eye(3);

qdot = pinv(J)*[xdot_ref + Kp*ep; pinv(L)*(L'*omega_ref + Ko*eo)];
errdot = [xdot_ref; L'*omega_ref] - [eye(3), zeros(3); zeros(3), L]*J*qdot;
xdot = [qdot; errdot];

%send q dot directly

%replace whatever is above when fixed
traj_AR2_G(index,:) = [data.RigidBody(2).z data.RigidBody(2).x data.RigidBody(2).y]*1000;
traj_AR2_W(index,:) = traj_AR2_G(index,:) - offset;
 
% to find pose
%     IK
%         vel > thetad > integrate > theta
%         

%find q using ODE methods

statesArray_AR2_J = [command_AR2_J(index,1),command_AR2_J(index,2),command_AR2_J(index,3)...
                       command_AR2_J(index,4),command_AR2_J(index,5),command_AR2_J(index,6)...
                       commandDot_AR2_J(1),commandDot_AR2_J(2),commandDot_AR2_J(3)...
                       commandDot_AR2_J(4),commandDot_AR2_J(5),commandDot_AR2_J(6)];

%repeat start of 3