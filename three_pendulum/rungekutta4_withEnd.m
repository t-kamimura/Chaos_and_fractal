% 4次のルンゲクッタ
function[tout_new,yout]=rungekutta4_withEnd(ode1,dt,T_range,y_ini,goal,dist)
    t_ini=T_range(1);
    t_end=T_range(2);
    tout=t_ini:dt:t_end;
    
    yout(1,:)=y_ini;
    tout_new = t_ini;
    
    steps=length(tout);
    h = waitbar(0,'1','Name','Robot is moving','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(h,'canceling',0)
    set(h, 'HandleVisibility', 'on');

    for i=1:steps-1
        if getappdata(h,'canceling')
            break
        end
        % 今どのへん？
        step = i-1;
        str=['NOW: t=',sprintf('%8.3f',tout(i)),'/',num2str(T_range(2))];
        waitbar(step/steps,h,str)

        
        k1 = ode1(tout(i),yout(i,:));
        k2 = ode1(tout(i)+0.5*dt,yout(i,:)+0.5*dt*k1);
        k3 = ode1(tout(i)+0.5*dt,yout(i,:)+0.5*dt*k2);
        k4 = ode1(tout(i)+dt,yout(i,:)+dt*k3);
        yout_=yout(i,:)+dt*(k1+2*k2+2*k3+k4)/6;
        yout=[yout;yout_];
        tout_new = [tout_new;tout(i)];
        
        r=sqrt((goal.x-yout_(1))^2+(goal.y-yout_(2))^2);
        if r < dist
            break
        end
    end
    
    delete(h)       % DELETE the waitbar; don't try to CLOSE it.
end