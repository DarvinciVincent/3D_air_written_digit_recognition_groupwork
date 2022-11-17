function [normalized_data] = data_normalization(input_data)
% Normalise the input data in a cell array (using min-max scaling method).
% The size of the data matrices does not change.
%
% Input:
%   input_data:  A cell array containing a data matrix of each sample in 
%   each cell
%
% Output:
%   normalized_data: A cell array containing normalized data matrix in each
%   cell

normalized_data = {};
nSamples = length(input_data);
for i=1:nSamples
    sample_min = repmat(min(input_data{1,i}), size(input_data{1,i},1), 1);
    sample_max = repmat(max(input_data{1,i}), size(input_data{1,i},1), 1);
    normalized_data{1,i} = (input_data{1,i}-sample_min)./(sample_max-sample_min);
end