import shutil
import os

# this code will oversample over training data to overcome imbalance dataset
# this code will replicate or copy image data in a class so that every class
# have the same number of image

# specify path name to training folder
path = r"C:\\Users\\user\\Documents\\data\\X-ray Data Sets Full\train"
newpath =  r"C:\\Users\\user\\Documents\\data\\X-ray Data Sets Full\train-50"
folders = ([name for name in os.listdir(path)])

# get maximum number of training image in each folder
#max = 0 
#i = 0
#maxi = ""
#for folder in folders:
#	contents = os.listdir(os.path.join(path,folder)) # get list of contents
#	i += 1
#	if len(contents) > max: # find in each folder the number of files
#		max = len(contents)
#		maxi = folder

max = 50
# for each folder repeatly copy image until all reaches same number of data
for folder in folders:
    this_folder = os.path.join(path,folder)
    contents = os.listdir(this_folder) # get list of contents
    new_folder = os.path.join(newpath,folder)
    os.makedirs(new_folder)
    n = 0
    while(n<max):
        new_file = os.path.join(new_folder,contents[n])
        shutil.copyfile(os.path.join(this_folder,contents[n]),new_file)
        n += 1