clear
close all


saveflag = false;

%%
% Construct a questdlg with three options
choice = questdlg('Do you want to save the result(s)?', ...
	'Saving opptions', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        saveflag = true;
    case 'No'
        saveflag = false;
end

a = 10;
b = 28;
c = 8/3;
x = 30;
y = 30;
z = 50;
dt = 2.5*1e-5;
xmax = 20;
ymax = 30;
zmin = 0; zmax = 50;

%fig=figure('position',[0,0,1920,1080],'color',[1/255,1/255,1/255]);
fig=figure('position',[0,0,800,600],'color',[1/255,1/255,1/255]);
if saveflag == false
    n = 1e5;    % 計算するデータ数
    m = 1e2;    % 実際に描画する点
    q = zeros(n,3);
%     clr = bone(m);
    clr = hsv(360);
    % 1回目の描画
    for i=1:n
        dx = -a*x + a*y;
        dy = -x*z + b*x - y;
        dz = x*y - c*z;
        q(i,:) = [x+dx*dt y+dy*dt z+dz*dt];

        x = x+dx*dt;
        y = y+dy*dt;
        z = z+dz*dt;
    end
    X = q(:,1);
    Y = q(:,2).*cos(1*pi/360)+(q(:,3)-30)*sin(1*pi/360);
    for i= 1:m
        p(i)= plot(X(i*n/m),Y(i*n/m));
        p(i).Marker = 'o';
        p(i).MarkerSize = 2;
        p(i).MarkerEdgeColor = 'none';
        p(i).MarkerFaceColor = clr(1,:)*(i/m);
        hold on
    end
    axis([-xmax xmax -ymax ymax],'off')
    drawnow
    x = q(n/100,1);
    y = q(n/100,2);
    z = q(n/100,3);
    % 2回目以降の描画は、点の座標を変えるだけ
    for j=1:360
        for i=1:n
            dx = -a*x + a*y;
            dy = -x*z + b*x - y;
            dz = x*y - c*z;
            q(i,:) = [x+dx*dt y+dy*dt z+dz*dt];

            x = x+dx*dt;
            y = y+dy*dt;
            z = z+dz*dt;
        end
        X = q(:,1);
        Y = q(:,2).*cos(j*pi/360)+(q(:,3)-30)*sin(j*pi/360);
        for i= 1:m
            p(i).XData = X(i*n/m);
            p(i).YData = Y(i*n/m);
            p(i).MarkerFaceColor = clr(j,:)*(i/m);
            if mod(j,360)<180
                p(i).MarkerFaceColor = clr(mod(j,360)+1,:)*(i/m);
            else
                p(i).MarkerFaceColor = clr(361-mod(j,360),:)*(i/m);
            end
        end
        axis([-xmax xmax -ymax ymax],'off')
        drawnow
        x = q(n/100,1);
        y = q(n/100,2);
        z = q(n/100,3);
    end
else

    set(fig,'DoubleBuffer','on');
    %videoobj = VideoWriter([date,'movie.avi'],'Uncompressed AVI');
    videoobj = VideoWriter([date,'movie.avi'],'Motion JPEG AVI');
    open(videoobj);
    

    n = 5*1e5;    % 計算するデータ数
    m = 1e4;      % 実際に描画する点
    q = zeros(n,3);
%     clr = bone(m);
    clr = hsv(360);
    % 1回目の描画
    for i=1:n
        dx = -a*x + a*y;
        dy = -x*z + b*x - y;
        dz = x*y - c*z;
        q(i,:) = [x+dx*dt y+dy*dt z+dz*dt];

        x = x+dx*dt;
        y = y+dy*dt;
        z = z+dz*dt;
    end
    X = q(:,1);
    Y = q(:,2).*cos(1*pi/360)+(q(:,3)-30)*sin(1*pi/360);
    for i= 1:m
        p(i)= plot(X(i*n/m),Y(i*n/m));
        p(i).Marker = 'o';
        p(i).MarkerSize = 3;
        p(i).MarkerEdgeColor = 'none';
        p(i).MarkerFaceColor = clr(1,:)*(i/m);
        hold on
    end
    axis([-xmax xmax -ymax ymax],'off')
    drawnow
    F = getframe(gcf);
    writeVideo(videoobj,F);
    
    x = q(n/100,1);
    y = q(n/100,2);
    z = q(n/100,3);
    
    % 2回目以降の描画は、点の座標を変えるだけ
    for j=1:3*360
        for i=1:n
            dx = -a*x + a*y;
            dy = -x*z + b*x - y;
            dz = x*y - c*z;
            q(i,:) = [x+dx*dt y+dy*dt z+dz*dt];

            x = x+dx*dt;
            y = y+dy*dt;
            z = z+dz*dt;
        end
        X = q(:,1);
        Y = q(:,2).*cos(j*pi/360)+(q(:,3)-30)*sin(j*pi/360);
        for i= 1:m
            p(i).XData = X(i*n/m);
            p(i).YData = Y(i*n/m);
%             p(i).MarkerFaceColor = clr(j,:)*(i/m);
            if mod(j,360)<180
                p(i).MarkerFaceColor = clr(mod(j,360)+1,:)*(i/m);
            else
                p(i).MarkerFaceColor = clr(361-mod(j,360),:)*(i/m);
            end
        end
        axis([-xmax xmax -ymax ymax],'off')
        drawnow
        F = getframe(gcf);
        writeVideo(videoobj,F);
        x = q(n/100,1);
        y = q(n/100,2);
        z = q(n/100,3);
    end
    
    close(videoobj);
end