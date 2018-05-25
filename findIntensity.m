function [ Intensity ] = findIntensity( P, StandardFrame, r )

nDigit = 10;
[rowSize, colSize] = size(P);
Intensity = zeros(nDigit,1);
for k = 1:nDigit
    count = 0;
    sum = 0;
    currFrame = StandardFrame(:,:,k,r);
    for i = 1:rowSize
        for j = 1:colSize
            sum = sum + 1;
            if currFrame(i,j) == 1
                if P(i,j) == 0
                   % count = count - 1;
                else
                    count = count + 1;
                end
            end
           
        end
    end
    Intensity(k,1) = count/sum;
end
end