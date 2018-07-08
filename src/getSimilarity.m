% compare P with stdFrame to calculate fitness

function [ similarity ] = getSimilarity( P, stdFrame, frameIndex)

nDigit = 10;
similarity = zeros(nDigit,1);

% element by element comparesion
for k = 1:nDigit
    
    % In the transformed image, the centers of upper and lower frame are
    % labeled for visualization purpose. They will affect the similarity,
    % remove them for the most accurate result.
    
    % calculate the Structural Similarity Index (SSIM) for similarity
    similarity(k, 1) = ssim(P, stdFrame(:, :, k, frameIndex));
    
    % the two function below will reduce the accuracy 
    
    % calculates the peak signal-to-noise ratio
    % similarity(k, 1) = similarity(k, 1) + psnr(P, stdFrame(:, :, k, frameIndex));
    
    % calculate the mean-squared error (MSE)
    % similarity(k, 1) = similarity(k, 1) + immse(P, stdFrame(:, :, k, frameIndex));
end
end