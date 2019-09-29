% fileName: main_ode_test.m
% initDate: 20190723
% Object:   3重振子の運動方程式を解く．3つの振子を同時に動かす．

clear; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'defaultAxesFontSize',16);
set(0,'defaultAxesFontName', 'Arial');
set(0,'defaultTextFontSize',16);
set(0,'defaultTextFontName', 'Arial');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

param.m1 = 9.0;
param.l1 = 0.9;
param.m2 = 6.0;
param.l2 = 0.6;
param.m3 = 4.0;
param.l3 = 0.4;

param.g = 9.8;

% variables
y_ini_orig = [pi/2 pi/3 pi/2 0 0 0];
y_ini(1,:) = y_ini_orig;
y_ini(2,:) = y_ini_orig + [0 0 0 0 0 1e-6];
y_ini(3,:) = y_ini_orig + [0 0 0 0 0 -1e-6];
y_ini(4,:) = y_ini_orig + [0 0 0 0 1e-6 0];
y_ini(5,:) = y_ini_orig + [0 0 0 0 -1e-6 0];
y_ini(6,:) = y_ini_orig + [0 0 0 1e-6 0 0];
y_ini(7,:) = y_ini_orig + [0 0 0 -1e-6 0 0];
y_ini(8,:) = y_ini_orig + [0 0 0 0 -1e-6 1e-6];
y_ini(9,:) = y_ini_orig + [0 0 0 -1e-6 0 1e-6];
y_ini(10,:) = y_ini_orig + [0 0 0 -1e-6 1e-6 0];
tstart = 0;
tend = 25;
dt = 1e-3;
num = 10;

% ode45の誤差パラメータ
relval = 1e-12;
absval = 1e-12;
refine = 6;

% equation of motion
ode = @(t, y) eom_pendulum(t, y, param);
% options for ode45 function
options = odeset('RelTol', relval, 'AbsTol', absval, 'Refine', refine, 'Stats', 'off'); %ode45のオプションを設定

%% 数値積分
name = ['ODE_RESULTS_num=',num2str(num),'_T=',num2str(tend)];
% Construct a questdlg with three options
choice = questdlg('Do you want to calculate?', ...
    'Saving opptions', ...
    'Yes', 'No', 'No');
% Handle response
switch choice
    case 'Yes'
        % 4次のルンゲクッタで微分方程式を解く
        for i=1:num
            [tout, yout(i,:,:)] = rungekutta4(ode, dt, [tstart tend], y_ini(i,:));
        end
        save(name, 'param', 'num', 'dt', 'tout', 'yout')
    case 'No'
        load(name);
end


%% visualize
num = 1;
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
set(h1, 'DoubleBuffer', 'off');
hold on

l1 = param.l1;
l2 = param.l2;
l3 = param.l3;

myclr = hsv(num) .* 0.6 + ones(num, 3) .* 0.4;

for i=1:num
    theta1 = y_ini(i,1);
    theta2 = y_ini(i,2);
    theta3 = y_ini(i,3);
    x1 = l1 * sin(theta1);
    y1 = -l1 * cos(theta1);
    x2 = l1 * sin(theta1) + l2 * sin(theta2);
    y2 = -l1 * cos(theta1) - l2 * cos(theta2);
    x3 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
    y3 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);
    p1(i) = line([0 x1], [0 y1], 'linewidth', 4, 'color', myclr(i, :));
    p2(i) = line([x1 x2], [y1 y2], 'linewidth', 3, 'color', myclr(i, :));
    p3(i) = line([x2 x3], [y2 y3], 'linewidth', 2, 'color', myclr(i, :));
end

strng = [num2str(0, '%.2f'), ' s'];
t = text(1.2, -3.0, strng, 'color', 'w', 'fontsize', 20);
axis equal
xlim([-2 2])
ylim([-3.5 0.5])
axis off

F = [];
n = 1;

for i_t = 1:20:length(tout)
    %cla

    strng = [num2str(tout(i_t), '%.3f'), ' s'];
    t.String = strng;
    %     t = text(1.2,-3.0,strng,'color','w','fontsize',16);
    for i=1:num
        theta1 = yout(i, i_t, 1);
        theta2 = yout(i, i_t, 2);
        theta3 = yout(i, i_t, 3);
        x11 = l1 * sin(theta1);
        y11 = -l1 * cos(theta1);
        x21 = l1 * sin(theta1) + l2 * sin(theta2);
        y21 = -l1 * cos(theta1) - l2 * cos(theta2);
        x31 = l1 * sin(theta1) + l2 * sin(theta2) + l3 * sin(theta3);
        y31 = -l1 * cos(theta1) - l2 * cos(theta2) - l3 * cos(theta3);

        p1(i).XData = [0 x11];
        p1(i).YData = [0 y11];
        p2(i).XData = [x11 x21];
        p2(i).YData = [y11 y21];
        p3(i).XData = [x21 x31];
        p3(i).YData = [y21 y31];
    end

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
hold on
for i=1:num
    plot(tout, yout(i, :, 1), 'color', myclr(i, :))
end
ylabel('$$\theta_1$$','Interpreter','latex')

subplot(3, 1, 2)
hold on
for i=1:num
    plot(tout, yout(i, :, 2), 'color', myclr(i, :))
end
ylabel('$$\theta_2$$','Interpreter','latex')

subplot(3, 1, 3)
hold on
for i=1:num
    plot(tout, yout(i, :, 3), 'color', myclr(i, :))
end
xlabel('time [s]')
ylabel('$$\theta_3$$','Interpreter','latex')