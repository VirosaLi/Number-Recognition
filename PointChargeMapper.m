function [mappedP,midLineRow,upperCharge,lowerCharge] = PointChargeMapper(P, max, min, N)
row = 1;
col = 2;

midLineRow = (max(row)+min(row))/2;
upperCharge = [(max(row)+midLineRow)/2, (max(col)+min(col))/2];

disp(upperCharge);

lowerCharge = [(midLineRow+min(row))/2, (max(col)+min(col))/2];

disp(lowerCharge);

mappedP = zeros(N,2);
for i = 1:N 
    currPoint = P(i,:);
    
    if (currPoint(row) >= midLineRow)
        % the point is located at the upper frame
        
        % connect the point and the charge, calculte the equation of the
        % line, and get the coefficients
        line = polyfit([upperCharge(row), currPoint(row)],[upperCharge(col), currPoint(col)],1);
        a = line(1);
        b = line(2);
        
        % calculate the cross point between the frame and the line
        topFrameCol = a*max(row)+b;     % col of frame top
        midFrameCol = a*midLineRow+b;   % col of frame mid
        leftFrameRow = (min(col)-b)/a;  % row of frame left
        rightFrameRow = (max(col)-b)/a; % row of frame right
        
        if( topFrameCol >= min(col) && topFrameCol <= max(col) && currPoint(row) >= upperCharge(row) )
            % the mapped point is at the top
            mappedP(i,:) = [max(row) topFrameCol];
            continue;
            
        elseif( midFrameCol >= min(col) && midFrameCol <= max(col) && currPoint(row) <= upperCharge(row) )
            % the mapped point is in the middle
            mappedP(i,:) = [midLineRow midFrameCol];
            continue;
            
        elseif( leftFrameRow >= midLineRow && leftFrameRow <= max(row) && currPoint(col) <= upperCharge(col) )
            % the mapped point is on the left
            mappedP(i,:) = [leftFrameRow min(col)];
            continue;
            
        elseif( rightFrameRow >= midLineRow && rightFrameRow <= max(row) && currPoint(col) >= upperCharge(col) )
            % the mapped point is on the right
            mappedP(i,:) = [rightFrameRow max(col)];
            continue;
        end
        
        
    else
        % the point is located at the lower frame
        
        % connect the point and the charge, calculte the equation of the
        % line, and get the coefficients

        line = polyfit([lowerCharge(row), currPoint(row)],[lowerCharge(col), currPoint(col)],1);
        a = line(1);
        b = line(2);
        
        % calculate the cross point between the frame and the line
        midFrameCol = a*midLineRow+b;    % col of frame middle
        bottomFrameCol = a*min(row)+b;   % col of frame bottom
        leftFrameRow = (min(col)-b)/a;   % col of frame left
        rightFrameRow = (max(col)-b)/a;  % col of frame right
        
        if( midFrameCol >= min(col) && midFrameCol <= max(col) && currPoint(row) >= lowerCharge(row) )
            % the mapped point is in the middle
            mappedP(i,:) = [midLineRow midFrameCol];
            continue;
            
        elseif( bottomFrameCol >= min(col) && bottomFrameCol <= max(col) && currPoint(row) <= lowerCharge(row) )
            % the mapped point is at the bottom
            mappedP(i,:) = [min(row) bottomFrameCol];
            continue;
            
        elseif( leftFrameRow >= min(row) && leftFrameRow <= midLineRow && currPoint(col) <= lowerCharge(col) )
            % the mapped point is on the left
            mappedP(i,:) = [leftFrameRow min(col)];
            continue;
            
        elseif( rightFrameRow >= min(row) && rightFrameRow <= midLineRow && currPoint(col) >= lowerCharge(col) )
            % the mapped point is on the right
            mappedP(i,:) = [rightFrameRow max(col)];
            continue;
        end
    end
end
