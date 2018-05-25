image = 2;           % choose an image
r = 6;               % set the corresponding frame

A = test.images(:,:,image);
B = P(:,:,image);

% plot the result
figure
% the original image
subplot(1,2,1)  
surf(A,'EdgeColor','None');
view(2);  
set(gca,'Ydir','reverse')

% the resulting image
subplot(1,2,2)  
surf(B,'EdgeColor','None');
view(2);
set(gca,'Ydir','reverse')

% calculate intensity and display it
intensity = findIntensity(P(:,:,image),StandardFrame, r);
intensity(:,2) = [1 2 3 4 5 6 7 8 9 0];
disp(intensity);
