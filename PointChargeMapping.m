
% constent
row = 1;
col = 2;

% name of the image
image = '3_hw.png';

% read and process the image
I = ImageProcessor(image);

% calculate the center of the number
[centerRow, centerCol, imageSize] = ImageCenter(I);

% recenter the number
reCenterDist = [ round(imageSize(row)/2 - centerRow), round(imageSize(col)/2 - centerCol)];
I = circshift(I,reCenterDist);

% store all pixels to an array and calculte the boudries.
[P, max, min, N] = ImageToArray(I);

% map the all pixels to the frame
[mappedP,midLineRow,upperCharge,lowerCharge] = PointChargeMapper(P, max, min, N);


figure;
imshow(I);
hold on
plot(upperCharge(2),upperCharge(1),'go');
plot(lowerCharge(2),lowerCharge(1),'go');

plot(mappedP(:,2), mappedP(:,1),'ro');

axis equal