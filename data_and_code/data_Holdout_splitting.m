function [traindata, trainclass, testdata, testclass] = data_Holdout_splitting(data, data_class, TestDataProportion)
% Splitting input data into 2 parts (train set and test
% set) ensuring same proportion of samples of each class per set as the
% proportion of each set in the input data set.
%
%Input:
%   data: Predictor variables, specified as an n-by-p matrix, where n is 
%   the number of observations and p is the number of predictor variables. 
%   Each column of X represents one variable, and each row represents one 
%   observation.
%   class: Response variable, specified as an n-by-1 vector, where n is the
%   number of observations. Each entry in y is the response for the 
%   corresponding row of X.
%   TestDataProportion: Fraction of observations in the test set used for 
%   holdout validation, specified as a scalar in the range (0,1)
%
%Output:
%   traindata: splitted train data set (rows representing features and 
%   columns representing samples)
%   trainclass: sample class of the train data set (1 row and as much 
%   column as the number of samples)
%   testdata: splitted test data set (rows representing features and 
%   columns representing samples)
%   testclass: sample class of the test data set (1 row and as much 
%   column as the number of samples)

% Fix random distribution generator
rng("default");

% The proportion should be less than 1 and 
if TestDataProportion >= 1 || TestDataProportion <= 0
    disp("Invalid input: test data proportion must be less than 1");
    traindata = [];
    trainclass = [];

    testdata = [];
    testclass = [];
else
    trainIdx = [];
    testIdx = [];
    
    Classes = unique(data_class);
    nClass = length(Classes);

    % Loop through each class and split the indices to the given proportion
    for i = 1:nClass
        % find indices of class in question
        classIdxs = find(data_class==Classes(i));
        % number of samples whose class is currently examined
        nIdxclass = length(classIdxs);
        % random permutation of indices of elements of classInds
        randomIdxs = randperm(length(classIdxs))';

        % number of samples with such class in test data
        nTestIdx = round(TestDataProportion*nIdxclass);
        % number of samples with such class in train data
        nTrainIdx = nIdxclass - nTestIdx; 

        % take test indices from vector of indices of class in question
        testlabelIdx = classIdxs(randomIdxs(1:nTestIdx));
        % take train indices from vector of indices of class in question
        trainlabelIdx = classIdxs(randomIdxs(nTestIdx+1:end)); 

        % store train indices of this class
        trainIdx = [trainIdx; trainlabelIdx]; 
        % store test indices of this class
        testIdx = [testIdx; testlabelIdx]; 
    end
    
    % Split data and class based on picked indices of each set
    traindata = data(trainIdx,:);
    trainclass = data_class(trainIdx);

    testdata = data(testIdx,:);
    testclass = data_class(testIdx);
end