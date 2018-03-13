function [centerRow, centerCol, imageSize] = ImageCenter(I)

% calculate the center of the number
imageSize = size(I);
row = 1;
col = 2;
N = 0;
distToOrigin_row = 0;
distToOrigin_col = 0;
for i = 1:imageSize(row)
   for j = 1 : imageSize(col)
       if (I(i,j)==1)
          % sum up each point's distance to the origin
          distToOrigin_row = distToOrigin_row + i;
          distToOrigin_col = distToOrigin_col + j;
          N = N + 1;
       end
   end
end
centerRow = round(distToOrigin_row/N);
centerCol = round(distToOrigin_col/N);

end

