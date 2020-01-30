# ASRL-Robots

This repository will host all working code used to control the ROME mobile manipulator platform in the Astrodyanamics and Space Robotics Lab at UCF.

The goal of this repository is to host all files needed for simulation of each system separately and together, as well as the required hardware connection needed to control the hardware platform using MATLAB and the Arduino Support Package.  

## BRANCHS

### master

- master hosts all parts of the ROME mobile manipulator platform, including simulation code, visualization code, and all code required to run the mobile manipulator using the MATLAB Arduino Hardware Support Package.

#### ROME Control

 - Velocity Control through the MATLAB Support Package is used to increase the ability of the AR2. All files can be found in the Kinematics folder.

#### Manipulator

- The lab currently uses the AR2 designed by Chris Annin (https://github.com/Chris-Annin/AR2) for the manipulator used in the Rapid Orbital Motion Emulator (ROME) research project.

 - Aiding our research, a visualization tool for the AR2 was created, but is currently using broken inverse kinematics.

### matlab2018

 - The matlab2018 branch hosts all files required to run the ROME project. This software uses the old version 18 MATLAB Arduino Hardware Support Package, and is currently the only way to run the hardware. master uses the matlab2018 code.

### matlab2019

- The matlab219 brach hosts all files required to run the ROME project using the current version of the MATLAB Arduino Hardware Support Package. This branch currently is not working.

## AKNOWLEDGEMENTS

 - Original, unedited files for AR2 are hosted on this repo for orginization purposes. All original code based on Chris Annin's AR2 robotic manipulator project: https://github.com/Chris-Annin/AR2

 - Original, unedited files for Robotics Toolbox by Peter Corke are hosted on this repo for orginization purposes. Original code and support for the Robotics Toolbox can be found here: https://petercorke.com/wordpress/toolboxes/robotics-toolbox
