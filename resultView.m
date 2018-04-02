figure;

image = 2;
r = 5;
scaleFactor = 20;

A = imresize(test.images(:,:,image),scaleFactor);
B = imresize(P(:,:,image),scaleFactor);

imshow(A);
figure
imshow(B);

intensity = findIntensity(P(:,:,image),StandardFrame, test.width, r);
intensity(:,2) = [1 2 3 4 5 6 7 8 9 0];

disp(intensity);
