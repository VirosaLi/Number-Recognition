
% remove short strokes to clean up the image
function [ clearedP ] = removeShortStroke( P, frameIndex, rowFactor, colFactor )

% constants
row = 1;
col = 2;

% find max and min index of the reduced frame
[max, min] = findReducedFrame(frameIndex);
midLine = round((max(row)+min(row))/2);
horizLength = max(col) - min(col);
vertiLength = max(row) - midLine;
clearedP = P;

% remove any horizontal parts that have more than
% (total length/row facotr) non-zero elements

% check the number of non-zero elements on the top
nonZeroElement = nnz(P(min(row), min(col):max(col)));
if nonZeroElement * rowFactor < horizLength
    clearedP(min(row), min(col):max(col)) = 0;
end

% check the number of non-zero elements on the mid
nonZeroElement = nnz(P(midLine, min(col):max(col)));
if nonZeroElement * rowFactor < horizLength
    clearedP(midLine, min(col):max(col)) = 0;
end

% check the number of non-zero elements on the bottom
nonZeroElement = nnz(P(max(row), min(col):max(col)));
if nonZeroElement * rowFactor < horizLength
    clearedP(max(row), min(col):max(col)) = 0;
end

% remove any vertical parts that
% have more than (total length/col facotr) non-zero elements
% check top left, bottom left, top right, and bottom right separately

% check the number of non-zero elements on the top left
nonZeroElement = nnz(P(min(row):midLine, min(col)));
if nonZeroElement * colFactor < vertiLength
    clearedP(min(row):midLine, min(col)) = 0;
end

% check the number of non-zero elements on the bottom left
nonZeroElement = nnz(P(midLine:max(row), min(col)));
if nonZeroElement * colFactor < vertiLength
    clearedP(midLine:max(row), min(col)) = 0;
end

% check the number of non-zero elements on the top right
nonZeroElement = nnz(P(min(row):midLine, max(col)));
if nonZeroElement * colFactor < vertiLength
    clearedP(min(row):midLine, max(col)) = 0;
end

% check the number of non-zero elements on the bottom right
nonZeroElement = nnz(P(midLine:max(row), max(col)));
if nonZeroElement * colFactor < vertiLength
    clearedP(midLine:max(row), max(col)) = 0;
end

end

