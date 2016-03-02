% -------------------------------------------------------------------
%
% Authors: Sun Li
% Date:    15/04/2013
% Last modified: 20/09/2015
% -------------------------------------------------------------------

% [c11, c12    [dxx, dxy
%  c21, c22] =  dyx, dyy]
% B = -(c11+c22), C = c11*c22-c12*c21
function [postMap, ss] = EigDecBlock(grad, sigma)
    
    % ----- Judge the parameter -------
    if isreal(grad),
        error('The gradient should be complex number');
    end
    
    % ---------------------------------

    winSize = ceil(sigma*6);
    if ~mod(winSize, 2),
        winSize = winSize + 1;
    end
    
    h = fspecial('gauss', [winSize winSize], sigma);
    [hh, ww] = size(grad); 
    ss = zeros(2, hh, ww);

    dx = real(grad);
    dy = imag(grad);
    dxx = imfilter(dx.*dx, h, 'symmetric');
    dxy = imfilter(dx.*dy, h, 'symmetric');
    dyy = imfilter(dy.*dy, h, 'symmetric');
    
    A = ones(size(grad));
    B = -(dxx+dyy);
    C = dxx.*dyy - dxy.*dxy;
    
    ss(1, :, :) = abs((-B+sqrt(B.^2-4*A.*C))./(2*A));
    ss(2, :, :) = abs((-B-sqrt(B.^2-4*A.*C))./(2*A));
    
    V12 = (dxx-dyy + sqrt((dxx-dyy).^2+4*dxy.*dxy))./(2*dxy+eps);
    
    postMap = sqrt(squeeze(ss(1, :, :))).*(V12 + 1i)./sqrt(V12.^2+1+eps);
   
end