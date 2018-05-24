load('mnist.mat')
load('StandardFrame.mat')

nDigit = 10;

r = 6;
P = zeros(test.width,test.height,test.count);
Intensity = zeros(nDigit,test.count);
parfor i = 1:test.count
    % map the image to frame
    P(:,:,i) = MapToFrame_PointCharge(test.images(:,:,i),test.width,r);
    
    % calculate intensity of the image
    Intensity(:,i) = findIntensity(P(:,:,i), StandardFrame, test.width, r);
end
