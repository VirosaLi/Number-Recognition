
% calculate the final results
function [result] = evaluate(similarity, test)

% constants
nDigit = 10;
board = [1 2 3 4 5 6 7 8 9 0];

% frameIndex = 1;

currect = 0;
totalNumberCounter = zeros(nDigit);
rightNumberCounter = zeros(nDigit);
avgSimilarity = zeros(nDigit);
for i = 1:test.count
    
    % recalculate similarity
    % only use for similarity function turnning
    % similarity = getSimilarity(test.images(:, :, i), stdFrame, frameIndex);
    % [M, I] = max(similarity(:,1));
    
    % use when calculated similarity values are in workspace
    [M, I] = max(similarity(:,i));
    
    % expected number
    expN = test.labels(i);
    
    % predicted number
    currN = board(I);
    
    if expN == 0
        totalNumberCounter(nDigit) = totalNumberCounter(nDigit) + 1;
        avgSimilarity(nDigit) = avgSimilarity(nDigit) + M;
    else
        totalNumberCounter(expN) = totalNumberCounter(expN) + 1;
        avgSimilarity(expN) = avgSimilarity(expN) + M;
    end
    
    
    if currN == expN
        currect = currect + 1;
        if expN == 0
            rightNumberCounter(nDigit) = rightNumberCounter(nDigit) + 1;
        else
            rightNumberCounter(expN) = rightNumberCounter(expN) + 1;
        end
    else
        
    end
end

totalRegnizationRate = currect/test.count;
regnizationRate = rightNumberCounter./totalNumberCounter;
avgSimilarity = avgSimilarity./totalNumberCounter;

% generate string array for the result
result = strings(nDigit+2,1);
result(1) = sprintf('Total Regnization Rate: %f.',totalRegnizationRate);
result(2) = 'Number | Regnization Rate | Average Similarity';
for i = 1:nDigit
    result(i+2) = sprintf('   %d   |     %f     |    %f', board(i), regnizationRate(i), avgSimilarity(i));
end
end

