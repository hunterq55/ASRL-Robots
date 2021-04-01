function xdot_r = xdot_ref(t)
    xdot_coef = 100;
%     xdot_coef = 0;
    xdot_r = [0*cos(t); 0*cos(t); -xdot_coef*pi/manueverTime*sin(pi*t/manueverTime)];
end