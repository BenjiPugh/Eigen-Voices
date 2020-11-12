sethHodge = soundSet();
downSampled = [];
for i = 1 : 80
    downSampled = [downSampled decimate(sethHodge(:, i), 6)];
end
trainSet = [];
testSet = [];
for i = 1 : size(sethHodge, 2)
    if mod(i, 8) ~= 1
        trainSet = [trainSet downSampled(:, i)];
    else
        testSet = [testSet downSampled(:, i)];
    end
end



eigenVoices(10, trainSet, testSet);

 