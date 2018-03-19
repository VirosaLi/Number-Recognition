load('mnist.mat');

P = zeros(test.width,test.height,test.count);
for i = 1:test.width
   P(:,:,i) = MapToFrame_PointCharge(test.images(:,:,i),test.width); 
end
