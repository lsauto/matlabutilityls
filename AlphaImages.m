% AlphaImages.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    03/22/2016
% Last modified: 03/22/2016
% ------------------------------------------------------------------- 

function alphaimg = AlphaImages(img1, img2, alpha)

    % --------- Check the parameters -------
    if ~and(max(img1(:))>1, max(max(img2(:))>1)) && ~and(max(img1(:))<=1, max(img2(:))<=1),
        error('The range of image1 and image2 should be equal.')
    end
    if numel(alpha) == 1,
        alpha = alpha*ones(size(img1,1), size(img1,2));
    end
    if max(alpha(:))>1 || min(alpha(:))<0,
        error('The alpha should less then 1 and grater than 0');
    end        
    if size(img1,3) == 1,
        img1 = repmat(img1, 1, 1, 3);
    end
    if size(img2,3) == 1,
        img2 = repmat(img2, 1, 1, 3);
    end
    img1 = double(img1);
    img2 = double(img2);
    % --------------------------------------
    alphaimg = zeros(size(img1));
    
    alphaimg(:,:,1) = img1(:,:,1).*alpha + img2(:,:,1).*(1-alpha);
    alphaimg(:,:,2) = img1(:,:,2).*alpha + img2(:,:,2).*(1-alpha);
    alphaimg(:,:,3) = img1(:,:,3).*alpha + img2(:,:,3).*(1-alpha);
end