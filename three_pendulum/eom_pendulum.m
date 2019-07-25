function dqdt1 = eom_pendulum(t,q,param)
    % わかりやすいように変数を置き換える
    theta1 = q(1);
    theta2 = q(2);
    theta3 = q(3);
    dtheta1 = q(4);
    dtheta2 = q(5);
    dtheta3 = q(6);

    m1 = param.m1;
    l1 = param.l1;
    m2 = param.m2;
    l2 = param.l2;
    m3 = param.m3;
    l3 = param.l3;
    g = param.g;

    % Inertia matrix
    M = myMassMatrix_test(theta1,theta2,theta3,m1,m2,m3,l1,l2,l3,g);
    % Colioris and gravity
    f_cg = myF_CoriGrav_test(theta1,theta2,theta3,dtheta1,dtheta2,dtheta3,m1,m2,m3,l1,l2,l3,g);
    
    % 加速度を計算
    dd_q = M\(f_cg);

    %dqdt1 = [dtheta1; dtheta2; dtheta3; dd_q(1); dd_q(2); dd_q(3)];
    dqdt1 = [dtheta1 dtheta2 dtheta3 dd_q(1) dd_q(2) dd_q(3)];
end


