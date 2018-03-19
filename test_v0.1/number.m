 
% read a image
I = imread('9_hw.png');

% process image
I = rgb2gray(I);         % to gray scale
I = imbinarize(I);       % to binary (0 and 1)
I = imcomplement(I);     % reverse black and white (0 and 1)

% thinning the image to lines of single pixel wide.
% by doing so, we rmove all other properties of the image and only keep its shape
% this method is from stackoverflow by Cecilia
% https://stackoverflow.com/questions/30166166/unwanted-branches-in-thinning-process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I = bwmorph(I,'thin',Inf);
% 
% %Alternative splitting method to 'branchpoint'
% %Use convolution to identify points with more than 2 neighboring pixels
% filter = [1 1 1;
%     1 0 1;
%     1 1 1];
% 
% I_disconnect = I & ~(I & conv2(double(I), filter, 'same')>2);
% 
% cc = bwconncomp(I_disconnect);
% numPixels = cellfun(@numel,cc.PixelIdxList);
% [sorted_px, ind] = sort(numPixels);
% 
% % Remove components shorter than threshold
% % This value vary for different input image
% % We need a threshold of 100 to process "5" but 10 to process "4"
% threshold  = 100;
% for ii=ind(sorted_px < threshold)
%     cur_comp = cc.PixelIdxList{ii};
%     I(cur_comp) = 0;
%     
%     %Before removing component, check whether image is still connected
%     full_cc = bwconncomp(I);
%     if full_cc.NumObjects>1
%         I(cur_comp) = 1;
%     end
% end
% 
% %Clean up left over spurs
% I = bwmorph(I, 'spur');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% remove empty entry in the position array
% position(position==0) = [];
% position = reshape(position,2,[])';

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

figure;
imshow(I);
hold on
%plot(colCenter,rowCenter,'ro');


plot(mappedPosition(:,2), mappedPosition(:,1),'ro');


% running variable
t = linspace(0,2*pi,1000);

% without scalling, the circle won't cover the entire number
% this scaling factor vary for different number
scale = 1;
x = colCenter + scale*r*sin(t);
y = rowCenter + scale*r*cos(t);

%// draw circle
%line(x,y)

axis equal

