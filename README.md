# Getting and Cleaning Data: Course Project
Written by [Amar Faiz Zainal Abidin] (https://sites.google.com/view/amarfaiz-utem/profile?authuser=0)

This repository hosts the codes written by me for Peer-Based Assignment of Data Science's: Getting and Cleaning Data by Coursera.

The dataset used for this assignment is obtained from [UCI Machine Learning Repository] (https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)

----
## How to operate the source code using RGui

1. Open file **peer_assignment_week4.R**

2. Manually set the working directory to the location **peer_assignment_week4.R** is located.

3. Please make sure the [UCI HAR Dataset] (https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones) is in the same folder.

4. Run the script and the result can be found in the same location under the file name **finalData.txt**

----
## Explanation of the source code

a. Load library plyr.

> library(plyr)

b. Merge the training and test sets to create one data set.

> xData <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))

> yData <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))

> subjectData <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))

c. Extract only the measurements on the mean and 
standard deviation for each measurement.

> features <- read.table("features.txt")

> desiredFeatures <- grep("-(mean|std)\\(\\)", features[, 2])

> activityLabel <- read.table("activity_labels.txt")
xData <- xData[ , desiredFeatures]
yData[, 1] <- activityLabel[yData[ , 1], 2]

d. Appropriate labels the data set with descriptive variable names.

> names(xData) <- features[desiredFeatures, 2]
 
> names(yData) <- "activity"

> names(subjectData) <- "subject"

e. Create independent tidy data set with the average of each variable for each activity and each subject

> compileData <- cbind(xData, yData, subjectData)
desiredData <- ddply(compileData, .(subject, activity), function(x) colMeans(x[, 1:66]))

> write.table(desiredData, "finalData.txt", row.name=FALSE)