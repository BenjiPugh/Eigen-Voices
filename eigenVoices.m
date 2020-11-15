function [accuracy, voiceSpaceTrain, voiceSpaceTest, Q, Delta] = eigenVoices(numPrincipalComponents, ATrain, ATest)
ATrain = ATrain';
ATest = ATest';

% mean center the train and test data
ATrain = ATrain - mean(ATrain);
ATest = ATest - mean(ATest);

% get covariance matrix of the training data
covar = ATrain'*ATrain;

% get EVD (so we can do PCA)
% If you want all of the Eigenvectors / Eigenvalue, you can use eig:
% [Q, Delta] = eig(covar);

% if you wan to just get the eigenvectors swith largest eigenvalues
% you can use eigs.
[Q, Delta] = eigs(covar, numPrincipalComponents);
Q
Delta

%{
% visualize the principal components as images
f = figure;
for i = 1 : numPrincipalComponents
    subplot(ceil(sqrt(numPrincipalComponents)), ceil(sqrt(numPrincipalComponents)), i);
    imagesc(reshape(Q(:,i), [64 64]));  % TODO: remove hardcoding
    colormap('gray');
    % make the axes have equal length and square
    axis equal 
    axis square
end
%}

for i = 1 : numPrincipalComponents
    
    voices = audioplayer(Q(:, i), 48000/6);
    play(voices);
    pause(0);
end
% project into face space
voiceSpaceTrain = Q'*ATrain';
voiceSpaceTest = Q'*ATest';




% go through each image in the test set and find its 
% Eucledian distance from each face in the train set, all in face space
% Find the nearest image in the train set to each test image

subjectTest = (1:10)';

num_sound_test = size(voiceSpaceTest, 2);  
num_sound_train = size(voiceSpaceTrain, 2); 
% pre-create vectors to store distances between the k-th test face and all
% the training faces, and a vector which stores the index of the 
% nearest-neigbor. NaN is a MATLAB command which creates an array of NaN
% (not a numbers) with specified dimensions. 
distances_in_face_space = NaN(num_sound_train, 1); 
NN = NaN(num_sound_test,1);
%{
for k=1:num_sound_test  % loop through all the test images
    for n = 1:num_images_train % loop through all the training images
        
        % calculte the distance between the k-th face in the test set to the n-th face
        % in the training set and store the distances
        % note that faceSpaceTest and faceSpaceTrain are 2-D arrays
        % and sum sums along the columns, so we sum twice
        distances_in_face_space(n) = sqrt(sum(sum((voiceSpaceTest(:,k)-voiceSpaceTrain(:,n)).^2)));
    
    end
    % find the minimum of the distances between the kth test face and all the
    % training faces
    [tmp, idx] = min(distances_in_face_space);
    % assign the index corresponding to the nearesest image in the training
    % set as the nearest neighbor to the kth image
    NN(k) = idx;
end
%}

% Instead of looping through each test image and each training image, in
% the previous block of code, you can use MATLAB's knnsearch function
% which does the same thing instead
% we've commented this out here 
NN = knnsearch(voiceSpaceTrain', voiceSpaceTest');


% let's check to see if the subject corresponding to the second closest
% photo is the same as the one corresponding to the query image
%    accuracy = mean(subjectTrain(NN)==subjectTest);
accuracy = 1;
end


