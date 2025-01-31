function f_cg = myF_CoriGrav_test(theta1,theta2,theta3,dtheta1,dtheta2,dtheta3,m1,m2,m3,l1,l2,l3,g)
%MYF_CORIGRAV_TEST
%    F_CG = MYF_CORIGRAV_TEST(THETA1,THETA2,THETA3,DTHETA1,DTHETA2,DTHETA3,M1,M2,M3,L1,L2,L3,G)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    24-Jul-2019 11:11:35

t2 = conj(dtheta1);
t3 = conj(dtheta2);
t4 = conj(dtheta3);
t5 = conj(g);
t6 = conj(l1);
t7 = conj(l2);
t8 = conj(l3);
t9 = conj(m2);
t10 = conj(m3);
t11 = conj(theta1);
t12 = conj(theta2);
t13 = conj(theta3);
t16 = dtheta1.^2;
t17 = dtheta2.^2;
t18 = dtheta3.^2;
t19 = -theta2;
t20 = -theta3;
t14 = sin(t11);
t15 = sin(t12);
t21 = -t12;
t22 = -t13;
t23 = t19+theta1;
t24 = t20+theta1;
t25 = t20+theta2;
t26 = sin(t23);
t27 = sin(t24);
t28 = sin(t25);
t29 = t11+t21;
t30 = t11+t22;
t31 = t12+t22;
t32 = sin(t29);
t33 = sin(t30);
t34 = sin(t31);
t35 = dtheta1.*dtheta2.*l1.*l2.*m2.*t26;
t36 = dtheta1.*dtheta2.*l1.*l2.*m3.*t26;
t37 = dtheta1.*dtheta3.*l1.*l3.*m3.*t27;
t38 = dtheta2.*dtheta3.*l2.*l3.*m3.*t28;
t39 = t2.*t3.*t6.*t7.*t9.*t32;
t40 = t2.*t3.*t6.*t7.*t10.*t32;
t41 = t2.*t4.*t6.*t8.*t10.*t33;
t42 = t3.*t4.*t7.*t8.*t10.*t34;
f_cg = [t35+t36+t37-t39-t40-t41-t5.*t6.*t9.*t14-t5.*t6.*t10.*t14-t5.*t6.*t14.*conj(m1)-l1.*l2.*m2.*t17.*t26-l1.*l2.*m3.*t17.*t26-l1.*l3.*m3.*t18.*t27;-t35-t36+t38+t39+t40-t42-t5.*t7.*t9.*t15-t5.*t7.*t10.*t15+l1.*l2.*m2.*t16.*t26+l1.*l2.*m3.*t16.*t26-l2.*l3.*m3.*t18.*t28;-t37-t38+t41+t42-t5.*t8.*t10.*sin(t13)+l1.*l3.*m3.*t16.*t27+l2.*l3.*m3.*t17.*t28];
