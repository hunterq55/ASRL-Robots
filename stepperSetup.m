%Steps/radian for each motor
STEPPER_CONSTANT1 = 1/(.022368421*(pi/180))
STEPPER_CONSTANT2 = 1/(.018082192*(pi/180));
STEPPER_CONSTANT3 = 1/(.017834395*(pi/180));
STEPPER_CONSTANT4 = 1/(.021710526*(pi/180));
STEPPER_CONSTANT5 = 1/(.095401639*(pi/180));
STEPPER_CONSTANT6 = 1/(.046792453*(pi/180));

%Zero positions of each motor for IK, defined from limit position, radians
j1Zero = (170)*(pi/180);
j2Zero = (42)*(pi/180);
j3Zero = (51)*(pi/180); %negative, nevermind
j4Zero = (165)*(pi/180);
j5Zero = (105)*(pi/180);
j6Zero = (155)*(pi/180);

%Uncomment for arduinosetup with error messages/debug functionality
%a = arduino('com4','Mega2560','Libraries','StepperLibrary/Stepper','ForceBuild',true,'TraceOn',true);

a = arduino
Stepper1 = addon(a,'StepperLibrary/Stepper',{'D2','D3'})
Stepper2 = addon(a,'StepperLibrary/Stepper',{'D4','D5'})
Stepper3 = addon(a,'StepperLibrary/Stepper',{'D6','D7'})
Stepper4 = addon(a,'StepperLibrary/Stepper',{'D8','D9'})
Stepper5 = addon(a,'StepperLibrary/Stepper',{'D10','D11'})
Stepper6 = addon(a,'StepperLibrary/Stepper',{'D12','D13'})

Stepper1.setStates([-j1Zero*STEPPER_CONSTANT1, -200]); %Negative is clockwise
Stepper2.setStates([-j2Zero*STEPPER_CONSTANT2; -200]);%Negative is clockwise
Stepper3.setStates([j3Zero*STEPPER_CONSTANT3; 200]);   %Negative is clockwise
Stepper4.setStates([j4Zero*STEPPER_CONSTANT4; 200]);   %Positive is clockwise
Stepper5.setStates([-j5Zero*STEPPER_CONSTANT5; -200]); %Negative is clockwise
Stepper6.setStates([j6Zero*STEPPER_CONSTANT6; 200]);  %Positive is clockwise

Stepper1.calibrate();