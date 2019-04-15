#include "Arduino.h"
#include "Encoder.h"
#include "PID_v1.h"
#include "Adafruit_MotorShield.h"

class Motor : public Encoder, public PID, public Adafruit_MotorShield
{
	public:

	Motor(uint8_t phaseA, uint8_t phaseB, unsigned int encoderCPR, double *input,
		  double *output,double *setpoint,double Kp,double Ki,double Kd,int ControllerDirection);

	void setEncoderFreq(int);
	int getEncoderFreq();
	
	//Read Encoder Functions

	float getCountsSec();

	float getDeg();
	float getDegSec();

	float getRad();
	float getRadSec();

	float getRevs();
	float getRevsSec();
	
	//Set Motor Functions
	
	//Adafruit Motor
	
	void setDuty(uint8_t);

	private:
	
	//pins
    byte _phaseA;
    byte _phaseB;
	
	//motor attributes
    unsigned int _encoderCPR;

	//encoder measurements
    int _freq;
	long _counts;
    long _lastCount;
	unsigned long _lastTime = 0; //Keeps track of last calculation time for counts/second.

	float _countsSec;
	float _lastCountsSec;
	unsigned long _lastTime1; //Keeps track of last calculation time for counts/second^2


	float _deg;
	float _degSec;

	float _rad;
	float _radSec;

	float _revs;
	float _revsSec;
	
	//addresses for PID
	
	//addresses for adafruit motor
	
	Adafruit_DCMotor *_pmotor;
	

};





