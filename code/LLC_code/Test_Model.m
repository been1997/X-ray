% =========================================================================
% written in 22/10/2018 by Tan Wei Been
% =========================================================================
clear all; close all; clc;

% -------------------------------------------------------------------------
% parameter setting
pyramid = [1, 2, 4];                % spatial block structure for the SPM
knn = 5;                            % number of neighbors for local coding
c = 10;                             % regularization parameter for linear SVM
                                    % in Liblinear package
mem_block = 3000;                   % maxmum number of testing features loaded each time  
% -------------------------------------------------------------------------

img_dir = 'C:\Users\user\Documents\data\X-ray Data Sets Full\valid';       % directory for the image database                             
data_dir = 'data/XrayValid';       % directory for saving SIFT descriptors
fea_dir = 'features/XrayValid';    % directory for saving final image features

addpath('Liblinear/windows');    % add path

extr_sift(img_dir, data_dir);

% retrieve the directory of the database and load the model and codebook
database = retr_database_dir(data_dir);

if isempty(database),
    error('Data directory error!');
end

load model_full

Bpath = ['dictionary/half_Xray_dataset_2400.mat'];

load(Bpath);
nCodebook = size(B, 2);              % size of the codebook

% extract image features

dFea = sum(nCodebook*pyramid.^2);
nFea = length(database.path);

fdatabase = struct;
fdatabase.path = cell(nFea, 1);         % path for each image feature
fdatabase.label = zeros(nFea, 1);       % class label for each image feature

for iter1 = 1:nFea,  
    if ~mod(iter1, 5),
       fprintf('.');
    end
    if ~mod(iter1, 100),
        fprintf(' %d images processed\n', iter1);
    end
    fpath = database.path{iter1};
    flabel = database.label(iter1);
    
    load(fpath);
    [rtpath, fname] = fileparts(fpath);
    feaPath = fullfile(fea_dir, num2str(flabel), [fname '.mat']);
%    load(feaPath, 'fea', 'label');     
     fea = LLC_pooling(feaSet, B, pyramid, knn);
     label = database.label(iter1);

     if ~isdir(fullfile(fea_dir, num2str(flabel))),
         mkdir(fullfile(fea_dir, num2str(flabel)));
     end      
     save(feaPath, 'fea', 'label');

    
    fdatabase.label(iter1) = flabel;
    fdatabase.path{iter1} = feaPath;
end;

clabel = unique(fdatabase.label);
nclass = length(clabel);

ts_idx = [];
for jj = 1:nclass,
    idx_label = find(fdatabase.label == clabel(jj));
    ts_idx = [ts_idx;idx_label];
end

% load the testing features
ts_num = length(ts_idx);
ts_label = [];

ts_fea = zeros(length(ts_idx), dFea);
ts_label = zeros(length(ts_idx), 1);

for jj = 1:length(ts_idx),
    fpath = fdatabase.path{ts_idx(jj)};
    load(fpath, 'fea', 'label');
    ts_fea(jj, :) = fea';
    ts_label(jj) = label;
end

[C,~,t] = predict(ts_label, sparse(ts_fea), model);


% normalize the classification accuracy by averaging over different
% classes
acc = zeros(nclass, 1);

for jj = 1 : nclass,
    c = clabel(jj);
    idx = find(ts_label == c);
    curr_pred_label = C(idx);
    curr_gnd_label = ts_label(idx);    
    acc(jj) = length(find(curr_pred_label == curr_gnd_label))/length(idx);
end

% accuracy = mean(acc); 
% fprintf('Accuracy: %f\n' , accuracy);