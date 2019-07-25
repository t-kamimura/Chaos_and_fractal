% fileName: main_ode_test.m
% initDate: 20190723
% Object:   3重振子の運動方程式を解く

clear; close all;

param.m1 = 9.0;
param.l1 = 0.9;
param.m2 = 6.0;
param.l2 = 0.6;
param.m3 = 4.0;
param.l3 = 0.4;

param.g = 9.8;

% variables
y_ini = [pi/2 pi/4 pi/2 0 0 0];
tstart = 0;
tend = 15;
dt = 1e-3;

% ode45の誤差パラメータ
relval = 1e-12;
absval = 1e-12;
refine = 6;

% equation of motion
ode = @(t,y) eom_pendulum(t,y,param);
% options for ode45 function
options = odeset('RelTol',relval,'AbsTol',absval,'Refine',refine,'Stats','off');     %ode45のオプションを設定．

% ode45で微分方程式を解く
% [tout,yout] = ode45(ode,[tstart tend], y_ini,options);
% 4次のルンゲクッタで微分方程式を解く
[tout,yout] = rungekutta4(ode,dt,[tstart tend], y_ini);

%% visualize
h1 = figure;
h1.InnerPosition = [400, 200, 600,600];
h1.Color = [1/255 1/255 1/255];
l1 = param.l1;
l2 = param.l2;
l3 = param.l3;

theta1 = y_ini(1);
theta2 = y_ini(2);
theta3 = y_ini(3);
x1 = l1*sin(theta1);
y1 = -l1*cos(theta1);
x2 = l1*sin(theta1)+l2*sin(theta2);
y2 = -l1*cos(theta1)-l2*cos(theta2);
x3 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
y3 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

hold on
p1 = line([0 x1],[0 y1],'linewidth',4);
p2 = line([x1 x2],[y1 y2],'linewidth',3);
p3 = line([x2 x3],[y2 y3],'linewidth',2);
% p4 = plot(x1,y1,'o');
% p5 = plot(x2,y2,'o');
% p6 = plot(x3,y3,'o');
axis equal
xlim([-2 2])
ylim([-3.5 0.5])
%%
for i=1:5:length(tout)
    %cla
    theta1 = yout(i,1);
    theta2 = yout(i,2);
    theta3 = yout(i,3);
    x1 = l1*sin(theta1);
    y1 = -l1*cos(theta1);
    x2 = l1*sin(theta1)+l2*sin(theta2);
    y2 = -l1*cos(theta1)-l2*cos(theta2);
    x3 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
    y3 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

    p1.XData = [0 x1];
    p1.YData = [0 y1];
    p2.XData = [x1 x2];
    p2.YData = [y1 y2];
    p3.XData = [x2 x3];
    p3.YData = [y2 y3];
%     p4.XData = x1;
%     p4.YData = y1;
%     p5.XData = x2;
%     p5.YData = y2;
%     p6.XData = x3;
%     p6.YData = y3;
    drawnow
    axis off
end