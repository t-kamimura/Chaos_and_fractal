% fileName: main_ode_test.m
% initDate: 20190723
% Object:   3重振子�?運動方程式を解く�?3つの振子を同時に動かす�?

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
y_ini2 = y_ini + [0 0 0 0 0 1e-6];
y_ini3 = y_ini + [0 0 0 0 0 -1e-6];
tstart = 0;
tend = 30;
dt = 1e-3;

% ode45の誤差パラメータ
relval = 1e-12;
absval = 1e-12;
refine = 6;

% equation of motion
ode = @(t, y) eom_pendulum(t, y, param);
% options for ode45 function
options = odeset('RelTol', relval, 'AbsTol', absval, 'Refine', refine, 'Stats', 'off'); %ode45のオプションを設定�?

%% 数値積�?
% ode45で微�?��程式を解�?
% [tout1,yout] = ode45(ode,[tstart tend], y_ini,options);
% 4次のルンゲク�?��で微�?��程式を解�?
[tout1, yout1] = rungekutta4(ode, dt, [tstart tend], y_ini);

% 初期値をち�?��と�?��ずら�?

% 4次のルンゲク�?��で微�?��程式を解�?
[tout2, yout2] = rungekutta4(ode, dt, [tstart tend], y_ini2);

% 初期値をち�?��と�?��ずら�?

% 4次のルンゲク�?��で微�?��程式を解�?
[tout3, yout3] = rungekutta4(ode, dt, [tstart tend], y_ini3);

save('ODE_RESULTS', 'param', 'tout1', 'yout1', 'yout2', 'yout3')

%% visualize

% Construct a questdlg with three options
choice = questdlg('Do you want to save the result(s)?', ...
    'Saving opptions', ...
    'Yes', 'No', 'No');
% Handle response
switch choice
    case 'Yes'
        saveflag = true;
    case 'No'
        saveflag = false;
end

h1 = figure;
h1.InnerPosition = [400, 200, 800, 800];
h1.Color = [1/255 1/255 1/255];
set(h1, 'DoubleBuffer', 'on');
hold on

l1 = param.l1;
l2 = param.l2;
l3 = param.l3;

myclr = hsv(3) .* 0.6 + ones(3, 3) .* 0.4;

theta1 = y_ini(1);
theta2 = y_ini(2);
theta3 = y_ini(3);
x1 = l1 * sin(theta1);
y1 = -l1 * cos(theta1);
x2 = l1 * sin(theta1) + l2 * sin(theta2);
y2 = -l1 * cos(theta1) - l2 * cos(theta2);
x3 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
y3 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);
p1(1) = line([0 x1], [0 y1], 'linewidth', 4, 'color', myclr(1, :));
p1(2) = line([x1 x2], [y1 y2], 'linewidth', 3, 'color', myclr(1, :));
p1(3) = line([x2 x3], [y2 y3], 'linewidth', 2, 'color', myclr(1, :));

theta1 = y_ini2(1);
theta2 = y_ini2(2);
theta3 = y_ini2(3);
x1 = l1 * sin(theta1);
y1 = -l1 * cos(theta1);
x2 = l1 * sin(theta1) + l2 * sin(theta2);
y2 = -l1 * cos(theta1) - l2 * cos(theta2);
x3 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
y3 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);
p2(1) = line([0 x1], [0 y1], 'linewidth', 4, 'color', myclr(2, :));
p2(2) = line([x1 x2], [y1 y2], 'linewidth', 3, 'color', myclr(2, :));
p2(3) = line([x2 x3], [y2 y3], 'linewidth', 2, 'color', myclr(2, :));

theta1 = y_ini2(1);
theta2 = y_ini2(2);
theta3 = y_ini2(3);
x1 = l1 * sin(theta1);
y1 = -l1 * cos(theta1);
x2 = l1 * sin(theta1) + l2 * sin(theta2);
y2 = -l1 * cos(theta1) - l2 * cos(theta2);
x3 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
y3 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);
p3(1) = line([0 x1], [0 y1], 'linewidth', 4, 'color', myclr(3, :));
p3(2) = line([x1 x2], [y1 y2], 'linewidth', 3, 'color', myclr(3, :));
p3(3) = line([x2 x3], [y2 y3], 'linewidth', 2, 'color', myclr(3, :));

% p4 = plot(x11,y11,'o');
% p5 = plot(x21,y21,'o');
% p6 = plot(x31,y3,'o');
strng = [num2str(0, '%.3f'), ' s'];
t = text(1.2, -3.0, strng, 'color', 'w', 'fontsize', 16);
axis equal
xlim([-1.75 1.75])
ylim([-3.0 0.5])
axis off

F = [];
n = 1;

