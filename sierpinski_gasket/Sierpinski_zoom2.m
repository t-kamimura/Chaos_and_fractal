% 途中で三角が増える

clear
close all

%% settings

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

l0 = 10;
x(1) = 10;
y(1) = x(1)*sqrt(3)*0.5;

h1 = figure;
h1.InnerPosition = [100,100,800,800];
h1.Color=[1/255 1/255 1/255];

hold on
axis equal
xmax0 = 0.5*l0;
ytop0 = 0.5;
xlim([-xmax0 xmax0])
ylim([ytop0-2*xmax0 ytop0])
axis off

global mylinewidth mylinecolor

mylinewidth = 1;
mylinecolor = 'w';

%% 1個目
line([0.5*l0 0],[-l0*sin(pi/3) 0],'color',mylinecolor,'linewidth',mylinewidth)
line([-0.5*l0 0],[-l0*sin(pi/3) 0],'color',mylinecolor,'linewidth',mylinewidth)
line([-0.5*l0 0.5*l0],[-l0*sin(pi/3) -l0*sin(pi/3)],'color',mylinecolor,'linewidth',mylinewidth)

%% それ以降
origin = [0,-l0*sin(pi/3)];
origins(1,:) = origin;
F=[];
n=7;
for i = 1:n
    l0 = l0*0.5;
    for j = 1:3^(i-1)
        origin = origins(j,:);
        drowTriangle(origin,l0);
    end
    % 次のループで使用する原点を生成
    origin_ = zeros(3^i,3);
    for j = 1:3^(i-1)
        origin = origins(j,:);
        x0 = origin(1);
        y0 = origin(2);
        origin_(1+3*(j-1),1) = x0;
        origin_(1+3*(j-1),2) = y0 + l0*sqrt(3)*0.5;
        origin_(2+3*(j-1),1) = x0 - 0.5*l0;
        origin_(2+3*(j-1),2) = y0;
        origin_(3+3*(j-1),1) = x0 + 0.5*l0;
        origin_(3+3*(j-1),2) = y0;
    end
    clearvars origins
    origins = origin_;
end

step = 200;
for i = step/2:step
    scale = 1-0.5*(i/step);
    xmax = xmax0*scale;
    ytop = ytop0*scale;
    xlim([-xmax xmax])
    ylim([ytop-2*xmax ytop])
    drawnow
    if saveflag == true
        F = [F; getframe(gcf)];
    end
end

%% 保存
if saveflag == true
    videoobj = VideoWriter([date,'2ndHalf.mp4'],'MPEG-4');
    fprintf('video saving...')
    open(videoobj);
    writeVideo(videoobj, F);
    close(videoobj);
    fprintf('complete!\n');
end

%%
function drowTriangle(origin,l)
    global mylinewidth mylinecolor
    x0 = origin(1);
    y0 = origin(2);
    line([x0 x0-0.5*l],[y0 y0+0.5*l*sqrt(3)],'color',mylinecolor,'linewidth',mylinewidth)
    line([x0 x0+0.5*l],[y0 y0+0.5*l*sqrt(3)],'color',mylinecolor,'linewidth',mylinewidth)
    line([x0-0.5*l x0+0.5*l],[y0+0.5*l*sqrt(3) y0+0.5*l*sqrt(3)],'color',mylinecolor,'linewidth',mylinewidth)
end
function drowTriangle_with_alpha(origin,l,alpha)
    global mylinewidth mylinecolor
    x0 = origin(1);
    y0 = origin(2);
    line([x0 x0-0.5*l],[y0 y0+0.5*l*sqrt(3)],'color',mylinecolor.*alpha,'linewidth',mylinewidth)
    line([x0 x0+0.5*l],[y0 y0+0.5*l*sqrt(3)],'color',mylinecolor.*alpha,'linewidth',mylinewidth)
    line([x0-0.5*l x0+0.5*l],[y0+0.5*l*sqrt(3) y0+0.5*l*sqrt(3)],'color',mylinecolor.*alpha,'linewidth',mylinewidth)
end