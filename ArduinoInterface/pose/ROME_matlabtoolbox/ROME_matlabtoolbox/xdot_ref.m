function xdot_r = xdot_ref(t)
global manueverTime
global q_init
global initPos
global initOri
    xdot_coef = 0;
%     xdot_coef = 0;
    xdot_r = [0; 0; xdot_coef*cos(t)];