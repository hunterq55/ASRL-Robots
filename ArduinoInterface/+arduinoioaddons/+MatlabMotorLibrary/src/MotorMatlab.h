/*MatlabMotorLibrary.h - Library for reading in and outputting optical encoder data in various units*/

#ifndef MatlabMotorLibrary_h
#define MatlabMotorLibrary_h

#include "LibraryBase.h"
#include "FinalMotorLibrary.h" //3rd party header

const char MSG_CREATE[]       PROGMEM = "MotorMatlab::pMotor[%d] = %d %d %d %f %f %f\n";
const char MSG_READ[]       PROGMEM = "MotorMatlab::pMotor[%d].read() = %d\n";
const char PID_BUGS[]        PROGMEM = "PID Output Voltage : %d\n";

#define MAX_MOTORS 4

#define MOTOR_CREATE 0x03
#define GET_COUNTS 0x02
#define GET_RAD 0x00
#define GET_RADSEC 0x01
#define GET_COUNTSSEC 0x04

//AHH GLOBAL VARIABLES
double Kp = 1.25,Ki = 31.25,Kd = 0.0;
double inputRadSec1, outputVoltage1, setpointRadSec1 = 5.0;
double inputRadSec2, outputVoltage2, setpointRadSec2 = 5.0;
double inputRadSec3, outputVoltage3, setpointRadSec3 = 5.0;

Adafruit_MotorShield AFMS = Adafruit_MotorShield();

class MotorMatlab : public LibraryBase //add-on class
{
    public:
        
    Motor* pMotor[MAX_MOTORS];
    
    public:
    MotorMatlab(MWArduinoClass& a)
    {
        libName = "MatlabMotorLibrary/EncoderAddon";
        a.registerLibrary(this);
    }
    
    void setup()
    {
        AFMS.begin();
    }
    
    void loop()
    {   
        
        if(pMotor[0] != NULL)
        {
            pMotor[0]->updateMotor();
            //pMotor[0]->printPIDInfo();
        }
         
        
        if(pMotor[1] != NULL)
        {
            pMotor[1]->updateMotor();
        }
        
        if(pMotor[2] != NULL)
        {
            pMotor[2]->updateMotor();
            //pMotor[2]->printPIDInfo();
        }
    }
    
    public:
    
    void commandHandler(byte cmdID,byte* dataIn,unsigned int payload_size)
    {
        switch (cmdID)
        {
            case MOTOR_CREATE:
            {
                byte* ID = new byte [1];
                ID[0] = dataIn[0];
                
                byte* pinNumbers = new byte [2];
                for (byte i=0;i<2;i=i+1)
                {
                    pinNumbers[i] = dataIn[i+1];
                }
                
                if(ID[0] == 0)
                {
                    pMotor[ID[0]] = new Motor(1,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec1,&outputVoltage1,&setpointRadSec1,
                                           Kp,Ki,Kd,DIRECT);
                    pMotor[ID[0]]->setAfms(&AFMS);
                    pMotor[ID[0]]->registerMotor();
                    debugPrint(MSG_CREATE,ID[0],pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                else if(ID[0] == 1)
                {
                    pMotor[ID[0]] = new Motor(2,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec2,&outputVoltage2,&setpointRadSec2,
                                           Kp,Ki,Kd,DIRECT);
                    pMotor[ID[0]]->setAfms(&AFMS);
                    pMotor[ID[0]]->registerMotor();
                    debugPrint(MSG_CREATE,ID[0],pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                else if(ID[0] == 2)
                {
                    pMotor[ID[0]] = new Motor(3,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec3,&outputVoltage3,&setpointRadSec3,
                                           Kp,Ki,Kd,DIRECT);
                    pMotor[ID[0]]->setAfms(&AFMS);
                    pMotor[ID[0]]->registerMotor();
                    debugPrint(MSG_CREATE,ID[0],pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                
                sendResponseMsg(cmdID,0,0);
                break;
            }
            case GET_COUNTS:
            {
                byte ID = dataIn[0];
                int32_t count = pMotor[ID]->encoder->read();
                byte result[4];
                
                result[0] = (count & 0x000000ff);
                result[1] = (count & 0x0000ff00) >> 8;
                result[2] = (count & 0x00ff0000) >> 16;
                result[3] = (count & 0xff000000) >> 24;
                
                debugPrint(MSG_READ,ID,count);
                
                sendResponseMsg(cmdID,result,4);
                break;
            }
            /*
            case GET_COUNTSSEC:
            {
                byte ID;
                byte numEncoders = dataIn[0];
                byte result[4*numEncoders];
                int32_t oldCount[numEncoders];
                int32_t newCount[numEncoders];
                int32_t countDiff[numEncoders];
                
                for(size_t i = 0; i < numEncoders; i++)
                    {
                        ID = dataIn[i+1];
                        oldCount[i] = pMotor[ID].read();
                    }
                
                delay(getEncoderFreq());
                
                for(size_t i = 0; i < numEncoders; i++)
                    {
                        ID = dataIn[i+1];
                        newCount[i] = pMotor[ID].read();
                        countDiff[i] = newCount[i] - oldCount[i];
                    }
                
                for(size_t i =0; i < numEncoders; i = i+4)
                {
                    result[i] = (count & 0x000000ff);
                    result[i+1] = (count & 0x0000ff00) >> 8;
                    result[i+2] = (count & 0x00ff0000) >> 16;
                    result[i+3] = (count & 0xff000000) >> 24;
                {
                break;
            }
             */
            /*
            case GET_RAD:
            {
                byte ID = dataIn[0];
                double count = pMotor[ID]->getRad();
                
                byte result[4];
                
                result[0] = (count & 0x000000ff);
                result[1] = (count & 0x0000ff00) >> 8;
                result[2] = (count & 0x00ff0000) >> 16;
                result[3] = (count & 0xff000000) >> 24;
                
                sendResponseMsg(cmdID,result,4);
                break;
            }    
            case GET_RADSEC:
            {
                byte ID = dataIn[0];
                int32_t count = pMotor[ID]->getRadSec();
                
                byte result[4];
                
                result[0] = (count & 0x000000ff);
                result[1] = (count & 0x0000ff00) >> 8;
                result[2] = (count & 0x00ff0000) >> 16;
                result[3] = (count & 0xff000000) >> 24;
                
                sendResponseMsg(cmdID,result,4);
                break;
            }
             */
            default:
            {
                // Do nothing
                break;
            }
        }
    }
};
	
#endif