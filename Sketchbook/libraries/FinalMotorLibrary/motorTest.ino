#include "revisedMotorHeader.h"

double input,output,setpoint = 3.0,input2,output2,setpoint2 = 3.0;
double Kp = 2.5,Ki = 62.5,Kd = 0.0;
Adafruit_MotorShield *AFMS = new Adafruit_MotorShield();

rMotor Motor1 = rMotor(2,23,3072,&input,&output,&setpoint,Kp,Ki,Kd,DIRECT);


void setup()
{
    AFMS.begin();

    Motor1.setAfms(AFMS);

    Motor1.registerMotor();

    Serial.begin(9600);
    Serial.println("A lot of words");

}

void loop()
{
    Motor1.setDuty(150);
}
