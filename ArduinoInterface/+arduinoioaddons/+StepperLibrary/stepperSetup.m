
% Zero positions of each motor for IK, defined from limit position
j1Zero = 0;
j2Zero = 0;
J3Zero = 0;
J4Zero = 0;
J5Zero = 0;
J6Zero = 0;

% Uncomment for arduinosetup with error messages/debug functionality
% a = arduino('com4','Mega2560','Libraries','StepperLibrary/Stepper','ForceBuild',true,'TraceOn',true);

a = arduino
Stepper1 = addon(a,'StepperLibrary/Stepper',{'D2','D3'})
Stepper2 = addon(a,'StepperLibrary/Stepper',{'D4','D5'})
Stepper3 = addon(a,'StepperLibrary/Stepper',{'D6','D7'})
Stepper4 = addon(a,'StepperLibrary/Stepper',{'D8','D9'})
Stepper5 = addon(a,'StepperLibrary/Stepper',{'D10','D11'})
Stepper6 = addon(a,'StepperLibrary/Stepper',{'D12','D13'})

Stepper1.setStates([j1Zero; 50]);
Stepper2.setStates([j2Zero; 50]);
Stepper3.setStates([j3Zero; 50]);
Stepper4.setStates([j4zero; 50]);
Stepper5.setStates([j5zero; 50]);
Stepper6.setStates([j6zero; 50]);


Stepper1.calibrate();
Stepper2.calibrate();
Stepper3.calibrate();
Stepper4.calibrate();
Stepper5.calibrate();
Stepper6.calibrate();
