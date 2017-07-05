library(plyr)

# Merge the training and test sets to create one data set
xData <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))
yData <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))
subjectData <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))

# Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table("features.txt")
desiredFeatures <- grep("-(mean|std)\\(\\)", features[, 2])
activityLabel <- read.table("activity_labels.txt")
xData <- xData[ , desiredFeatures]
yData[, 1] <- activityLabel[yData[ , 1], 2]

# Appropriate labels the data set with descriptive variable names
names(xData) <- features[desiredFeatures, 2] 
names(yData) <- "activity"
names(subjectData) <- "subject"

# Create independent tidy data set with the average of each variable for each activity and each subject
compileData <- cbind(xData, yData, subjectData)
desiredData <- ddply(compileData, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(desiredData, "finalData.txt", row.name=FALSE)