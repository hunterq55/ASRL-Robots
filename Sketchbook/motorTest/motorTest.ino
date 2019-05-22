#include <FinalMotorLibrary.h>

double setpoint = (3.0*3.14),setpoint2 = 3.0;

double input1, output1,input2, output2,input3, output3;



double Kp = 1.25,Ki = 31.25,Kd = 0.0;
Adafruit_MotorShield AFMS = Adafruit_MotorShield();

rMotor Motor1 = rMotor(1,2,23,3072,&input1,&output1,&setpoint,Kp,Ki,Kd,DIRECT);
rMotor Motor2 = rMotor(2,19,27,3072,&input2,&output2,&setpoint,Kp,Ki,Kd,DIRECT);
rMotor Motor3 = rMotor(3,18,25,3072,&input3,&output3,&setpoint,Kp,Ki,Kd,DIRECT);


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

    Motor1.setDuty(127);
    Motor2.setDuty(127);
    Motor3.setDuty(127);
    

    //Motor1.setDuty(0);
}

void loop()
{
      
      Motor1.setDuty(127);
      Motor2.setDuty(127);
      Motor3.setDuty(127);

     unsigned long time1;
     unsigned long time2;
   
    
       for(int i=0; < 3; i++)
       {
        time1 = millis();
        time2 = millis();
        
         while(time2 - time1 < 5000)
          {
             Motor1.getCountSec();
             Motor2.getCountSec();
             Motor3.getCountSec();

             time2 = millis();
          }
    
        time1 = millis();
        time2 = millis();
      
        while(time2 - time1 < 5000)
          {
            Motor1.setDuty(0);
            Motor2.setDuty(0);
            Motor3.setDuty(0);

            time2 = millis();
          }
       }
      
   

      Motor1.out->closeFile();
      Motor2.out->closeFile();
      Motor3.out->closeFile();
      
    //Motor1.updateMotor(); 
    //Motor1.printPIDInfo();
    //Motor2.updateMotor();
    //Motor2.printPIDInfo();
    //Motor3.updateMotor(); 
    //Motor3.printPIDInfo();


}
