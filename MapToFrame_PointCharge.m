function [P] = MapToFrame_PointCharge(I, length)

% index for row and col
row = 1;
col = 2;

% find the max and min index of the number
% [max, min] = findBoundries(I, length);

% find the center of the number
% center = findCenter(I, length);

% find the frame by reduce length by 2r;
r = 7;
[max, min] = findReducedFrame(length, r);

% calculate the position of the middle line, the upper charge
% and the lower charge
midLineRow = round((max(row)+min(row))/2);
upperCharge = [(min(row)+midLineRow)/2, (max(col)+min(col))/2];
lowerCharge = [(midLineRow+max(row))/2, (max(col)+min(col))/2];

% map the number to the frame
P = zeros(length,length);
for i = 1:length
    for j = 1:length
        if (I(i,j) ~= 0)
            if (i < midLineRow)
                % the point is located at the upper frame
                
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
                
                if( topFrameCol >= min(col) && topFrameCol <= max(col) && i <= upperCharge(row) )
                    % the mapped point is at the top
                    P(min(row),topFrameCol) = P(min(row),topFrameCol) + I(i,j);
                    continue;
                    
                elseif( midFrameCol >= min(col) && midFrameCol <= max(col) && i >= upperCharge(row) )
                    % the mapped point is in the middle
                    P(midLineRow,midFrameCol) = P(midLineRow,midFrameCol) + I(i,j);
                    continue;
                    
                elseif( leftFrameRow >= min(row) && leftFrameRow <= midLineRow && j <= upperCharge(col) )
                    % the mapped point is on the left
                    P(leftFrameRow,min(col)) = P(leftFrameRow,min(col)) + I(i,j);
                    continue;
                    
                elseif( rightFrameRow >= min(row) && rightFrameRow <= midLineRow && j >= upperCharge(col) )
                    % the mapped point is on the right
                    P(rightFrameRow,max(col)) = P(rightFrameRow,max(col)) + I(i,j);
                    continue;
                    
                end
                
            elseif (i >= midLineRow)
                % the point is located at the lower frame
                
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
                
                if( midFrameCol >= min(col) && midFrameCol <= max(col) && i <= lowerCharge(row) )
                    % the mapped point is in the middle
                    P(midLineRow,midFrameCol) = P(midLineRow,midFrameCol) + I(i,j);
                    continue;
                    
                elseif( bottomFrameCol >= min(col) && bottomFrameCol <= max(col) && i >= lowerCharge(row) )
                    % the mapped point is at the bottom
                    P(max(row),bottomFrameCol) = P(max(row),bottomFrameCol) + I(i,j);
                    continue;
                    
                elseif( leftFrameRow >= midLineRow && leftFrameRow <= max(row) && j <= lowerCharge(col) )
                    % the mapped point is on the left
                    P(leftFrameRow,min(col)) = P(leftFrameRow,min(col)) + I(i,j);
                    continue;
                    
                elseif( rightFrameRow >= midLineRow && rightFrameRow <= max(row) && j >= lowerCharge(col) )
                    % the mapped point is on the right
                    P(rightFrameRow,max(col)) = P(rightFrameRow,max(col)) + I(i,j);
                    continue;
                end
            end
        end
    end
end
end

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
% function [center] = findCenter(I, length)
% 
% N = 0;
% distToOrigin_row = 0;
% distToOrigin_col = 0;
% for i = 1:length
%     for j = 1:length
%         if (I(i,j) ~= 0)
%             % sum up each point's distance to the origin
%             distToOrigin_row = distToOrigin_row + i;
%             distToOrigin_col = distToOrigin_col + j;
%             N = N + 1;
%         end
%     end
% end
% center = [round(distToOrigin_row/N), round(distToOrigin_col/N)];
% end

% find the max and min index of the frame after scaling
function [max, min] = findReducedFrame(length, r)
max = [length - r, length - r];
min = [r, r];
end