% ShowAddBox.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    08/07/2013
% Last modified: 18/06/2015
% Explain: The point1 and point2 shuld be form a box(point = [x,y])
% -------------------------------------------------------------------

function ShowAddBox(handle, point1, point2, lineStyle, color)
    np = size(point1, 1);
    % --------- Check the Parameters -----
    if nargin < 3 || nargin > 5,
        error('The input should be greater than one');
    end
    if nargin <4,
        lineStyle = '-';
    end
    if nargin <5,
%         color = repmat([255 0 0], np, 1);
        color = colormap(jet(np));
    end  
    % ------------------------------------
    if all(prod(point1-point2, 2)<0),
        error('The two point should be form a box');
    end
    
    figure(handle);
    hold on
    pointX = [point1(:,1) point1(:,1) point2(:,1) point2(:,1) point1(:,1)];
    pointY = [point1(:,2) point2(:,2) point2(:,2) point1(:,2) point1(:,2)];
    pointX = pointX';
    pointY = pointY';
    for ii=1:np,
        plot(pointX(:, ii), pointY(:, ii), 'color', color(ii, :), 'lineStyle', lineStyle);
    end
    hold off
end