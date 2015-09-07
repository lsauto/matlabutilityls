% plotEllipse.m
% -------------------------------------------------------------------
% Reference: http://www.ilovematlab.cn/thread-233750-1-1.html
% Authors: Sun Li
% Date:    06/09/2015
% Last modified: 07/09/2015
% -------------------------------------------------------------------
% plotEllipse(100, 200, pi/6, 20, 10, 'red', -pi/3, pi/6)
% theta, tstart, tend must be in [-pi, pi], 
% and should be carefull about the image axis, because it different with normal axis.
% if theta in normal axis is clockwise, but if theta in image axis is anticlockwise
% and also should be carefull with line 71 coder: t = atan2(y-cy, x-cx);
% make sure atan2(-(y-cy), x-cx) is not your want.



function plotEllipse(cx, cy, theta, rx, ry, ...
    color, tstart, tend, minx, maxx, miny, maxy)
    
    % ------------- Check Parameters ------
    if nargin < 5,
        error('The number of inputs should be least 5');
    end
    if nargin < 6,
        color = [1 0 0];
    end
    if nargin < 7,
        tstart = -pi;
    end
    if nargin < 8,
        tend = pi;
    end
    if nargin < 9,
        minx = cx-max(rx,ry);
    end
    if nargin < 10,
        maxx = cx+max(rx,ry);
    end
    if nargin < 11,
        miny = cy-max(rx,ry);
    end
    if nargin < 12,
        maxy = cy+max(rx,ry);
    end
    
    br = false; % range in [-pi, pi]
    if tend < tstart,
        br = true; % range in [0, 2pi]
        if tend<0,
            tend = 2*pi + tend;
        end
        if tstart<0,
            tstart = 2*pi + tstart;
        end
        temp = tstart;
        tstart = min(tstart, tend);
        tend = max(temp, tend);
    end
    % -------------------------------------
   
%     ef = @(x, y) (((x-cx)*cos(theta)-(y-cy)*sin(theta)).^2/rx^2 + ...
%                   ((x-cx)*sin(theta)+(y-cy)*cos(theta)).^2/ry^2 - 1);
%     zz = ezplot(ef, [minx maxx miny maxy]);
    function d = ef(x, y)
        if abs(tend-tstart)>=2*pi,
            d = ((x-cx)*cos(theta)-(y-cy)*sin(theta)).^2/rx^2 + ...
                ((x-cx)*sin(theta)+(y-cy)*cos(theta)).^2/ry^2 - 1;
            return;
        end
            
%         t = atan2(-(y-cy), x-cx);
        t = atan2(y-cy, x-cx);
        if br,
            t(t<0) = 2*pi + t(t<0);
        end
        
        d = nan*ones(length(t),1);
        bin = and(t>=tstart, t<=tend);
        d(bin) = ((x(bin)-cx)*cos(theta)-(y(bin)-cy)*sin(theta)).^2/rx^2 + ...
                 ((x(bin)-cx)*sin(theta)+(y(bin)-cy)*cos(theta)).^2/ry^2 - 1;      
    end

    zz = ezplot(@ef, [minx maxx miny maxy]);
    set(zz, 'color', color);
end

