% ShowAddBox.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    08/07/2013
% Last modified: 10/07/2013
% Explain: The point1 and point2 shuld be form a box(point = [x,y])
% -------------------------------------------------------------------

function ShowAddBox(handle, point1, point2, lineStyle, color)
    % --------- Check the Parameters -----
    if nargin < 3 || nargin > 5,
        error('The input should be greater than one');
    end
    if nargin <4,
        lineStyle = '-';
    end
    if nargin <5,
        color = 'r';
    end  
    % ------------------------------------
    if prod(point1 - point2) < 0,
        error('The two point should be form a box');
    end
    
    figure(handle);
    hold on
    pointX = [point1(1) point1(1) point2(1) point2(1) point1(1)];
    pointY = [point1(2) point2(2) point2(2) point1(2) point1(2)];
    plot(pointX', pointY', 'color', color, 'lineStyle', lineStyle);
    hold off
end