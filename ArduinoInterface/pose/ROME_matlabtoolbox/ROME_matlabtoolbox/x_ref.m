function x_r=x_ref(t)
global manueverTime
x_ref_coef = 100;
% x_r = [0*sin(t)+200; 0*sin(t)+200; x_ref_coef*sin(t)+200];
x_r = [0*sin(t)+200; 0*sin(t)+200; x_ref_coef*cos(pi*t/manueverTime)+200]; 
end