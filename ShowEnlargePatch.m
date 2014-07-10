% ShowEnlargePatch.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    08/07/2013
% Last modified: 08/07/2013
% Explain: The point1 and point2 shuld be form a box(point = [x,y])
% Parameter: 
%          imgRec: The show image
%          point1, point2: The show area (point =(x,y))
%          lr: The corner of place (1:left-uper, 2:right-uper, 3:left-down, 4:right-down)
%          offset: offset =(x,y)
%          mag: The multiple of enlargement 
%          
% -------------------------------------------------------------------

function ShowEnlargePatch(imgRec, point1, point2, lr, offset, mag, lineStyle, color)
    % ----------- Check the Parameter ---------
    if nargin < 3 || nargin > 8,
        error('The input should be grater than three and less than 8');
    end
    if nargin <4,
        lr = 1;
    end
    if nargin < 5,
        offset = [3, 3];
    end
    if nargin < 6,
        mag = 2;
    end
    if nargin < 7,
        lineStyle = '-';
    end
    if nargin < 8
        color = 'r';
    end
    if length(offset) == 1,
        offset = [offset, offset];
    end
    assert(size(point1, 1)==size(point2,1) && size(point2,1)==length(lr)...
        && size(point2,1)==size(offset,1) && size(point2,1)==length(mag));
    % ------------------------------------------
    
    % ----------------- Generate the image ---------------
    w = size(imgRec, 2);
    h = size(imgRec, 1);
    for ii =1:size(point1, 1),
        ww = point2(ii, 1)-point1(ii, 1)+1;
        hh = point2(ii, 2)-point1(ii, 2)+1;
        patch = imresize(imgRec(point1(ii, 2):point1(ii, 2)+hh, point1(ii, 1):point1(ii, 1)+ww, :), mag(ii));
        wp = size(patch, 2);
        hp = size(patch, 1);

        switch lr(ii),
            case 1,% The left-upper
                imgRec(offset(ii, 2):offset(ii, 2)+size(patch,1)-1, offset(ii, 1):offset(ii, 1)+size(patch,2)-1, :) = patch;
            case 2,% The right-upper
                imgRec(offset(ii, 2):offset(ii, 2)+hp-1, w-offset(ii, 1)-wp+1:w-offset(ii, 1), :) = patch;
            case 3,% The left-down
                imgRec(h-offset(ii, 2)-hp+1:h-offset(ii, 2), offset(ii, 1):offset(ii, 1)+wp-1, :) = patch;
            case 4,% The right-down
                imgRec(h-offset(ii, 2)-hp+1:h-offset(ii, 2), w-offset(ii, 1)-wp+1:w-offset(ii, 1), :) = patch;
            otherwise,
                error('There is only four cornor');
        end
    end
     
    % ---------------- Show ------------------
    h = ShowImageGrad(imgRec);
    for ii =1:size(point1, 1),
        ww = point2(ii, 1)-point1(ii, 1)+1;
        hh = point2(ii, 2)-point1(ii, 2)+1;
        patch = imresize(imgRec(point1(ii, 2):point1(ii, 2)+hh, point1(ii, 1):point1(ii, 1)+ww, :), mag(ii));
        wp = size(patch, 2);
        hp = size(patch, 1);

        switch lr(ii),
            case 1,% The left-upper
                ShowAddBox(h, point1(ii, :), point2(ii, :), lineStyle, color);
                ShowAddBox(h, offset(ii, :), offset(ii, :)+[size(patch,2), size(patch,1)], lineStyle, color);
            case 2,% The right-upper
                ShowAddBox(h, point1(ii, :), point2(ii, :), lineStyle, color);
                ShowAddBox(h, [w-offset(ii, 1)-wp+1, offset(ii, 2)], [w-offset(ii, 1), offset(ii, 2)+hp-1], lineStyle, color);
            case 3,% The left-down
                ShowAddBox(h, point1(ii, :), point2(ii, :), lineStyle, color);
                ShowAddBox(h, [offset(ii, 1), h-offset(ii, 2)-hp+1], [offset(ii, 1)+wp-1, h-offset(ii, 2)], lineStyle, color);
            case 4,% The right-down
                ShowAddBox(h, point1(ii, :), point2(ii, :), lineStyle, color);
                ShowAddBox(h, [w-offset(ii, 1)-wp+1, h-offset(ii, 2)-hp+1], [w-offset(ii, 1), h-offset(ii, 2)], lineStyle, color);
            otherwise,
                error('There is only four cornor');
        end

    end
    
end