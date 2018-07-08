
% generate the standard frame for numbers
% frame_number: total number of frame we want to generate
% r: the size of each frame will differ by 2r
%
% Example:
% use command:> imshow(stdFrame(:, :, 2, 4)) to check standard number 
% 2 with 20x20, (28 - 2*4 = 20)
%
function [stdFrame] = stdFrameGenerator(frame_number, r)


% constants
nDigit = 10;
frame_size = 28;
midLine = frame_size/2;

stdFrame = zeros(frame_size, frame_size, nDigit, frame_number);
for i = 1:frame_number
    
    % the size of the frame will reduce by 2r for each iteration
    reduce = (i-1)*r;
    
    % calculate the max and min of the frame
    min = 1 + reduce;
    max = frame_size - reduce;
    
    % generate frame for 1
    % 
    %  ' ' ' ' *
    %  ' ' ' ' * 
    %  ' ' ' ' *
    %  ' ' ' ' *
    %  ' ' ' ' *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min:max, max) = 1;
    stdFrame(:, :, 1, i) = temp;
    
    % generate frame for 2
    % 
    %  * * * * *
    %  ' ' ' ' * 
    %  * * * * *
    %  * ' ' ' '
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1; % top row
    temp(midLine, min:max) = 1; % mid row
    temp(max, min:max) = 1; % bottom row
    temp(midLine:max, min) = 1; % left col
    temp(min:midLine, max) = 1; % right col
    stdFrame(:, :, 2, i) = temp;
    
    % generate frame for 3
    % 
    %  * * * * *
    %  ' ' ' ' * 
    %  * * * * *
    %  ' ' ' ' *
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(midLine, min:max) = 1;
    temp(max, min:max) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 3, i) = temp;
    
    % generate frame for 4
    % 
    %  * ' ' ' *
    %  * ' ' ' * 
    %  * * * * *
    %  ' ' ' ' *
    %  ' ' ' ' *
    % 
    temp = zeros(frame_size, frame_size);
    temp(midLine, min:max) = 1;
    temp(min:midLine, min) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 4, i) = temp;
    
    % generate frame for 5
    % 
    %  * * * * *
    %  * ' ' ' ' 
    %  * * * * *
    %  ' ' ' ' *
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(midLine, min:max) = 1;
    temp(max, min:max) = 1;
    temp(min:midLine, min) = 1;
    temp(midLine:max, max) = 1;
    stdFrame(:, :, 5, i) = temp;
    
    % generate frame for 6
    % 
    %  * ' ' ' '
    %  * ' ' ' ' 
    %  * * * * *
    %  * ' ' ' *
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(midLine, min:max) = 1;
    temp(max, min:max) = 1;
    temp(min:max, min) = 1;
    temp(midLine:max, max) = 1;
    stdFrame(:,:,6,i) = temp;
    
    % generate frame for 7
    % 
    %  * * * * *
    %  ' ' ' ' * 
    %  ' ' ' ' *
    %  ' ' ' ' *
    %  ' ' ' ' *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 7, i) = temp;
    
    % generate frame for 8
    % 
    %  * * * * *
    %  * ' ' ' * 
    %  * * * * *
    %  * ' ' ' *
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(midLine, min:max) = 1;
    temp(max, min:max) = 1;
    temp(min:max, min) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 8, i) = temp;
    
    % generate frame for 9
    % 
    %  * * * * *
    %  * ' ' ' * 
    %  * * * * *
    %  ' ' ' ' *
    %  ' ' ' ' *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(midLine, min:max) = 1;
    temp(min:midLine, min) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 9, i) = temp;
    
    % generate frame for 0
    % 
    %  * * * * *
    %  * ' ' ' * 
    %  * ' ' ' *
    %  * ' ' ' *
    %  * * * * *
    % 
    temp = zeros(frame_size, frame_size);
    temp(min, min:max) = 1;
    temp(max, min:max) = 1;
    temp(min:max, min) = 1;
    temp(min:max, max) = 1;
    stdFrame(:, :, 10, i) = temp;
end

% save the frame to current folder
save('stdFrame.mat','stdFrame')
clear
end

