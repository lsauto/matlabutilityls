

img = double(imread('Lena.jpg'));
h = ShowImageGrad(img);

point11 = [322, 76];
point12 = [398, 157];
patch1 = img(point11(2):point12(2), point11(1):point12(1), :);
ShowAddBox(h, point11, point12);
h1 = ShowImageGrad(patch1);
ShowAddBox(h1, [1,1], [point12(1)-point11(1)+1, point12(2)-point11(2)+1]);


point21 = [48, 331];
point22 = [159, 415];
patch2 = img(point21(2):point22(2), point21(1):point22(1), :);
ShowAddBox(h, point21, point22);
h2 = ShowImageGrad(patch2);
ShowAddBox(h2, [1,1], [point22(1)-point21(1)+1, point22(2)-point21(2)+1]);

% ------- Show ----------








