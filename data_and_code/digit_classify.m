function C = digit_classify(mdl, new_sample)
%Function C = digit_classify(mdl, testdata) takes input as a matrix N*3 data sample
% of an air-written digit collected by LeapMotion sensor and does the 
% recognition of the written digit.
%Input:
%   new_sample: a matrix N*3 data sample (N number of 3-D location datapoint trajectories)
%Output:
%   C: The label of the written digit predicted by the provided model
    
    %% Turn sample data from a matrix to a cell array with one cell because
    % of input format of called functions
    new_sample_cell ={};
    new_sample_cell{1,1} = new_sample;
    % number of timesteps (data points) of the given to-be-classified sample
    nTimesteps = size(new_sample_cell{1},1);
    % Load data.mat
    load data.mat
    % Set flag to catch special case
    IsSpecial = false;
    %% Step 1: Normalize data
    new_sample_cell = data_normalization(new_sample_cell);
    
    %% Step 2: Extract features to ensure consistent size of data sample and
    model_data_size = size(data,2)/3;
    % If the input testdata sample has more timesteps than the
    % data samples used to train the model, the testdata sample needs to
    % proceed feature extraction
    if nTimesteps > model_data_size
        new_sample_cell = feature_extraction(new_sample_cell, model_data_size);
    % SPECIAL CASE: MODEL RETRAINING NEEDED
    elseif nTimesteps < model_data_size
        % Catch special case
        IsSpecial = true;
        % There is no need to extract feature for the given new data
        % sample because its number of datapoints is the new standard
        
        % Repreprocess raw data
        load raw_data.mat
        normalized_traindata = data_normalization(raw_data);
        extracted_traindata = feature_extraction(normalized_traindata,nTimesteps);
        train_data = data_reallocation(extracted_traindata);
        [new_coeff, new_trainX, new_score, new_explained, new_mu, new_toKeepComponentsIdx] = pca_implementation(train_data, 98);
        % Retrain model and identify parameters
        new_mdl = fitcecoc(new_trainX,trainclass,'Learners',t_final,'FitPosterior',true,'ClassNames',0:9);
    end
    %% Step 3: Reallocate test data sample (turn a cell array with one cell into a column vector)
    new_sample_vec = data_reallocation(new_sample_cell);
    %% Step 4: PCA transformation
    if IsSpecial
        new_sample_vec = pca_tranformation(new_sample_vec, new_coeff, new_mu, new_toKeepComponentsIdx);
    else
        load pca_output.mat
        new_sample_vec = pca_tranformation(new_sample_vec, coeff, mu, toKeepComponentsIdx);
    end
    %% Step 5: Predict label for input test data sample
    if nTimesteps < model_data_size
        % SPECIAL CASE: USE RETRAINED PARAMETERS
        C = predict(new_mdl,new_sample_vec);
    else
        % NORMAL CASE: USE TRAINED PARAMETERS
        C = predict(mdl,new_sample_vec);
    end
    
       
    