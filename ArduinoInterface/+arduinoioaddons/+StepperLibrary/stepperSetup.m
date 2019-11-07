
%Uncomment for arduinosetup with error messages/debug functionality
%a = arduino('com4','Mega2560','Libraries','StepperLibrary/Stepper','ForceBuild',true,'TraceOn',true);

a = arduino
Stepper1 = addon(a,'StepperLibrary/Stepper',{'D2','D3'})
Stepper2 = addon(a,'StepperLibrary/Stepper',{'D4','D5'})
Stepper3 = addon(a,'StepperLibrary/Stepper',{'D6','D7'})
Stepper4 = addon(a,'StepperLibrary/Stepper',{'D8','D9'})
Stepper5 = addon(a,'StepperLibrary/Stepper',{'D10','D11'})
Stepper6 = addon(a,'StepperLibrary/Stepper',{'D12','D13'})

Stepper1.calibrate();
delay(5);

Stepper1.updateStates[0,-90*pi/180,90*pi/180,0,-90*pi/180,0...
                      .25,.25.,.25,.25,.25,.25];
delay(25);
