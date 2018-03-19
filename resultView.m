figure;
%imshow(test.images(:,:,1));

image = 7;

A = imresize(test.images(:,:,image),20);
B = imresize(P(:,:,image),20);

imshow(A);
figure
imshow(B);


