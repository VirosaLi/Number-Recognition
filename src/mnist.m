
% load mnist dataset if it's not in the workspace
if ~exist('test', 'var') && ~exist('training', 'var')
    try
        load('mnist.mat')
    catch
       disp('Error: file mnist.mat cannot be found.') 
    end
end

frameNumber = 8;
r = 1;

% try to load the std frame if it's not in the workspace
if ~exist('stdFrame', 'var')
    try
        load('stdFrame.mat')
    catch
        disp('Standerd frame file cannot be found. Generating...')
        
        % if the std frame file is not in the folder, generate it.
        % set the number of frame and size reduce rate
        % each frame will reduce its size by 2r
        stdFrame = stdFrameGenerator(frameNumber, r);
    end
end

% constants
nDigit = 10;

% set the index of the frame we want to use
frameIndex = 5;

% set the factors for short strokes removal
rowFactor = 1.2;
colFactor = 1.1;

% initilaize arrays to store the result images and similarities
P = zeros(test.width, test.height, test.count);
similarity = zeros(nDigit, test.count);

% using parallel for loop to preforme the calculation
% if user doesn't have the parallel computing toolbox
% change it to normal for loop
parfor i = 1:test.count
    % map the image to frame
    temp = MapToFrame_PointCharge(test.images(:,:,i), frameIndex);
    
    % remove short strokes
    P(:,:,i) = removeShortStroke( temp, frameIndex, rowFactor, colFactor )
    
    % calculate similarity of the image
    similarity(:, i) = getSimilarity(P(:, :, i), stdFrame, frameIndex);
end

% evaluate the result
result = evaluate(similarity, test);

% print out the final result
disp(result)
