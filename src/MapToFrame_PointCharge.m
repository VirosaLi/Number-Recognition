function [P] = MapToFrame_PointCharge(I, frameIndex)

% index for row and col
row = 1;
col = 2;

% get the size of the image
frame_size = 28;

% find the frame by reduce length by 2r;
[max, min] = findReducedFrame(frameIndex);

% calculate the position of the middle line, the upper charge
% and the lower charge
midLineRow = round((max(row)+min(row))/2);
[upperCharge, lowerCharge] = findCharges(I, midLineRow);

% map the number to the frame
P = zeros(frame_size, frame_size);
for i = 1:frame_size
    for j = 1:frame_size
        
        % label the centers of upper and lower frame
        P(upperCharge(row), upperCharge(col)) = 2;
        P(lowerCharge(row), lowerCharge(col)) = 2;
        if (I(i,j) ~= 0)
            
            % the point is located at the upper frame
            if (i < midLineRow)
                
                % if the point is on the same row as the upper charge,
                % move it directly to the left or right frame
                if (i == upperCharge(row))
                    if j <= upperCharge(col)
                        P(i,min(col)) = P(i,min(col)) + I(i,j);
                    elseif j > upperCharge(col)
                        P(i,max(col)) = P(i,max(col)) + I(i,j);
                    end
                    continue;
                end
                
                % connect the point and the charge, calculte the equation of the
                % line, and get the coefficients
                line = polyfit([upperCharge(row), i],[upperCharge(col), j],1);
                a = line(1);
                b = line(2);
                
                % calculate the cross point between the frame and the line
                topFrameCol = round(a*min(row)+b);     % col of frame top
                midFrameCol = round(a*midLineRow+b);   % col of frame mid
                leftFrameRow = round((min(col)-b)/a);  % row of frame left
                rightFrameRow = round((max(col)-b)/a); % row of frame right
                
                % the mapped point is bounded and on the top row
                if( topFrameCol > min(col) && topFrameCol < max(col) && i < upperCharge(row) )
                    
                    % place the point
                    P(min(row), topFrameCol) = P(min(row), topFrameCol) + I(i, j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors on the left
                    P(min(row), topFrameCol-1) = P(min(row), topFrameCol-1) + I(i, j);
                    if(topFrameCol-1 > min(col))
                        P(min(row), topFrameCol-2) = P(min(row), topFrameCol-2) + I(i, j);
                    end
                    
                    % two neighbors on the right
                    P(min(row), topFrameCol+1) = P(min(row), topFrameCol+1) + I(i, j);
                    if(topFrameCol+1 < max(col))
                        P(min(row), topFrameCol+2) = P(min(row), topFrameCol+2) + I(i, j);
                    end
                    continue;
                    
                    % the mapped point is bounded and on the middle row
                elseif( midFrameCol > min(col) && midFrameCol < max(col) && i > upperCharge(row) )
                    
                    % place the point
                    P(midLineRow,midFrameCol) = P(midLineRow,midFrameCol) + I(i,j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors on the left
                    P(midLineRow,midFrameCol-1) = P(midLineRow,midFrameCol-1) + I(i,j);
                    if(midFrameCol-1 > min(col))
                        P(midLineRow,midFrameCol-2) = P(midLineRow,midFrameCol-2) + I(i,j);
                    end
                    
                    % two neighbors on the right
                    P(midLineRow,midFrameCol+1) = P(midLineRow,midFrameCol+1) + I(i,j);
                    if(midFrameCol+1 < max(col))
                        P(midLineRow,midFrameCol+2) = P(midLineRow,midFrameCol+2) + I(i,j);
                    end
                    continue;
                    
                    % the mapped point is bounded and on the left col
                elseif( leftFrameRow > min(row) && leftFrameRow < midLineRow && j <= upperCharge(col) )
                    
                    P(leftFrameRow,min(col)) = P(leftFrameRow,min(col)) + I(i,j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors above
                    P(leftFrameRow-1, min(col)) = P(leftFrameRow-1, min(col)) + I(i, j);
                    if(leftFrameRow-1 > min(row))
                        P(leftFrameRow-2, min(col)) = P(leftFrameRow-2, min(col)) + I(i, j);
                    end
                    
                    % two neighbors below
                    P(leftFrameRow+1, min(col)) = P(leftFrameRow+1, min(col)) + I(i,j);
                    P(leftFrameRow+2, min(col)) = P(leftFrameRow+2, min(col)) + I(i,j);
                    continue;
                    
                    % the mapped point is bounded and on the right col
                elseif( rightFrameRow > min(row) && rightFrameRow < midLineRow && j >= upperCharge(col) )
                    
                    P(rightFrameRow, max(col)) = P(rightFrameRow, max(col)) + I(i, j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors above
                    P(rightFrameRow-1, max(col)) = P(rightFrameRow-1, max(col)) + I(i, j);
                    if(rightFrameRow-1 > min(row))
                        P(rightFrameRow-2, max(col)) = P(rightFrameRow-2, max(col)) + I(i, j);
                    end
                    
                    % two neighbors below
                    P(rightFrameRow+1, max(col)) = P(rightFrameRow+1, max(col)) + I(i, j);
                    P(rightFrameRow+2, max(col)) = P(rightFrameRow+2, max(col)) + I(i, j);
                    continue;
                    
                end
                
                % the point is located at the lower frame
            elseif (i >= midLineRow)
                
                % if the point is on the same row as the lower charge,
                % move it directly to the left or right frame
                if (i == lowerCharge(row))
                    if j <= lowerCharge(col)
                        P(i,min(col)) = P(i,min(col)) + I(i,j);
                    elseif j > lowerCharge(col)
                        P(i,max(col)) = P(i,max(col)) + I(i,j);
                    end
                    continue;
                end
                
                % connect the point and the charge, calculte the equation of the
                % line, and get the coefficients
                line = polyfit([lowerCharge(row), i],[lowerCharge(col), j],1);
                a = line(1);
                b = line(2);
                
                % calculate the cross point between the frame and the line
                midFrameCol = round(a*midLineRow+b);    % col of frame middle
                bottomFrameCol = round(a*max(row)+b);   % col of frame bottom
                leftFrameRow = round((min(col)-b)/a);   % col of frame left
                rightFrameRow = round((max(col)-b)/a);  % col of frame right
                
                % the mapped point is bounded and on the middle row
                if( midFrameCol > min(col) && midFrameCol < max(col) && i < lowerCharge(row) )
                    
                    P(midLineRow,midFrameCol) = P(midLineRow,midFrameCol) + I(i,j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors on the left
                    P(midLineRow, midFrameCol-1) = P(midLineRow, midFrameCol-1) + I(i,j);
                    if(midFrameCol+1 > min(col))
                        P(midLineRow, midFrameCol-2) = P(midLineRow, midFrameCol-2) + I(i,j);
                    end
                    
                    % two neighbors on the right
                    P(midLineRow, midFrameCol+1) = P(midLineRow, midFrameCol+1) + I(i, j);
                    if(midFrameCol+1 ~= max(col))
                        P(midLineRow, midFrameCol+2) = P(midLineRow, midFrameCol+2) + I(i, j);
                    end
                    continue;
                    
                    % the mapped point is bounded and on the bottom row
                elseif( bottomFrameCol > min(col) && bottomFrameCol < max(col) && i > lowerCharge(row) )
                    
                    P(max(row), bottomFrameCol) = P(max(row), bottomFrameCol) + I(i,j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors on the left
                    P(max(row),bottomFrameCol-1) = P(max(row),bottomFrameCol-1) + I(i,j);
                    if(bottomFrameCol+1 > min(col))
                        P(max(row),bottomFrameCol-2) = P(max(row),bottomFrameCol-2) + I(i,j);
                    end
                    
                    % two neighbors on the right
                    P(max(row),bottomFrameCol+1) = P(max(row),bottomFrameCol+1) + I(i,j);
                    if(bottomFrameCol+1 < max(col))
                        P(max(row),bottomFrameCol+2) = P(max(row),bottomFrameCol+2) + I(i,j);
                    end
                    continue;
                    
                    % the mapped point is bounded and on the left col
                elseif( leftFrameRow >= midLineRow && leftFrameRow < max(row) && j <= lowerCharge(col) )
                    
                    P(leftFrameRow, min(col)) = P(leftFrameRow, min(col)) + I(i,j);
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors above
                    P(leftFrameRow-1, min(col)) = P(leftFrameRow-1, min(col)) + I(i,j);
                    P(leftFrameRow-2, min(col)) = P(leftFrameRow-2, min(col)) + I(i,j);
                    
                    % two neighbors below
                    P(leftFrameRow+1, min(col)) = P(leftFrameRow+1, min(col)) + I(i,j);
                    if(leftFrameRow+1 < max(row))
                        P(leftFrameRow+2, min(col)) = P(leftFrameRow+2, min(col)) + I(i,j);
                    end
                    continue;
                    
                    % the mapped point is bounded and on the right col
                elseif( rightFrameRow >= midLineRow && rightFrameRow < max(row) && j >= lowerCharge(col) )
                    
                    P(rightFrameRow,max(col)) = P(rightFrameRow,max(col)) + I(i,j);
                    
                    
                    % the mapped charge affect its neighbors
                    % to create an area effect
                    
                    % two neighbors above
                    P(rightFrameRow-1, max(col)) = P(rightFrameRow-1, max(col)) + I(i, j);
                    P(rightFrameRow-2, max(col)) = P(rightFrameRow-2, max(col)) + I(i, j);
                    
                    % two neighbors below
                    P(rightFrameRow+1, max(col)) = P(rightFrameRow+1, max(col)) + I(i, j);
                    if(rightFrameRow+1 < max(row))
                        P(rightFrameRow+2, max(col)) = P(rightFrameRow+2, max(col)) + I(i, j);
                    end
                    continue;
                end
            end
        end
    end
end
end


% --------------------------Helper Functions-------------------------------

% find the max and min index of the number
% function [max, min] = findBoundries(I, length)
% % index for row and col
% row = 1;
% col = 2;
%
% % find the boundries of the frame
% max = zeros(2);
% min = Inf(2,'single');
% for i = 1:length
%     for j = 1:length
%         if I(i,j) ~= 0
%             if i > max(row)
%                 max(row) = i;
%             end
%             if i < min(row)
%                 min(row) = i;
%             end
%             if j > max(col)
%                 max(col) = j;
%             end
%             if j < min(col)
%                 min(col) = j;
%             end
%         end
%     end
% end
% end

% find the center of the number
function [center] = findCenter(I)

[rowSize, colSize] = size(I);

N = 0;
distToOrigin_row = 0;
distToOrigin_col = 0;
for i = 1:rowSize
    for j = 1:colSize
        if (I(i,j) ~= 0)
            % sum up each point's distance to the origin
            distToOrigin_row = distToOrigin_row + i;
            distToOrigin_col = distToOrigin_col + j;
            N = N + 1;
        end
    end
end
center = [round(distToOrigin_row/N), round(distToOrigin_col/N)];
end


% find cneters of the upper and lower frame to place the charge
function [upper, lower] = findCharges(I, mid)
upper = findCenter(I(1:mid, :));
lower = findCenter(I(mid+1:end, :));
lower(1) = lower(1) + mid;
end