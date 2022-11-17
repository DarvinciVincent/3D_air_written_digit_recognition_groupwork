%% Load all data files in format of 'stroke_*.mat' available in the directory and store them into a cell array
% Note: In order to run this function, those data files must be available 
% in the same directory as this file.
% This file outputs one matlab data file raw_data.mat having 2 variables 
% raw_data and data_class

%% Step 1: Load and store all raw stroke data file into a cell array
% All files with .mat suffix
mat = dir('stroke_*.mat');
% Initialize a cell array to store 3D time-series data samples
raw_data = {};
file_struct = struct();
for q = 1:length(mat) 
    file_struct = load(mat(q).name);
    raw_data{q}=file_struct.pos;
end

%% Step 2: Create a vector containing sample class
% (data files are loaded in the order that 100 samples for each class from 0 to 9)
data_class = [];
for num = 0:9
    data_class = [data_class; num*ones(100, 1)];
end

%% Step 3: Clear temporary varibles (comment this if desired)
clear file_struct mat num q;
%% Step 4:Save loaded raw data (this step is commented to avoid configuration in raw_data set)
% save raw_data.mat raw_data data_class

