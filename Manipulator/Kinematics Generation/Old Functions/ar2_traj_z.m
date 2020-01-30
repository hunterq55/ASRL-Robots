%proof of concept for creating a theta dot velocity curve.
%created for the trajectory tracking problem

%based off of cordinate system of ar2_kinematics gui calculations
%from z= 200 to z= -200 everything else fixed

%this is a simple manuever that runs the z axis from pos z=200 to z= -200
%in 1 step incriments in 12.5664 seconds

%all angle units are in rads
tic
L(1) = Link([0 169.77 64.2 -1.5707], 'R');
L(2) = Link([0 0 305 0], 'R');
L(3) = Link([-1.5707 0 0 1.5707], 'R');
L(4) = Link([0 -222.63 0 -1.5707], 'R');
L(5) = Link([0 0 0 1.5707], 'R');
L(6) = Link([pi -36.25 0 0], 'R');

Robot = SerialLink(L);
Robot.name = 'AR2_Robot';
%-------------------------------------------------
%time of manuever in seconds
t=60;

load('zmeo10.mat');

chi=length(z);

%timesteps between points
ts=t/length(z);
%-------------------------------------------------
%create each transformation matrix

T = cell(length(z),1);
for i=1:length(z)
    %created array transformation matrices 
    Tm = transl(369.2,0,z(i))* rpy2tr(0, 0, 0, 'rad');
    T{i} = Tm;
end
%-------------------------------------------------
%initial theta positions at start of maneuver
theta0 = (pi/180)*[0.0043219,-54.5667,19.4159-90,-1.0845e-10,35.1508,-0.0043219+180];

%theta0(3)=theta0(3)-90;
%theta0(6)=theta0(6)+180;

%-------------------------------------------------
%calculate joint angles
J = cell(length(T),1);

for i=1:length(T)
    %calculates the angles of each motor
    %if first time, run based on inital
    if i == 1
        Jm=ar2ikine(theta0,T{i},Robot);
    else
        %calculates the angles of each motor
        Jm=ar2ikine(J{i-1},T{i},Robot);
        %stores each angle into a cell array
    end
    J{i}=Jm;
end
%-------------------------------------------------

%calculate velocities
thetad=cell(length(T),1);
for i=1:length(z)
    for j=1:6
        if i == 1
            thetad{i}(j,1) = 0;
        elseif i == 2
            %forward finite difference first step
            thetad{i}(j,1) = (J{i+1}(j)-(J{i}(j)))/ts;
        elseif i < 3000
            %central finite
            thetad{i}(j,1) = (J{i+1}(j)-(J{i-1}(j)))/(2*ts);
        elseif i == length(z)
            thetad{i}(j,1) = 0;
        end
    end
end
%factor at which you want to refine frequency of thetas reported
%hz
sizef=1;

theta=J;
timestep=t/length(theta);
%thetad=downsample(thetad,chi/(t*2));
%thetad unit - rad/s

for i=1:t/timestep
    V=thetad{i,1}';
    F{i}=V;
    F{i}=F{i}';
end

theta=cell2mat(theta);
thetad=cell2mat(F);

thetad=thetad';

tv=zeros(t/timestep,1);

for i=1:t/timestep
    tv(i)=timestep*i;
end

path=[tv theta thetad];

toc