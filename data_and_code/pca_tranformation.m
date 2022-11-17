function transformed_data = pca_tranformation(input_data, coeff, mu, toKeepComponentsIdx)
% Transform the input data by using the PCA transformation with the given
% configurations by subtracting the provided means from the input data and 
% multiplying by the provided coefficients based on the indices of selected
% components
% This function is mainly used to transform the test data with the PCA
% obtained from the train data
%
% Input:
%   input_data: A data matrix (rows representing samples and columns 
%   representing features)
%   coeff: Principal component coefficients, returned as a p-by-p matrix. 
%   Each column of coeff contains coefficients for one principal component.
%   The columns are in the order of descending component variance
%   mu: a row vector of estimated means of the variables in the dataset 
%   used in PCA
%   toKeepComponentsIdx: Indices of components selected
%
%
% Output:
%   transformed_data: A data matrix transformed using the PCA
%   configurations
%   

transformed_data = (input_data-mu)*coeff(:,toKeepComponentsIdx);