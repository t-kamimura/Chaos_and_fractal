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
y_ini = [pi/2 pi/3 pi/2 0 0 0];
tstart = 0;
tend = 30;
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
% [tout1,yout] = ode45(ode,[tstart tend], y_ini,options);
% 4次のルンゲクッタで微分方程式を解く
[tout1,yout1] = rungekutta4(ode,dt,[tstart tend], y_ini);

% 初期値をちょっとだけずらす
y_ini2 = y_ini + [0 0 0 0 0 1e-6];
% 4次のルンゲクッタで微分方程式を解く
[tout2,yout2] = rungekutta4(ode,dt,[tstart tend], y_ini2);

% 初期値をちょっとだけずらす
y_ini3 = y_ini + [0 0 0 0 0 -1e-6];
% 4次のルンゲクッタで微分方程式を解く
[tout3,yout3] = rungekutta4(ode,dt,[tstart tend], y_ini3);

save('ODE_RESULTS','param','tout1','yout1','yout2','yout3')

%% visualize
h1 = figure;
h1.InnerPosition = [400, 200, 600,600];
h1.Color = [1/255 1/255 1/255];
hold on

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
p1(1) = line([0 x1],[0 y1],'linewidth',4,'color','r');
p1(2) = line([x1 x2],[y1 y2],'linewidth',3,'color','r');
p1(3) = line([x2 x3],[y2 y3],'linewidth',2,'color','r');

theta1 = y_ini2(1);
theta2 = y_ini2(2);
theta3 = y_ini2(3);
x1 = l1*sin(theta1);
y1 = -l1*cos(theta1);
x2 = l1*sin(theta1)+l2*sin(theta2);
y2 = -l1*cos(theta1)-l2*cos(theta2);
x3 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
y3 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);
p2(1) = line([0 x1],[0 y1],'linewidth',4,'color','g');
p2(2) = line([x1 x2],[y1 y2],'linewidth',3,'color','g');
p2(3) = line([x2 x3],[y2 y3],'linewidth',2,'color','g');

theta1 = y_ini2(1);
theta2 = y_ini2(2);
theta3 = y_ini2(3);
x1 = l1*sin(theta1);
y1 = -l1*cos(theta1);
x2 = l1*sin(theta1)+l2*sin(theta2);
y2 = -l1*cos(theta1)-l2*cos(theta2);
x3 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
y3 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);
p3(1) = line([0 x1],[0 y1],'linewidth',4,'color','b');
p3(2) = line([x1 x2],[y1 y2],'linewidth',3,'color','b');
p3(3) = line([x2 x3],[y2 y3],'linewidth',2,'color','b');

% p4 = plot(x11,y11,'o');
% p5 = plot(x21,y21,'o');
% p6 = plot(x31,y3,'o');
strng = [num2str(0,'%.3f'),' s'];
t = text(1.2,-3.0,strng,'color','w','fontsize',16);
axis equal
xlim([-1.75 1.75])
ylim([-3.0 0.5])
axis off

for i=1:5:length(tout1)
    %cla

    strng = [num2str(tout1(i),'%.3f'),' s'];
    t.String = strng;
%     t = text(1.2,-3.0,strng,'color','w','fontsize',16);
    theta1 = yout1(i,1);
    theta2 = yout1(i,2);
    theta3 = yout1(i,3);
    x11 = l1*sin(theta1);
    y11 = -l1*cos(theta1);
    x21 = l1*sin(theta1)+l2*sin(theta2);
    y21 = -l1*cos(theta1)-l2*cos(theta2);
    x31 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
    y31 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

    p1(1).XData = [0 x11];
    p1(1).YData = [0 y11];
    p1(2).XData = [x11 x21];
    p1(2).YData = [y11 y21];
    p1(3).XData = [x21 x31];
    p1(3).YData = [y21 y31];

    theta1 = yout2(i,1);
    theta2 = yout2(i,2);
    theta3 = yout2(i,3);
    x11 = l1*sin(theta1);
    y11 = -l1*cos(theta1);
    x21 = l1*sin(theta1)+l2*sin(theta2);
    y21 = -l1*cos(theta1)-l2*cos(theta2);
    x31 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
    y31 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

    p2(1).XData = [0 x11];
    p2(1).YData = [0 y11];
    p2(2).XData = [x11 x21];
    p2(2).YData = [y11 y21];
    p2(3).XData = [x21 x31];
    p2(3).YData = [y21 y31];

    theta1 = yout3(i,1);
    theta2 = yout3(i,2);
    theta3 = yout3(i,3);
    x11 = l1*sin(theta1);
    y11 = -l1*cos(theta1);
    x21 = l1*sin(theta1)+l2*sin(theta2);
    y21 = -l1*cos(theta1)-l2*cos(theta2);
    x31 = l1*sin(theta1)+l2*sin(theta2)+l3*sin(theta3);
    y31 = -l1*cos(theta1)-l2*cos(theta2)-l3*cos(theta3);

    p3(1).XData = [0 x11];
    p3(1).YData = [0 y11];
    p3(2).XData = [x11 x21];
    p3(2).YData = [y11 y21];
    p3(3).XData = [x21 x31];
    p3(3).YData = [y21 y31];
%     p4.XData = x11;
%     p4.YData = y11;
%     p5.XData = x21;
%     p5.YData = y21;
%     p6.XData = x311;
%     p6.YData = y3;
    drawnow
end


%%
h2 = figure;
h2.InnerPosition = [400, 200, 600,600];
subplot(3,1,1)
plot(tout1,yout1(:,1),'color','r')
hold on
plot(tout1,yout2(:,1),'color','g')
plot(tout1,yout3(:,1),'color','b')

subplot(3,1,2)
plot(tout1,yout1(:,2),'color','r')
hold on
plot(tout1,yout2(:,2),'color','g')
plot(tout1,yout3(:,2),'color','b')

subplot(3,1,3)
plot(tout1,yout1(:,3),'color','r')
hold on
plot(tout1,yout2(:,3),'color','g')
plot(tout1,yout3(:,3),'color','b')
% 
% plot3(yout1(:,1),yout1(:,2),yout1(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','r')
% hold on
% plot3(yout2(:,1),yout2(:,2),yout2(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','g')
% plot3(yout3(:,1),yout3(:,2),yout3(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','b')

