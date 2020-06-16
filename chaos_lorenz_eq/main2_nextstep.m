clear
close all

saveflag = true;

%%
% % Construct a questdlg with three options
% choice = questdlg('Do you want to save the result(s)?', ...
%     'Saving opptions', ...
%     'Yes', 'No', 'No');
% % Handle response
% switch choice
%     case 'Yes'
%         saveflag = true;
%     case 'No'
%         saveflag = false;
% end

%%
% ���[�����c�������̕ϐ��ݒ�
a = 10;
b = 28;
c = 8/3;
% ���ԍ���
dt = 2.5 * 1e-5;


% �`��Ɋ֘A����ϐ�
xmax = 20;
ymax = 30;
zmin = 0; zmax = 50;
% fig = figure('position', [100, 100, 800, 600], 'color', [1/255, 1/255, 1/255]);
fig = figure('position', [100, 100, 1024, 768], 'color', [1/255, 1/255, 1/255]);
set(fig, 'DoubleBuffer', 'off');

n = 5 * 1e5;        % �v�Z����f�[�^��
m = 1e4;            % ���ۂɕ`�悷��_
q = zeros(n, 3);    % �v�Z���ʂ�ۑ�����s��
mycolor = hsv(360).*0.8 + ones(360,3).*0.2;

%%
% 1��ڂ̕`��
% n�X�e�b�v���Ԃ̐��l�ϕ����s��(�I�C���[�@)
load("initial value.mat")

% 3������2�����ɗ��Ƃ�
X = q(:, 1);
Y = q(:, 2) .* cos(1 * pi / 360) + (q(:, 3) - 30) * sin(1 * pi / 360);

% n�̓_��S���`�悷��Əd������̂ŁA���̂���m�����`��
for i = 1:m
    p(i) = plot(X(i * n / m), Y(i * n / m));
    p(i).Marker = 'o';
    p(i).MarkerSize = 3;
    p(i).MarkerEdgeColor = 'none';
    p(i).MarkerFaceColor = mycolor(1, :) * (i / m);
    hold on
end

axis([-xmax xmax -ymax ymax], 'off')
drawnow
F = getframe(gcf);

x = q(n / 100, 1);
y = q(n / 100, 2);
z = q(n / 100, 3);

% 2��ڈȍ~�̕`��́A�_�̍��W��ς��邾��
for j = 1:4 * 360

    for i = 1:n
        dx = -a * x + a * y;
        dy = -x * z + b * x - y;
        dz = x * y - c * z;
        q(i, :) = [x+dx*dt y+dy*dt z+dz*dt];

        x = x + dx * dt;
        y = y + dy * dt;
        z = z + dz * dt;
    end

    X = q(:, 1);
    Y = q(:, 2) .* cos(j * pi / 360) + (q(:, 3) - 30) * sin(j * pi / 360);

    for i = 1:m
        p(i).XData = X(i * n / m);
        p(i).YData = Y(i * n / m);
        if mod(j, 360) < 180
            p(i).MarkerFaceColor = mycolor(mod(j, 360) + 1, :) * (i / m);
        else
            p(i).MarkerFaceColor = mycolor(361 - mod(j, 360), :) * (i / m);
        end

    end

    axis([-xmax xmax -ymax ymax], 'off')
    drawnow

    if saveflag == true
        F = [F, getframe(gcf)];
    end

    x = q(n / 100, 1);
    y = q(n / 100, 2);
    z = q(n / 100, 3);
end


if saveflag == true
    videoobj = VideoWriter([date,'movie2.mp4'],'MPEG-4');
    fprintf('video generating...')
    open(videoobj);
    writeVideo(videoobj, F);
    close(videoobj);
    fprintf('complete!\n')
    save('initial value2','q')
end
