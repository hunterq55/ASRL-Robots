#include<FinalMotorLibrary.h>

byte motorNum = 1;  //A GLOBAL VARIABLE!
//Adafruit_MotorShield AFMS = Adafruit_MotorShield();
//Serial.begin(9600);

Motor::Motor(uint8_t phaseA, uint8_t phaseB, unsigned int encoderCPR,double *input,double *output, double *setpoint,double Kp,double Ki,double Kd,int ControllerDirection) : Encoder(phaseA, phaseB), PID(input,output,setpoint,Kp,Ki,Kd,ControllerDirection)
{
	//Serial
	//Serial.begin(9600);
	Adafruit_MotorShield AFMS_TEMP;
	AFMS_TEMP.begin();
	
	//Encoder Setup
    _phaseA = phaseA;
    _phaseB = phaseB;
    _encoderCPR = encoderCPR;
	setEncoderFreq(20);//time between updates for encoder
	
	//PID Setup
	SetSampleTime(20);//time between updates for encoder
	SetMode(1);
	SetOutputLimits(-255,255);
	
	_pmotor = AFMS_TEMP.getMotor(motorNum);
	motorNum++;
	
	//Serial.println("WORD");
	//Serial.println("Motor Number:");
	//Serial.println(motorNum);

}

void Motor::setDuty(uint8_t speed)
{
	if(speed < 0)
	{	
		speed = speed*-1;
		_pmotor->setSpeed(speed);
		_pmotor->run(BACKWARD);
		//Serial.println(speed);
	}
	else
	{
		_pmotor->setSpeed(speed);
		_pmotor->run(FORWARD);
		//Serial.println(speed);
	}
	
}

void Motor::setEncoderFreq(int freq)    //Sets sample time in ms for velocity and acceleration calculations//
{
    _freq = freq;
}

int Motor::getEncoderFreq()
{
	return _freq;
}


float Motor::getCountsSec() //Calculates counts per second over given sample time//
{	

    unsigned long now = millis();
    if((now - _lastTime) >= _freq)
    {
        _counts = read();
        _countsSec = (_counts - _lastCount) * (1000.0/_freq);

        _lastTime = now;
        _lastCount = _counts;
    }
    return _countsSec;
	
	/*
	//CURRENT CODE
	long oldCount = read();
	delay(_freq);
	long newCount = read();
	long countDiff = newCount-oldCount;
	_countsSec = countDiff/_freq;
	*/
}
	
float Motor::getDeg()   //Returns degrees 0-360 of motor based on counts//
{
    _deg = (read()%3072)*(360.0/3072.0);
    return _deg;
}

/*
float Motor::getDegSec()
{
    _degSec = (getCountsSec()%3072)*(360.0/3072.0);
    return _degSec;
}
*/

float Motor::getRad()
{
    _rad = getRevs()*2.0*3.14159;
    return _rad;
}

float Motor::getRadSec()
{
    _radSec = getRevsSec()*2.0*3.14159;
    return _radSec;
}

float Motor::getRevs()
{
    _revs = read()/_encoderCPR;
    return _revs;
}

float Motor::getRevsSec()
{
    _revsSec = getCountsSec()/_encoderCPR;
    return _revsSec;
}



