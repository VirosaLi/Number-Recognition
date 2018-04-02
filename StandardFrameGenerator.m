% generate the standard frame for numbers

function [ StandardFrame ] = StandardFrameGenerator(length, r, N)

nDigit = 10;
StandardFrame = zeros(length,length,nDigit,N);
for i = 1:N
    reduce = (i-1)*r;
    
    min = 1 + reduce;
    max = length - reduce;
    mid = length/2;
    
    % generate frame for 1
    temp = zeros(length,length);
    temp(min,min:max) = 0;
    temp(mid,min:max) = 0;
    temp(max,min:max) = 0;
    temp(min:max,min) = 0;
    temp(min:max,max) = 1;
    StandardFrame(:,:,1,i) = temp;
    
    % generate frame for 2
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 1;
    temp(mid:max,min) = 1;
    temp(min:mid,max) = 1;
    StandardFrame(:,:,2,i) = temp;
    
    % generate frame for 3
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 1;
    temp(min:max,min) = 0;
    temp(min:max,max) = 1;
    StandardFrame(:,:,3,i) = temp;
    
    % generate frame for 4
    temp = zeros(length,length);
    temp(min,min:max) = 0;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 0;
    temp(min:mid,min) = 1;
    temp(min:max,max) = 1;
    StandardFrame(:,:,4,i) = temp;
    
    % generate frame for 5
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 1;
    temp(min:mid,min) = 1;
    temp(mid:max,max) = 1;
    StandardFrame(:,:,5,i) = temp;
    
    % generate frame for 6
    temp = zeros(length,length);
    temp(min,min:max) = 0;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 1;
    temp(min:max,min) = 1;
    temp(mid:max,max) = 1;
    StandardFrame(:,:,6,i) = temp;
    
    % generate frame for 7
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 0;
    temp(max,min:max) = 0;
    temp(min:max,min) = 0;
    temp(min:max,max) = 1;
    StandardFrame(:,:,7,i) = temp;
    
    % generate frame for 8
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 1;
    temp(min:max,min) = 1;
    temp(min:max,max) = 1;
    StandardFrame(:,:,8,i) = temp;
    
    % generate frame for 9
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 1;
    temp(max,min:max) = 0;
    temp(min:mid,min) = 1;
    temp(min:max,max) = 1;
    StandardFrame(:,:,9,i) = temp;
    
    % generate frame for 0
    temp = zeros(length,length);
    temp(min,min:max) = 1;
    temp(mid,min:max) = 0;
    temp(max,min:max) = 1;
    temp(min:max,min) = 1;
    temp(min:max,max) = 1;
    StandardFrame(:,:,10,i) = temp;
end

save('StandardFrame.mat','StandardFrame')
end