for i = 1:10:length(tout1)
    %cla

    strng = [num2str(tout1(i), '%.3f'), ' s'];
    t.String = strng;
    %     t = text(1.2,-3.0,strng,'color','w','fontsize',16);
    theta1 = yout1(i, 1);
    theta2 = yout1(i, 2);
    theta3 = yout1(i, 3);
    x11 = l1 * sin(theta1);
    y11 = -l1 * cos(theta1);
    x21 = l1 * sin(theta1) + l2 * sin(theta2);
    y21 = -l1 * cos(theta1) - l2 * cos(theta2);
    x31 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
    y31 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);

    p1(1).XData = [0 x11];
    p1(1).YData = [0 y11];
    p1(2).XData = [x11 x21];
    p1(2).YData = [y11 y21];
    p1(3).XData = [x21 x31];
    p1(3).YData = [y21 y31];

    theta1 = yout2(i, 1);
    theta2 = yout2(i, 2);
    theta3 = yout2(i, 3);
    x12 = l1 * sin(theta1);
    y12 = -l1 * cos(theta1);
    x22 = l1 * sin(theta1) + l2 * sin(theta2);
    y22 = -l1 * cos(theta1) - l2 * cos(theta2);
    x32 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
    y32 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);

    p2(1).XData = [0    x12];
    p2(1).YData = [0    y12];
    p2(2).XData = [x12  x22];
    p2(2).YData = [y12  y22];
    p2(3).XData = [x22  x32];
    p2(3).YData = [y22  y32];

    theta1 = yout3(i, 1);
    theta2 = yout3(i, 2);
    theta3 = yout3(i, 3);
    x13 = l1 * sin(theta1);
    y13 = -l1 * cos(theta1);
    x23 = l1 * sin(theta1) + l2 * sin(theta2);
    y23 = -l1 * cos(theta1) - l2 * cos(theta2);
    x33 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
    y33 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);

    p3(1).XData = [0    x13];
    p3(1).YData = [0    y13];
    p3(2).XData = [x13  x23];
    p3(2).YData = [y13  y23];
    p3(3).XData = [x23  x33];
    p3(3).YData = [y23  y33];

%     if n < 51
% 
%         for j = 1:n
%             p4(j) = plot(x31, y31, 'o', 'markersize', 2, 'markeredgecolor', 'none', 'markerfacecolor', myclr(1, :));
%             p5(j) = plot(x32, y32, 'o', 'markersize', 2, 'markeredgecolor', 'none', 'markerfacecolor', myclr(2, :));
%             p6(j) = plot(x33, y33, 'o', 'markersize', 2, 'markeredgecolor', 'none', 'markerfacecolor', myclr(3, :));
%         end
% 
%     else
% 
%         for j = 1:50
%             p4(50).XData
% 
%             
%         end
%         p4(50).XData = x31; p4(j).YData = y31; p4(j).MarkerFaceColor = myclr(1, :) * j * 0.02;
%         p5(50).XData = x32; p5(j).YData = y32; p5(j).MarkerFaceColor = myclr(2, :) * j * 0.02;
%         p6(50).XData = x33; p6(j).YData = y33; p6(j).MarkerFaceColor = myclr(3, :) * j * 0.02;
% 
%     end

    drawnow

    if saveflag == true
        F = [F; getframe(gcf)];
    end

    n = n + 1;
end

if saveflag == true
    videoobj = VideoWriter([date,'movie.mp4'],'MPEG-4');
%     videoobj = VideoWriter([date, 'movie.avi'], 'Motion JPEG AVI');
%     videoobj.Quality = 95;
    fprintf('video saving...')
    open(videoobj);
    writeVideo(videoobj, F);
    close(videoobj);
    fprintf('complete!\n');
end

%%
h2 = figure;
h2.InnerPosition = [400, 200, 600, 600];
subplot(3, 1, 1)
plot(tout1, yout1(:, 1), 'color', 'r')
hold on
plot(tout1, yout2(:, 1), 'color', 'g')
plot(tout1, yout3(:, 1), 'color', 'b')

subplot(3, 1, 2)
plot(tout1, yout1(:, 2), 'color', 'r')
hold on
plot(tout1, yout2(:, 2), 'color', 'g')
plot(tout1, yout3(:, 2), 'color', 'b')

subplot(3, 1, 3)
plot(tout1, yout1(:, 3), 'color', 'r')
hold on
plot(tout1, yout2(:, 3), 'color', 'g')
plot(tout1, yout3(:, 3), 'color', 'b')
%
% plot3(yout1(:,1),yout1(:,2),yout1(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','r')
% hold on
% plot3(yout2(:,1),yout2(:,2),yout2(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','g')
% plot3(yout3(:,1),yout3(:,2),yout3(:,3), 'o','MarkerEdgeColor','none','MarkerFaceColor','b')
