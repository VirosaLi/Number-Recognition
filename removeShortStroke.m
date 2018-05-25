function [ clearedP ] = removeShortStroke( P, r )

row = 1;
col = 2;
[rowSize, ~] = size(P);
[max, min] = findReducedFrame(rowSize, r);
midLineRow = round((max(row)+min(row))/2);
clearedP = P;

% check the number of non-zero elements on the top
% remove all if less than half
nonZeroElement = nnz(P(min(row), min(col):max(col)));
if nonZeroElement < (max(col)-min(col))/2
    clearedP(min(row), min(col):max(col)) = 0;
end

% check the number of non-zero elements on the mid
% remove all if less than half
nonZeroElement = nnz(P(midLineRow, min(col):max(col)));
if nonZeroElement < (max(col)-min(col))/2
    clearedP(midLineRow, min(col):max(col)) = 0;
end

% check the number of non-zero elements on the bottom
% remove all if less than half
nonZeroElement = nnz(P(max(row), min(col):max(col)));
if nonZeroElement < (max(col)-min(col))/2
    clearedP(max(row), min(col):max(col)) = 0;
end

% check the number of non-zero elements on the top left
% remove all if less than half
nonZeroElement = nnz(P(min(row):midLineRow, min(col)));
if nonZeroElement < (midLineRow-min(row))/1.2
    clearedP(min(row):midLineRow, min(col)) = 0;
end

% check the number of non-zero elements on the bottom left
% remove all if less than half
nonZeroElement = nnz(P(midLineRow:max(row), min(col)));
if nonZeroElement < (max(row)-midLineRow)/1.2
    clearedP(midLineRow:max(row), min(col)) = 0;
end

% check the number of non-zero elements on the top right
% remove all if less than half
nonZeroElement = nnz(P(min(row):midLineRow, max(col)));
if nonZeroElement < (midLineRow-min(row))/1.2
    clearedP(min(row):midLineRow, max(col)) = 0;
end

% check the number of non-zero elements on the bottom right
% remove all if less than half
nonZeroElement = nnz(P(midLineRow:max(row), max(col)));
if nonZeroElement < (max(row)-midLineRow)/1.2
    clearedP(midLineRow:max(row), max(col)) = 0;
end

end

