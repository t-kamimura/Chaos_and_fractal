function E = myTotalEnergy_test(theta1,theta2,theta3,dtheta1,dtheta2,dtheta3,m1,m2,m3,l1,l2,l3,g)
%MYTOTALENERGY_TEST
%    E = MYTOTALENERGY_TEST(THETA1,THETA2,THETA3,DTHETA1,DTHETA2,DTHETA3,M1,M2,M3,L1,L2,L3,G)

%    This function was generated by the Symbolic Math Toolbox version 8.3.
%    24-Jul-2019 11:11:35

t2 = cos(theta1);
t3 = cos(theta2);
t4 = dtheta1.^2;
t5 = l1.^2;
E = dtheta2.^2.*l2.^2.*m2+(m1.*t4.*t5)./2.0+m2.*t4.*t5-g.*l1.*m1.*t2-g.*l1.*m2.*t2-g.*l1.*m3.*t2-g.*l2.*m2.*t3-g.*l2.*m3.*t3-g.*l3.*m3.*cos(theta3)+dtheta1.*dtheta2.*l1.*l2.*m2.*cos(theta1-theta2).*2.0;