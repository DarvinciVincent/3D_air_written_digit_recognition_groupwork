function [extracted_data] = feature_extraction(input_data,nTimesteps)
% Extract a desired number of data points (timesteps) per sample to ensure 
% that the output data sample has same size.
% The size of the data matrices is forced to be equal to each other to 
% obtain the consistency in all sample data in the resulting cell array.
%
% Note: Feature may be extracted several rounds until enough timesteps were
% picked as desired
%
% Inputs:
%   input_data:  A cell array containing data matrix of each sample in each
%   cell
%   nTimesteps: The desired number of data points to be extracted
%
% Output:
%   extracted_data: A cell array containing data matrix with the same size as
%   required in each cell

nSamples = length(input_data);
for i = 1:nSamples
    % number of sample timesteps
    sample_Ntimesteps = size(input_data{1,i},1); 
    
    % Identify step between each pick (this is to ensure that only at most 
    % as many as the required number of timesteps can be extracted)
    step_temp = ceil(sample_Ntimesteps/nTimesteps); % number of steps to be skipped between each pick
    timesteps_ind = 1:step_temp:sample_Ntimesteps; % Keep track of indices of timesteps to be extracted
    % In case there is not enough timesteps extracted as desired, the
    % second round of extraction is implemented
    if length(timesteps_ind) ~= nTimesteps
        % step between each pick is kept the same but the begining position
        % to be picked is set at between the two first picked timesteps
        timesteps_temp2 = 1+ceil(step_temp/2):step_temp:sample_Ntimesteps;
        % Identify the number of timesteps to be additionally picked
        Npts_to_add = nTimesteps - length(timesteps_ind);
        % Add the indices of timesteps to be additionally picked as 
        % identified in the second round to the track of indices of timesteps to be extracted
        timesteps_ind = [timesteps_ind timesteps_temp2(1:Npts_to_add)];
    end
    
    % Sort indices before extraction
    timesteps_ind = sort(timesteps_ind);
    % Extract 3D time-series data features as picked
    extracted_data{1,i} = input_data{1,i}(timesteps_ind,:);
end