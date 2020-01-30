

%copied from ar2_kinematics.m - editted to work good
% --- Executes 
function J=ar2ikine(cur,T,Robot)
%inputs
%cur - current angles vector
%cur(1) = J1 theta_1
%cur(2) = J2 theta_2
%cur(3) = J3 theta_3
%cur(4) = J4 theta_4
%cur(5) = J5 theta_5
%cur(6) = J6 theta_6


% L_1 = 20;
% L_2 = 50;
% L_3 = 40;
% 
% L(1) = Link([0 L_1 0 pi/2]);
% L(2) = Link([0 0 L_2 0]);
% L(3) = Link([0 0 L_3 0]);
%link def
%[theta d a alpha]

% T = [1 0 0 px;
%      0 1 0 py;
%      0 0 1 pz;
%      0 0 0 1];
%  
%T = transl(goal(1),goal(2),goal(3)) * rpy2tr(goal(4), goal(5), goal(6), 'deg');
J = Robot.ikine(T, [cur(1) cur(2) cur(3) cur(4) cur(5) cur(6)]);

%Robot.plot(J*pi/180);



% th_1 = str2double(handles.theta_1.String)*pi/180;
% th_2 = str2double(handles.theta_2.String)*pi/180;
% th_3 = str2double(handles.theta_3.String)*pi/180;
% th_4 = str2double(handles.theta_4.String)*pi/180;
% th_5 = str2double(handles.theta_5.String)*pi/180;
% th_6 = str2double(handles.theta_6.String)*pi/180;
% 
% Qf = [th_1 th_2 th_3 th_4 th_5 th_6];
% 
% 
% 
% L(1) = Link([0 169.77 64.2 -1.5707], 'R');
% L(2) = Link([0 0 305 0], 'R');
% L(3) = Link([0 0 0 1.5707], 'R');
% L(4) = Link([0 -222.63 0 -1.5707], 'R');
% L(5) = Link([0 0 0 1.5707], 'R');
% L(6) = Link([0 -36.25 0 0], 'R');
% 
% Robot = SerialLink(L);
% Robot.name = "AR2";
% 
% Qi = [0 0 0 0 0 0];
% t = 0:0.1:2;
% 
% 
% q = jtraj(Qi, Qf, t);
% Robot.plot(q);
% 
% T = Robot.fkine(Qf);
% 
% handles.pos_x.String = num2str(T.t(1));
% handles.pos_y.String = num2str(T.t(2));
% handles.pos_z.String = num2str(T.t(3));