# run_analysis.R
# created on 03/01/2018
# Aziz Mohammed
#
# the script run_analysis.R collects, works with and finally cleans the training and testing
# datasets collected from the accelerometers of the Samsung Galaxy S smartphone
#
# upload the zipped test and train datasets from the source website and unzip
#
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "traintestData.zip")
unzip("traintestData.zip", list =TRUE)
#
# use dplyr and data.table packages to read and convert the text files to data frames
#
library(dplyr)
library(data.table)
#
# read the components of the train dataset
#
trainactivities <- read.table("./train/y_train.txt", header = FALSE)
trainfeatures <- read.table("./train/X_train.txt", header = FALSE)
trainsubjects <- read.table("./train/subject_train.txt", header = FALSE)
#
activitiesnames <- read.table("activity_labels.txt", header = FALSE)
#
# read the components of the test dataset
#
testactivities <- read.table("./test/y_test.txt", header = FALSE)
testfeatures <- read.table("./test/X_test.txt", header = FALSE)
testsubjects <- read.table("./test/subject_test.txt", header = FALSE)
#
# Give descriptive names to variables in train and test datasets
#
names(trainfeatures) <- features$V2
names(testfeatures) <- features$V2
names(trainactivities) <- "activities"
names(testactivities) <- "activities"
names(trainsubjects) <- "subjects"
names(testsubjects) <- "subjects"
#
# merge the train and test datasets together
#
traindataset <- cbind(trainsubjects, trainactivities, trainfeatures)
testdataset <- cbind(testsubjects, testactivities, testfeatures)
traintest <- rbind(traindataset, testdataset)
#
# Extract only the measurements on the mean and standard deviation for each measurement.
# first eliminate duplicate columns
#
traintest <- traintest[ ,unique(colnames(traintest))]
traintest <- select(traintest, subjects, activities, contains('mean()'), contains('std()'))
#
# Uses descriptive activity names to name the activities in the data set
# to simplify typing and space use x and y as dataframes for intermediate results 
#
x <- arrange(traintest, activities)
y <- mutate(x, activities = as.character(factor(activities, levels = 1:6, labels = activitiesnames$V2)))
#
# label the data set with descriptive variable names
#
names(y) <- gsub("tBodyAcc-", "body acceleration in time domain", names(y))
names(y) <- gsub("tBodyAccMag-", "body acceleration in time-FFT domain", names(y))
names(y) <- gsub("tBodyAccJerk-", "body acceleration jerk in time domain", names(y))
names(y) <- gsub("tBodyAccJerkMag-", "body acceleration jerk in time-FFT domain", names(y))
names(y) <- gsub("tGravityAcc-", "gravity acceleration  in time domain", names(y))
names(y) <- gsub("tBodyAccMag-", "gravity acceleration  in time-FFT domain", names(y))
names(y) <- gsub("tBodyGyro-", "body acceleration  in time domain", names(y))
names(y) <- gsub("tBodyGyroMag-", "body acceleration  in time-FFT domain", names(y))
names(y) <- gsub("tBodyGyroJerk-", "body acceleration jerk  in time domain", names(y))
names(y) <- gsub("tBodyGyroJerkMag-", "body acceleration jerk  in time-FFT domain", names(y))
names(y) <- gsub("fBodyAcc-", "body acceleration in frequency domain", names(y))
names(y) <- gsub("fBodyAccMag-", "body acceleration in frequency-FFT domain", names(y))
names(y) <- gsub("fBodyAccJerk-", "body acceleration jerk in frequency domain", names(y))
names(y) <- gsub("fBodyAccJerkMag-", "body acceleration jerk in frequency-FFT domain", names(y))
names(y) <- gsub("fBodyGyro-", "body acceleration  in frequency domain", names(y))
names(y) <- gsub("fBodyGyroMag-", "gravity acceleration  in frequency-FFT domain", names(y))
names(y) <- gsub("mean()", "mean", names(y))
names(y) <- gsub("sstd()", "std", names(y))
#
# creates a second, independent tidy data set with the average of each variable for each 
# activity and each subject.
#
groupedtraintestdata <- y %>% group_by(subjects, activities) %>% summarize_all(mean)
write.table(groupedtraintestdata, "tidytraintestdata.txt", row.name = FALSE)
