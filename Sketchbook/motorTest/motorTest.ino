#include <FinalMotorLibrary.h>

double setpoint = (3.0*3.14),setpoint2 = 3.0;

double input1, output1,input2, output2,input3, output3;

double Kp = 1.25,Ki = 31.25,Kd = 0.0;
Adafruit_MotorShield AFMS = Adafruit_MotorShield();

Motor Motor1 = Motor(1,2,23,3072,&input1,&output1,&setpoint,Kp,Ki,Kd,DIRECT);
Motor Motor2 = Motor(2,19,27,3072,&input2,&output2,&setpoint,Kp,Ki,Kd,DIRECT);
Motor Motor3 = Motor(3,18,25,3072,&input3,&output3,&setpoint,Kp,Ki,Kd,DIRECT);


void setup()
{
    Serial.begin(9600);
    
    AFMS.begin();

    Motor1.setAfms(&AFMS);
    Motor1.registerMotor();

    Motor2.setAfms(&AFMS);
    Motor2.registerMotor();

    Motor3.setAfms(&AFMS);
    Motor3.registerMotor();
    

    delay(2000);

    //Motor1.setDuty(0);
}

void loop()
{

    Motor1.updateMotor(); 
    //Motor1.printPIDInfo();
    Motor2.updateMotor();
    //Motor2.printPIDInfo();
    Motor3.updateMotor(); 
    //Motor3.printPIDInfo();
    
}
