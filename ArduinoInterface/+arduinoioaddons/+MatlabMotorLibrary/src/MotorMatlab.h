
#ifndef MatlabMotorLibrary_h
#define MatlabMotorLibrary_h

#include "LibraryBase.h"
#include "FinalMotorLibrary.h"

//Debug statements
const char MSG_CREATE[]       PROGMEM = "MotorMatlab::mPointer[%d] = %d %d %d %f %f %f\n";
const char MSG_READ[]       PROGMEM = "MotorMatlab::mPointer[%d].read() = %d\n";
const char PID_BUGS[]        PROGMEM = "PID Output Voltage : %d\n";
const char MSG_SETPOINT[]       PROGMEM = "Setpoint recieved: %d\n";

#define MAX_MOTORS 4

//Available commands through MATLAB interface
#define MOTOR_CREATE 0x03
#define GET_COUNTS 0x02
#define GET_RAD 0x00
#define GET_RADSEC 0x01
#define GET_COUNTSSEC 0x04
#define SET_RADSEC 0x05

//GLOBAL VARIABLES
double Kp = 1.25,Ki = 31.25,Kd = 0.0;
double inputRadSec1, outputVoltage1, setpointRadSec1 = 3.0;
double inputRadSec2, outputVoltage2, setpointRadSec2 = 3.0;
double inputRadSec3, outputVoltage3, setpointRadSec3 = 3.0;


Adafruit_MotorShield AFMS = Adafruit_MotorShield();


class MotorMatlab : public LibraryBase
{
    public:
    
    Motor* mPointer[MAX_MOTORS];
    
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
    
    /*
    void loop()
    {
        //This loop will bring the motors to a desired setpoint by updating
        //the PID, as defined earlier in the code.
        if(mPointer[0] != NULL)
        {
            //mPointer[0]->updateMotor();
            mPointer[0]->setDuty(50);
        }
        
        if(mPointer[1] != NULL)
        {
            //mPointer[1]->updateMotor();
            mPointer[1]->setDuty(50);
        }
        
        if(mPointer[2] != NULL)
        {
            //mPointer[2]->updateMotor();
            mPointer[2]->setDuty(50);
        }
    }
     */
    
    public:
    
    void commandHandler(byte cmdID,byte* dataIn,unsigned int payload_size)
    {
        switch (cmdID)
        {
            case MOTOR_CREATE:
            {
                byte ID, pinNumbers[2];
                ID = dataIn[0];

                for (byte i=0;i<2;i=i=i+1)
                {
                    pinNumbers[i] = dataIn[i+1];
                }
                
                if(ID == 0)
                {
                    mPointer[ID] = new Motor(1,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec1,&outputVoltage1,&setpointRadSec1,
                                           Kp,Ki,Kd,DIRECT);
                    mPointer[ID]->setAfms(&AFMS);
                    mPointer[ID]->registerMotor();
                    debugPrint(MSG_CREATE,ID,pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                else if(ID == 1)
                {
                    mPointer[ID] = new Motor(2,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec2,&outputVoltage2,&setpointRadSec2,
                                           Kp,Ki,Kd,DIRECT);
                    mPointer[ID]->setAfms(&AFMS);
                    mPointer[ID]->registerMotor();
                    debugPrint(MSG_CREATE,ID,pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                else if(ID == 2)
                {
                    mPointer[ID] = new Motor(3,pinNumbers[0],pinNumbers[1],
                                           3072,&inputRadSec3,&outputVoltage3,&setpointRadSec3,
                                           Kp,Ki,Kd,DIRECT);
                    mPointer[ID]->setAfms(&AFMS);
                    mPointer[ID]->registerMotor();
                    debugPrint(MSG_CREATE,ID,pinNumbers[0],pinNumbers[1],3702,Kp,Ki,Kd);
                }
                
                sendResponseMsg(cmdID,0,0);
                break;
            }
            case GET_COUNTS:
            {
                byte ID = dataIn[0];
                
                if(mPointer[ID] == NULL)
                    break;
                
                int32_t count = mPointer[ID]->encoder->read();
                byte result[4];
                
                result[0] = (count & 0x000000ff);
                result[1] = (count & 0x0000ff00) >> 8;
                result[2] = (count & 0x00ff0000) >> 16;
                result[3] = (count & 0xff000000) >> 24;
                
                debugPrint(MSG_READ,ID,count);
                
                sendResponseMsg(cmdID,result,4);
                break;
            }
            case SET_RADSEC:
            {
                byte ID = dataIn[0];
                int pwm = 0;
                
                //Inputs is an array of 4 byes representing a single 32 bit
                //signed integer which must be reconstructed with bitwise 
                //operations.
                
                pwm = (dataIn[1] | pwm);
                pwm = ((dataIn[2] << 8) | pwm);
                pwm = ((dataIn[3] << 16) | pwm);
                pwm = ((dataIn[4] << 24) | pwm);
                
                debugPrint(MSG_SETPOINT,pwm);
                
                /*
                if(ID == 0)
                {
                     setpointRadSec1 = dataIn[1];
                }
                else if(ID == 1)
                {
                    setpointRadSec2 = dataIn[1];
                }
                else if(ID == 2)
                {
                    setpointRadSec3 = dataIn[1];
                }
                
                setpointRadSec3 = 1.5;
                */
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
                        oldCount[i] = mPointer[ID].read();
                    }
                
                delay(getEncoderFreq());
                
                for(size_t i = 0; i < numEncoders; i++)
                    {
                        ID = dataIn[i+1];
                        newCount[i] = mPointer[ID].read();
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
                double count = mPointer[ID]->getRad();
                
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
                int32_t count = mPointer[ID]->getRadSec();
                
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