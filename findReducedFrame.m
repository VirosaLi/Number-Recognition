% find the max and min index of the frame after scaling
function [max, min] = findReducedFrame(length, r)
max = [length-(r-1), length-(r-1)];
min = [r, r];
end