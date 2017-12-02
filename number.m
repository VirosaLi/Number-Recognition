
% read a image
I = imread('4.png');

% process image
I = rgb2gray(I);         % to gray scale
I = imbinarize(I);       % to binary (0 and 1)
I = imcomplement(I);     % reverse black and white (0 and 1)

% thinning the image to lines of single pixel wide.
% by doing so, we remove all other properties of the image and only keep its shape
% this method is from stackoverflow by Cecilia
% https://stackoverflow.com/questions/30166166/unwanted-branches-in-thinning-process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = bwmorph(I,'thin',Inf);

%Alternative splitting method to 'branchpoint'
%Use convolution to identify points with more than 2 neighboring pixels
filter = [1 1 1;
    1 0 1;
    1 1 1];

I_disconnect = I & ~(I & conv2(double(I), filter, 'same')>2);

cc = bwconncomp(I_disconnect);
numPixels = cellfun(@numel,cc.PixelIdxList);
[sorted_px, ind] = sort(numPixels);

% Remove components shorter than threshold
% This value vary for different input image
% We need a threshold of 100 to process "5" but 10 to process "4"
threshold  = 5;
for ii=ind(sorted_px < threshold)
    cur_comp = cc.PixelIdxList{ii};
    I(cur_comp) = 0;
    
    %Before removing component, check whether image is still connected
    full_cc = bwconncomp(I);
    if full_cc.NumObjects>1
        I(cur_comp) = 1;
    end
end

%Clean up left over spurs
I = bwmorph(I, 'spur');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dim = size(I);
row = 1;
col = 2;
distToOrigin_row = 0;
distToOrigin_col = 0;
N = 1;
position = zeros(10000,2);
for i = 1:dim(row)
   for j = 1 : dim(col)
       if (I(i,j)==1)
          % sum up each point's distance to the origin
          distToOrigin_row = distToOrigin_row + i;
          distToOrigin_col = distToOrigin_col + j;
          
          % store each point in a array
          position(N,row) = i;
          position(N,col) = j;
          N = N + 1;
       end
   end
end

% remove empty entry in the position array
position(position==0) = [];
position = reshape(position,2,[])';

% calculate the center of the number
rowCenter = round(rowCout/N);
colCenter = round(colCout/N);
center = [rowCenter,colCenter];

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
plot(colCenter,rowCenter,'ro');

% running variable
t = linspace(0,2*pi,1000);

% without scalling, the circle won't cover the entire number
% this scaling factor vary for different number
scale = 2;
x = colCenter + scale*r*sin(t);
y = rowCenter + scale*r*cos(t);

%// draw circle
line(x,y)

axis equal
