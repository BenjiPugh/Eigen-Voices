sethHodge = soundSet();
downSampled = [];
for i = 1 : 18*8
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



[accuracy, voiceSpaceTrain, voiceSpaceTest, Q, Delta,NN] = eigenVoices(10, trainSet, testSet, subjectTrain);
Q = Q;
NN = NN;
accuracy = accuracy;