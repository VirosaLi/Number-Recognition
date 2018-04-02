% read a image
I = imread('9_hw.png');

% process image
I = rgb2gray(I);         % to gray scale
I = imbinarize(I);       % to binary (0 and 1)
I = imcomplement(I);     % reverse black and white (0 and 1)

% calculate the center of the number
dim = size(I);
row = 1;
col = 2;
N = 1;
distToOrigin_row = 0;
distToOrigin_col = 0;
for i = 1:dim(row)
   for j = 1 : dim(col)
       if (I(i,j)==1)
          % sum up each point's distance to the origin
          distToOrigin_row = distToOrigin_row + i;
          distToOrigin_col = distToOrigin_col + j;
          N = N + 1;
       end
   end
end
rowCenter = round(distToOrigin_row/N);
colCenter = round(distToOrigin_col/N);


% recenter the image
reCenterDist = [ round(dim(row)/2 - rowCenter), round(dim(col)/2 - colCenter)];
I = circshift(I,reCenterDist);

% get the position of the new origin
rowCenter = round(dim(row)/2);
colCenter = round(dim(col)/2);
center = [rowCenter,colCenter];

% store all pixel to a position array
N = 1;
rowMax = 0;
rowMin = Inf;
colMax = 0;
colMin = Inf;
position = zeros(100000,2);
for i = 1:dim(row)
   for j = 1 : dim(col)
       if (I(i,j)==1)
          % store each point in a array
          position(N,:) = [i,j];
          N = N + 1;
          
          if (i > rowMax)
              rowMax = i;
          end
          
          if (i < rowMin)
              rowMin = i;
          end
          
          if (j > colMax)
              colMax = j;
          end
          
          if (j < colMin)
              colMin = j;
          end
       end
   end
end


mappedPosition = zeros(N-1,2);
minPoint = [0, 0];
minDist = Inf;
tempVec = [0,0;0,0];
tempDist = 0;
midLine = round((rowMax + rowMin)/2);
% mapping
for i = 1:N-1
    
    % check left boundry
    tempVec = [position(i,1), colMin; position(i,:)];
    tempDist = pdist(tempVec,'euclidean');
    if (tempDist < minDist)
       minDist = tempDist; 
       minPoint = [position(i,1),colMin];
    end
    
    % check right boundry
    tempVec = [position(i,1), colMax; position(i,:)];
    tempDist = pdist(tempVec,'euclidean');
    if (tempDist < minDist)
       minDist = tempDist; 
       minPoint = [position(i,1), colMax];
    end
    
    % check top boundry
    tempVec = [rowMin, position(i,2); position(i,:)];
    tempDist = pdist(tempVec,'euclidean');
    if (tempDist < minDist)
       minDist = tempDist; 
       minPoint = [rowMin, position(i,2)];
    end
    
    % check bottom boundry
    tempVec = [rowMax, position(i,2); position(i,:)];
    tempDist = pdist(tempVec,'euclidean');
    if (tempDist < minDist)
       minPoint = [rowMax, position(i,2)];
    end
    
    % check middle line
    tempVec = [midLine, position(i,2); position(i,:)];
    tempDist = pdist(tempVec,'euclidean');
    if (tempDist < minDist)
       minPoint = [midLine, position(i,2)];
    end
    
    mappedPosition(i,:) = minPoint;
    minPoint = [0, 0];
    minDist = Inf;
end



% calculate the "radius" of the number 
% usually this radius won't cover the whole image
r = 0;
for i = 1:N
    vecSub = position(i) - center;
   r = r + dot(vecSub,vecSub);
end
r = round(sqrt(r/N));