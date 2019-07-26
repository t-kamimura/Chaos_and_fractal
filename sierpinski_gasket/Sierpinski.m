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
axis off

global mylinewidth

mylinewidth = 1;

%% 1��
line([0.5*l0 0],[0 0.5*l0*sqrt(3)],'color','w','linewidth',mylinewidth)
line([-0.5*l0 0],[0 0.5*l0*sqrt(3)],'color','w','linewidth',mylinewidth)
line([-0.5*l0 0.5*l0],[0 0],'color','w','linewidth',mylinewidth)

%% ����ȍ~
origin = [0,0];
origins(1,:) = origin;
F=[];
for i = 1:7
    l0 = l0*0.5;
    for j = 1:3^(i-1)
        origin = origins(j,:);
        drowTriangle(origin,l0);
        drawnow
        if saveflag == true
            F = [F; getframe(gcf)];
        end
%         pause(0.1)
    end
    % ���̃��[�v�Ŏg�p���錴�_�𐶐�
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
function drowTriangle(origin,l)
    global mylinewidth
    x0 = origin(1);
    y0 = origin(2);
    line([x0 x0-0.5*l],[y0 y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
    line([x0 x0+0.5*l],[y0 y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
    line([x0-0.5*l x0+0.5*l],[y0+0.5*l*sqrt(3) y0+0.5*l*sqrt(3)],'color','w','linewidth',mylinewidth)
end