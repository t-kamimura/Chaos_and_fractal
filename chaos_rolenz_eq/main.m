clear
close all

a = 10;
b = 28;
c = 8/3;
x = 20;
y = 20;
z = 50;
dt = 2.5*1e-5;
xmax = 30;
ymax = 30;
zmin = 0; zmax = 50;
figure('position',[500,500,800,800],'color',[1/255,1/255,1/255])
n = 5*1e5;
q = zeros(n,3);
clr = parula(181);
for j=1:180
    cla
    for i=1:n
        dx = -a*x + a*y;
        dy = -x*z + b*x - y;
        dz = x*y - c*z;
        q(i,:) = [x+dx*dt y+dy*dt z+dz*dt];

        x = x+dx*dt;
        y = y+dy*dt;
        z = z+dz*dt;
    end
    X_ = q(:,1);
    Y_ = q(:,2).*cos(j*pi/360)+(q(:,3)-30)*sin(j*pi/360);
    X = X_*cos(j*pi/360) - Y_*sin(j*pi/360);
    Y = X_*sin(j*pi/360) + Y_*cos(j*pi/360);
    if mod(j,360)<180
        plot(X,Y,'color',clr(mod(j,360)+1,:))
    else
        plot(X,Y,'color',clr(361-mod(j,360),:))
    end
    axis([-xmax xmax -ymax ymax],'off')
    drawnow
    x = q(n/100,1);
    y = q(n/100,2);
    z = q(n/100,3);
end