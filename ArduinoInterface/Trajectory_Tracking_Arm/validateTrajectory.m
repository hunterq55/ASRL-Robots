function [outputArg1,outputArg2] = validateTrajectory(trajectory)
%VALIDATETRAJECTORY Summary of this function goes here
%   Detailed explanation goes here

degToRad = (pi/180);

%Counter clockwise limits from the zero
CCWLimit(1) = (170)*degToRad;
CCWLimit(2) = (42)*degToRad;
CCWLimit(3) = (89)*degToRad;
CCWLimit(4) = (165)*degToRad;
CCWLimit(5) = (105)*degToRad;
CCWLimit(6) = (155)*degToRad;

%Clockwise limits from the zero
CWLimit(1) = -(170)*degToRad;
CWLimit(2) = -(90)*degToRad;
CWLimit(3) = -(51)*degToRad;
CWLimit(4) = -(165)*degToRad;
CWLimit(5) = -(105)*degToRad;
CWLimit(6) = -(155)*degToRad;

for index = 1:6
    


outputArg1 = inputArg1;
outputArg2 = inputArg2;
end

