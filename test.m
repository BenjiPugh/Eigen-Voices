sethHodge = soundSet();
downSampled = [];


% for i = 1 : 18*8
%     downSampled = [downSampled decimate(sethHodge(:, i), 6)];
% end

trainSet = [];
testSet = [];
for i = 1 : size(sethHodge, 2)
    if mod(i, 8) ~= 1
        trainSet = [trainSet sethHodge(:, i)];
    else
        testSet = [testSet sethHodge(:, i)];
    end
end



[accuracy, voiceSpaceTrain, voiceSpaceTest, Q, NN, ATrain] = eigenVoices(trainSet, testSet);
Q = Q;
NN = NN;
ATest = ATest;
accuracy = accuracy;