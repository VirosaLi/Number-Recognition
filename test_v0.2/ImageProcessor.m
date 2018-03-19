function I = ImageProcessor(image)

% read a image
I = imread(image);

% process image
I = rgb2gray(I);         % to gray scale
I = imbinarize(I);       % to binary (0 and 1)
I = imcomplement(I);     % reverse black and white (0 and 1)

end

