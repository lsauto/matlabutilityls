% SaveEps.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    21/05/2013
% Last modified: 23/07/2014
% ------------------------------------------------------------------- 

function SaveEps(fHandle, fileName, bColor)
    if nargin == 2,
        bColor = 0;
    end
    
    dirPath = '.\temp\';
    if ~exist(dirPath, 'dir'),
        mkdir(dirPath);
    end
    fileName = strcat(dirPath, fileName);
    
    if bColor,
        print(fHandle, '-depsc', fileName);
    else
        print(fHandle, '-deps', fileName);
    end

end