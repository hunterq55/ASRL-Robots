psi = 0;

trajectory = [cos(t);
              sin(t);
              0;];
trajectoryPrime = [-sin(t);
                   cos(t);
                   0;];
trajectoryDoublePrime = [-cos(t);
                         -sin(t);
                          0;];
               
bodyRate = [cos(psi),sin(psi),0;
           -sin(psi),cos(psi),0;
            0       ,0       ,0;]*trajectoryPrime;
        
bodyRatePrime = 


k2 = 13.4 * 10^-3; %N*m/A
k3 = 1.4 * 10^-3; %V/rpm
Ra = 1.9; %ohms
n = 1;
R = .05; %m

m = 5; %platform mass, unknown
Iz = 5; %platform inertia, unknown
H = [1/m 0 0;
     0 1/m 0;
     0 0   1/Iz;];
B = [0 cos(pi/6) -cos(pi/6);
    -1 sin(pi/6)  sin(pi/6);
     L         L          L;];
 
G = eye(3) + H*B*transpose(B)*n*n*J0/R^2;
 
inv(H*B)*(R*Ra/(k2*n))*G*