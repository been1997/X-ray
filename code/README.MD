The code is written in MATLAB live script. Must be open through using MATLAB.
 - Except preprocessing code which is written in python.
 - Each line is documented on their usage
 - Email us: wbtan7@student.monash.edu/wmang4@student.monash.edu if you have any question.
 
Revision control system
 - In the development of the project, google doc is used
 - Live script allows continous integration of the code by adding new block and lines
 - google doc provide backup document to be restored if needed once uploaded up to few days and limited number of version
 
To use the code, open .mlx file throught MATLAB.
 
Any file or installation will be prompt by MATLAB such as neural network toolbox.
 
 alexnet.mlx - provide alexnet with fine-tuning and SVM codes
 
 googlenet.mlx - provide googlenet with fine-tuning codes
 
Result folder contains the result (score of testing data from each model) matrix
 - load (filename) 
 to load a 'filename'.mat and use in MATLAB
 
Folder structure will be described below:
 * LLC_code -> contains package from Jianchao Yang for LLC coding, files added will be described below
  	* codebook_generation.m  -> generate a codebook
  	* model_30.mat -> SVM model train on 30 images each class
  	* model_full.mat -> SVM model train on all training images provided
  	* Test_Model.mat -> used to test the accuracy of SVM model
 - Result -> contains result from each individual classification model
 - alex_Net.mlx -> code for alexNet with fine-tuning and SVM
 - ClassLabel.mat -> used in fusion_technique.mlx
 - fusion_technique.mlx -> a compilation of fusion technique usage
 - googlenet.mlx -> google net fine-tuning
 - googlenet_svm.mlx -> google net as feature extractor and SVM as classifier
 - preprocessing_50sampling.py -> make every class in training image into 50 images per class
 - preprocessing_oversampling -> perform oversampling
 - squeezenet.mlx -> squeezenet fine-tuning
 
The step to reproduce experiment is described based on phases in testing report:

Phase 1:
	** For each of the code below, setup the correct path for datasets in each code before proceding.**
	 Dataset is available to download in (https://github.com/been1997/X-ray.git)
	1. run code in alex_Net.mlx, googlenet_svm.mlx, googlenet.mlx, squeezenet.mlx 
	
Phase 2,3,4,5:
	1. Save result from phase 1 into .mat file before proceding OR used our result in code/result folder.
	2. run fusion_technique.mlx (run respective technique as needed)
	
Phase 6:
	1. any code can be used. However change setting in the following codes to any data augmentation technique needed
	imageAugmenter = imageDataAugmenter( ...
    'RandRotation',rotationRange, ...
    'RandXShear',shearRange, ...
    'RandYShear',shearRange);

Phase 7:
	1. run preprocessing_50sampling.py or preprocessing_oversampling.py to sample your datasets. Prepare a backup for the dataset before proceding.

Phase 8:
	**set appropriate path directory in each code.**
	1. A codebook is submitted. codebook is can be constructed by running codebook_generation.m.
	2. train our training data using LLC_Test.mat (ignore the code except changing the filename path)
	3. save the SVM model
	4. run Test_Model.m, edit model variable, and filename path
	
Phase 9:
	1. Refer to fusion_technique.mlx
