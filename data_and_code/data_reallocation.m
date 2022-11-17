function [reallocated_data] = data_reallocation(input_data)
% Turn a cell array containing N n-by-p data matrix in each
% cell into one matrix N rows and n*p columns.
%
% Input:
%   input_data:  a cell array containing N cells, each which stores 
%   n-by-p data matrix (n is the number of timesteps and p is the number of
%   coordinates)
%
% Output:
%   reallocated_data: A matrix (of size N-by-n*p) containing samples on 
%   rows and features on columns.

reallocated_data = [];
nSamples = length(input_data);

% Loop through all sample in the input cell array
for i=1:nSamples
    sample_temp = [];
    % Loop through all sample timesteps
    for ts = 1 : size(input_data{1,i},1)
        % Turn all location data points into a feature orderly
        % [x1 y1 z1 x2 y2 z2 ...  x19 y19 z19]
        sample_temp = [sample_temp input_data{1,i}(ts,:)];
    
    end
    % Store sample vector, so that the number of columns is equal to 
    % the number of features and the number of rows is the number of 
    % observations 
    reallocated_data = [reallocated_data; sample_temp];
end