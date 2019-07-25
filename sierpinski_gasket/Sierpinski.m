clear
close all

%% settings
l0 = 10;
x(1) = 10;
y(1) = x(1)*sqrt(3)*0.5;

h1 = figure;
h1.InnerPosition = [100,100,800,800];
h1.Color=[1/255 1/255 1/255];

hold on
axis equal
axis off

global mylinewidth

mylinewidth = 1;

%% 1個目
line([0.5*l0 0],[0 0.5*l0*sqrt(3)],'color','w','linewidth',mylinewidth)
line([-0.5*l0 0],[0 0.5*l0*sqrt(3)],'color','w','linewidth',mylinewidth)
line([-0.5*l0 0.5*l0],[0 0],'color','w','linewidth',mylinewidth)

%% それ以降
origin = [0,0];
origins(1,:) = origin;
for i = 1:7
    l0 = l0*0.5;
    for j = 1:3^(i-1)
        origin = origins(j,:);
        drowTriangle(origin,l0);
        drawnow
%         pause(0.1)
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
%%
function drowTriangle(origin,l)
    global mylinewidth
    x0 = origin(1);
    y0 = origin(2);
    line([x0 x0-0.5*l],[y0 y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
    line([x0 x0+0.5*l],[y0 y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
    line([x0-0.5*l x0+0.5*l],[y0+0.5*l*sqrt(3) y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
end