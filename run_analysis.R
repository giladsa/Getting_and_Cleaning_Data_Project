
#setwd("D:/docs/studying/Coursera/Getting_and_Cleaning_Data/project")
###      Requirements: library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="UCI_dataset.zip")
unzip("UCI_dataset.zip")

setwd("./UCI HAR Dataset") # change the working directory to the folder where the files are stored
activity_labels <-read.table("activity_labels.txt")


## read training and test data sets 
test_X_test <- read.table("test/X_test.txt")
train_X_train <- read.table("train/X_train.txt")


## article 1 - Merges the training and the test sets to create one data set.
mergedData <- rbind(train_X_train,test_X_test)

## get the list of features
features <- read.table("features.txt")
means_std <-features[grepl("mean",features$V2) | grepl("std",features$V2),]$V1


# article 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
mergedData_onlyMeanAndStd <- mergedData[,means_std]


# add labels
test_labels <- read.table("test/Y_test.txt")
train_labels <- read.table("train/Y_train.txt")
labels <- rbind(train_labels,test_labels)

labels$name<- apply(labels,1,function(val) {activity_labels[val,]$V2})

# article 3 - Uses descriptive activity names to name the activities in the data set
mergedData_onlyMeanAndStd <- cbind(labels$name,mergedData_onlyMeanAndStd)
names(mergedData_onlyMeanAndStd)[1] <- "activityName"

#create labels names
means_std_labels <-features[grepl("mean",features$V2) | grepl("std",features$V2),]
means_std_labels$V2 <- sub("^t","time",means_std_labels$V2)
means_std_labels$V2 <- sub("^f","freq",means_std_labels$V2)
means_std_labels$V2 <- sub("Acc","Accelerometer",means_std_labels$V2)
means_std_labels$V2 <- sub("Gyro","Gyroscope",means_std_labels$V2)
means_std_labels$V2 <- sub("Mag","Magnitude",means_std_labels$V2)
means_std_labels$V2 <- sub("-mean\\(\\)","Mean",means_std_labels$V2)
means_std_labels$V2 <- sub("-std\\(\\)","Std",means_std_labels$V2)
means_std_labels$V2 <- sub("-meanFreq\\(\\)","Mean",means_std_labels$V2)
means_std_labels$V2 <- sub("-X$","X",means_std_labels$V2)
means_std_labels$V2 <- sub("-Y$","Y",means_std_labels$V2)
means_std_labels$V2 <- sub("-Z$","Z",means_std_labels$V2)

# article 4 - Appropriately labels the data set with descriptive variable names
names(mergedData_onlyMeanAndStd)[2:ncol(mergedData_onlyMeanAndStd)]<-means_std_labels$V2

#read and add subjects
test_subject <- read.table("test/subject_test.txt")
train_subject <- read.table("train/subject_train.txt")
subject <- rbind(train_subject,test_subject)
mergedData_onlyMeanAndStd <-cbind(subject,mergedData_onlyMeanAndStd)
names(mergedData_onlyMeanAndStd)[1] <- "subject"

# create a tidy dataset using plyr library
library(plyr)
# article 5 -  independent tidy data set with the average of each variable for each activity and each subject
tidyDataset<-ddply(mergedData_onlyMeanAndStd,.(subject,activityName),colwise(mean,names(mergedData_onlyMeanAndStd)[3:ncol(mergedData_onlyMeanAndStd)]))
write.table(tidyDataset,"tidyDataset.txt",row.name=FALSE,col.names = FALSE)
