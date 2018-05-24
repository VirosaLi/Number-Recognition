nDigit = 10;
board = [1 2 3 4 5 6 7 8 9 0];

currect = 0;
totalNumberCounter = zeros(nDigit);
rightNumberCounter = zeros(nDigit);
avgIntensity = zeros(nDigit);
for i = 1:test.count
    [M, I] = max(Intensity(:,i));
    
    expN = test.labels(i);
    currN = board(I);
    
    if expN == 0
        totalNumberCounter(nDigit) = totalNumberCounter(nDigit) + 1;
        avgIntensity(nDigit) = avgIntensity(nDigit) + M;
    else
        totalNumberCounter(expN) = totalNumberCounter(expN) + 1;
        avgIntensity(expN) = avgIntensity(expN) + M;
    end
    
    
    if currN == expN
        currect = currect + 1;
        if expN == 0
            rightNumberCounter(nDigit) = rightNumberCounter(nDigit) + 1;
        else
            rightNumberCounter(expN) = rightNumberCounter(expN) + 1;
        end
    end
end

totalRegnizationRate = currect/test.count;
regnizationRate = rightNumberCounter./totalNumberCounter;
avgIntensity = avgIntensity./totalNumberCounter;

result = strings(nDigit+2,1);
result(1) = sprintf('Total Regnization Rate: %f.',totalRegnizationRate);
result(2) = 'Number | Regnization Rate | Average Intensity';

for i = 1:nDigit
    result(i+2) = sprintf('   %d   |     %f     |    %f', board(i), regnizationRate(i), avgIntensity(i));
end

disp(result)
