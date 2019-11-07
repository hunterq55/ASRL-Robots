function [path] = trajectoryTrackingArm(path,Stepper1)
% This function takes a path, specified as 6 angle states followed by six
% angular velocity states (rad,rad/s) for each joint. 
% Stepper1 is a stepper motor object for one of
% the joints on the arm.



pause(5);
joint2Step(1) = 
joint2Step(2) = 
joint2Step(3) = 
joint2Step(4) = 
joint2Step(5) =
joint2Step(6) =

for i = 2:13
    path(:,i) = path(:,i)*joint2Step(i);
end

statesArray = [path(1,2),-path(1,3),-path(1,4)...
               path(1,5),path(1,6),path(1,7)...
               .25,-.25,-.25,.25,.25,.25];
Stepper1.updateStates(statesArray);
pause(15);

%Main Loop
index = 1;
tic;
while(toc <= path(end,1))
    if (toc >= path(index,1))
                
        statesArray = [path(index,2),path(index,3),-path(index,4)...
                       path(index,5),path(index,6),path(index,7)...
                       path(index,8),path(index,9),-path(index,10)...
                       path(index,11),path(index,12),path(index,13)];       
        Stepper1.updateStates(statesArray);
        index = index + 1;
    end
end

%Set steppers back to zero
Stepper1.updateStates([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]);

end

