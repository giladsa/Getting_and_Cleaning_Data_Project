CodeBook
========

The purpose of this Codebook is to explain how to prepare tidy data that can be used for later analysis based on ["Human Activity Recognition Using Smartphones Data Set"] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Variables
The variables names are based on the following format:
1. time of frequency - what was measured. **Unit**: seconds and Hz
2. body or gravity - either the body or the gravity acceleration signal
3. Accelerometer or Gyroscope - The sensor that emit the data
4. Optional - Jerk or Magnitude
5. Mean or Std - the staticial function
6. Optional X, Y, Z - the directions

#### Examples:
  * timeBodyGyroscopeJerkMeanX - time of body Gyroscope sensor - calculate Jerk Mean  of dimension X
  * freqBodyGyroscopeMeanY - frequency of body from Gyroscope sensor - calucate mean of dimension Y


### Requirements:
library(plyr)

### **Step reproduce the work (You can also follow the comments inside the run_analysis.R file)**

1. Download the file from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. unzip it
3. You can find the files descriptions under "README.txt" in the extracted folder
4. Read the both training and test samples and merge them
5. read the list of features (from feature.txt) and filter only those that contain either "mean" or "std"
5. Read the labels files ("y_test","y_train"") and also "activity_labels.txt" and merge and augment the labels with a descriptibe name
6. add the labels to the merged data
7. In order to provide meaningful names, you can rename some of the attributes
8. Add the subjects who participanted to the merged data. This data exists in: "test/subject_test.txt" and "train/subject_train.txt"
9. Create a dataset using ddply is the most tricky part ...

