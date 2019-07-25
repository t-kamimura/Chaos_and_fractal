function[tout,yout]=rungekutta4(ode,dt,T_range,y_ini)
    t_ini = T_range(1);
    t_end = T_range(2);
    tout = t_ini:dt:t_end;
    yout = zeros(length(tout),length(y_ini));
    yout(1,:)=y_ini;
    steps=length(tout);
    h = waitbar(0,'please wait...');
    for i=1:steps-1
        step = i-1;
        waitbar(step/steps)

        k1 = ode(tout(i),yout(i,:));
        k2 = ode(tout(i)+0.5*dt,yout(i,:)+0.5*dt*k1);
        k3 = ode(tout(i)+0.5*dt,yout(i,:)+0.5*dt*k2);
        k4 = ode(tout(i)+dt,yout(i,:)+dt*k3);
        yout_=yout(i,:)+dt*(k1+2*k2+2*k3+k4)/6;
        yout(i+1,:)=yout_;
    end
    delete(h)       % DELETE the waitbar; don't try to CLOSE it.
end