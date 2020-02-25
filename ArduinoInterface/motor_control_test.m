%this script will test out new functionallity to control the motors of the
%gv

%https://www.mathworks.com/help/supportpkg/arduinoio/ug/control-motors-using-adafruit-motor-shield-v2.html#AdafruitMotorShieldV2Example-4


%https://www.robotshop.com/en/12v-120-rpm-dc-motor-641.html
%need to find relation for motor speed IRL to MATLAB motor -1 to 1

a = arduino('COM3','Mega2560','Libraries','Adafruit\MotorShieldV2');

shield = addon(a,'Adafruit\MotorShieldV2');


dcm1 = dcmotor(shield,1);
dcm2 = dcmotor(shield,2);
dcm3 = dcmotor(shield,3);

dcm1.Speed = 0;
pause(2);
dcm1.Speed = 1; %speed values go from -1 to 1
pause(2);
dcm1.Speed = -1; 

dcm2.Speed = 0;
pause(2);
dcm2.Speed = 1; %speed values go from -1 to 1
pause(2);
dcm2.Speed = -1;

dcm3.Speed = 0;
pause(2);
dcm3.Speed = 1; %speed values go from -1 to 1
pause(2);
dcm3.Speed = -1;


dcm1.Speed = 0;
dcm2.Speed = 0;
dcm3.Speed = 0;

tic
for i =-1:0.02:1
    if toc < 2
        disp(i);
        break
    end
    dcm1.Speed = i;
    dcm2.Speed = i;
    dcm3.Speed = i;
    
end
toc