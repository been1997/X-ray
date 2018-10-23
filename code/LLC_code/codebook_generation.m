clear;
img_dir = 'C:\Users\user\Documents\data\X-ray Data Sets Full\train - Copy - Copy'
data_dir = 'data/Xray';       % directory for saving SIFT descriptors

extr_sift(img_dir, data_dir);

% retrieve the directory of the database and load the codebook
database = retr_database_dir(data_dir);

if isempty(database),
    error('Data directory error!');
end

nFea = length(database.path);
features = [];
n = 0;
B=[];

for iter1 = 1:nFea
    n = n + 1;
    iter1
    fpath = database.path{iter1};
    load(fpath);
    features = [features,feaSet.feaArr];
    
    if (n==100),
        features = [B,features];
        [B,~] = vl_kmeans(features,1024);
        n = 0;
    end
end

features = [B,features];
[B,~] = vl_kmeans(features,1024);

% [~,B] = kmeans(features,10);
save XRay_SIFT_Kmeans_1024 B