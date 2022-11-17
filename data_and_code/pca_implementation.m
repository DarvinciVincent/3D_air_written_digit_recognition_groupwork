%% Implementing PCA (Principal Component Analysis) on data.mat
function [coeff, kept_pcs, scores, explained, mu, toKeepIdx] = pca_implementation(input_data, threshold)
% Implement PCA (Principal Component Analysis) on input data and keep a 
% number of first components which explain up to the given threshold of total variance.
%
% Input:
%   input_data: dataset (rows representing samples and columns representing
%   features)
%   threshold: cutoff of total variance to select components
%
% Output:
%   coeff: Principal component coefficients, returned as a p-by-p matrix. 
%   Each column of coeff contains coefficients for one principal component.
%   The columns are in the order of descending component variance
%   kept_pcs: Selected principal component scores
%   scores: Principal component scores, returned as a matrix. Rows of score
%   correspond to observations, and columns to components.
%   explained: Percentage of the total variance explained by each principal
%   component, returned as a column vector.
%   mu: Estimated means of the variables in input_data, returned as a row
%   vector
%   toKeepIdx: Indices of components selected by the provided threshold

[coeff, scores, ~, ~, explained, mu] = pca(input_data);

% select components according to given threshold
toKeepIdx = 1:find(cumsum(explained) >= threshold,1); % Indices of selected components
kept_pcs = scores(:,toKeepIdx); % selected component scores
fprintf("In order to achieve %d percent of total variance, " + ...
    "%d first components was selected.", threshold, toKeepIdx(end));

% Visualization
figure
pareto(explained);
title('PCA pareto graph');
xlabel('Principal Component');
ylabel('Variance Explained (%)');

figure
biplot(coeff(:,1:2),'Scores',scores(:,1:2));axis([-.2 1 -.4 1]);
title('Principal component Biplot (two first components)');



