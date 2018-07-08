% find the max and min index of the frame after scaling
function [max, min] = findReducedFrame(frameIndex)
frame_size = 28;
max = [frame_size - (frameIndex-1), frame_size - (frameIndex-1)];
min = [frameIndex, frameIndex];
end