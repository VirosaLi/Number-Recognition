
% check the result.
% plot the original image and the transformed image
% print out the similarity result
%
image = 3;           % choose an image
frameIndex = 5;       % set the corresponding frame

origin = test.images(:, :, image);
result = P(:, :, image);

origin(origin~=0) = 0.3;
result(result~=0) = 1;

compPlot = figure('Name', 'Comparison of digits');
ax1 = axes('Parent', compPlot);
hold(ax1, 'on');
surf(ax1, origin);
surf(ax1, result);
title(ax1, 'Overlay Plot: original and transformed');
hold(ax1, 'off');
set(gca,'Ydir','reverse')

% calculate similarity
sim = zeros(10, 2);
sim(:,1) = [1 2 3 4 5 6 7 8 9 0];
sim(:,2) = getSimilarity(P(:,:,image), stdFrame, frameIndex);

% display the similarity
disp(sim);
