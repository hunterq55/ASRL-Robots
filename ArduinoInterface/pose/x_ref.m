function x_r=x_ref(t)
global manueverTime
global q_init
global initPos
global initOri
x_ref_coef = 10;
% x_r = [0*sin(t)+200; 0*sin(t)+200; x_ref_coef*sin(t)+200];
x_r = [0; 0; x_ref_coef*sin(t)]; 
x_r = x_r + initPos;
end