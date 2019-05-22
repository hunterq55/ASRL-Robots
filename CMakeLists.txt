cmake_minimum_required(VERSION 3.13)
project(GroundVehicle)

set(CMAKE_CXX_STANDARD 14)

include_directories(Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library)
include_directories(Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library/utility)
include_directories(Sketchbook/libraries/Encoder-master)
include_directories(Sketchbook/libraries/Encoder-master/utility)
include_directories(Sketchbook/libraries/FinalMotorLibrary)
include_directories(Sketchbook/libraries/PID)

add_executable(GroundVehicle
        Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library/utility/Adafruit_MS_PWMServoDriver.cpp
        Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library/utility/Adafruit_MS_PWMServoDriver.h
        Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library/Adafruit_MotorShield.cpp
        Sketchbook/libraries/Adafruit_Motor_Shield_V2_Library/Adafruit_MotorShield.h
        Sketchbook/libraries/Encoder-master/utility/direct_pin_read.h
        Sketchbook/libraries/Encoder-master/utility/interrupt_config.h
        Sketchbook/libraries/Encoder-master/utility/interrupt_pins.h
        Sketchbook/libraries/Encoder-master/Encoder.cpp
        Sketchbook/libraries/Encoder-master/Encoder.h
        Sketchbook/libraries/FinalMotorLibrary/FinalMotorLibrary.cpp
        Sketchbook/libraries/FinalMotorLibrary/FinalMotorLibrary.h
        Sketchbook/libraries/PID/PID_v1.cpp
        Sketchbook/libraries/PID/PID_v1.h
        Sketchbook/Motor_Library_Repair_Code/Motor_Library_Repair_Code.ino
        Sketchbook/Print_Tests/Print_Tests.ino Sketchbook/libraries/FinalMotorLibrary/revisedMotorHeader.h Sketchbook/libraries/FinalMotorLibrary/revisedMotorClass.cpp)
