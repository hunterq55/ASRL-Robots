% Function to calculate the inital error in the effector pose

function err_init = getError_init(x_ref, theta_ref, q_init,Robot)
[x_init, theta_init] = AR2fkine(q_init,Robot);
ex_init = x_ref - x_init;
C_ref = eul2r(theta_ref');
C_init = eul2r(theta_init');
[eo_init,~] = getOrientErr(C_ref, C_init);
err_init = [ex_init; eo_init];
end