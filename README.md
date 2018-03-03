About run_analysis.R script
Aziz Mohammed
March 3, 2018
==================================================================
run_analysis.R downloads data which is collected from an experiment conducted by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita in November 2012. The experiment is conducted while the test subjects perform six activities: (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
The location of the data is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The script run_analysis.R downloads the data from the above website. The downloaded data is composed of several disparate text files containing components of data for testing and training cases. run_analysis. R converts these text files to data frames and merges them into a single train-test data set. The merged data is then processed to give descriptive variable names, reduce it to have only variables with activities and mean and std values. After arranging this reduced data using activities variables, mean values are evaluated for each activity and each subject. Finally, the processed data is copied to a text file as a tidy data set. The following are the steps run-analysis.R uses to achieve the above stated  goals:
1.	The training and testing text files are downloaded into local folders
2.	The downloaded text files are then converted to data frames using R’s dplyr and data.libraray packages.
3.	For the training dataset, the following data frames are created
a.	trainactivities - containing training labels
b.	trainfeatures - containing training set 
c.	trainsubjects - identifies the training subjects who performed the activities
4.	similarly, for the test data set, the following data frames are created
a.	testactivities - containing test labels
b.	testfeatures - containing test set
c.	testsubjects - identifies the test subjects who performed the activities 
5.	activitiesname - links the class labels with their activity name
6.	variables in these data frames are renamed to give descriptive names 
7.	The train dataset elements are merged into a single data frame using column bind function
a.	traindataset <- cbind(trainsubjects, trainactivities, trainfeatures)
8.	The test dataset elements are merged into a single data frame using column bind function 
a.	testdataset <- cbind(testsubjects, testactivities, testfeatures)
9.	Finally, the train and test data sets are merged into a single data frame using row bind function
a.	traintest <- rbind(traindataset, testdataset)
10.	The R select function is applied on the merged traintest dataset to choose only measurements on the mean and standard deviation for each measurement and the activities variables. But make sure to eliminate duplicate columns before using select
11.	run_anaysis.R renames once again most of the feature variables names to make them more descriptive. In so doing, run_analysis.R script uses dummy data frame names like x and y as intermediate steps to simplify naming transient data frames.
12.	Finally, run_analysis.R creates a second, independent tidy data set with the average of each variable for each activity and each subject. The results of this final step are shown in “groupedtraintestdata” (as a data frame) and is also written to text file named: “tidytraintestdata.txt”
