% fileName: symbolic_EOM_test.m
% initDate: 20190723
% Object:   運動方程式を導くテスト。２重振り子の運動方程式を出してみる。

%% initial settings
clear
close all

%% definitions

% parameters
syms m1 m2 m3 l1 l2 l3 g
param = [m1 m2 m3 l1 l2 l3 g];

% state variables
syms theta1 theta2 theta3
syms dtheta1 dtheta2 dtheta3
q = [theta1 theta2 theta3];
dq = [dtheta1 dtheta2 dtheta3];

% Energy functions
syms T1 T2 T3 U1 U2 U3
syms L

% position of each mass
x1 = l1*sin(theta1);
y1 = -l1*cos(theta1);
x2 = l1*sin(theta1)+l2*sin(theta2);
y2 = -l1*cos(theta1)-l2*cos(theta2);
x3 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
y3 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

% Velocity of each mass
dx1 = jacobian(x1,q)*dq.';
dy1 = jacobian(y1,q)*dq.';
dx2 = jacobian(x2,q)*dq.';
dy2 = jacobian(y2,q)*dq.';
dx3 = jacobian(x3,q)*dq.';
dy3 = jacobian(y3,q)*dq.';

% Energy
T1 = 0.5*m1*(dx1^2 + dy1^2);
T2 = 0.5*m2*(dx2^2 + dy2^2);
T3 = 0.5*m3*(dx3^2 + dy3^2);
U1 = m1*g*y1;
U2 = m2*g*y2;
U3 = m3*g*y3;
L = simplify(T1 + T2 + T3 - U1 - U2 - U3);
E = simplify(T1 + T2 + T2 + U1 + U2 + U3);

% Differentials
dLddq = jacobian(L,dq);
d_dLddq_dt = jacobian(dLddq,q)*dq.';     % Inertia force
dLdq = jacobian(L,q);

M = jacobian(dLddq,dq);                 % Inertial matrix
M = simplify(M);

f_cg = dLdq' - d_dLddq_dt;               % Coriolis & gravitational force
f_cg = simplify(f_cg);

% save as functions
matlabFunction(M,'file','myMassMatrix_test','vars',[q, param]);
matlabFunction(f_cg,'file','myF_CoriGrav_test','vars',[q, dq, param]);
matlabFunction(E,'file','myTotalEnergy_test','vars',[q, dq, param]);