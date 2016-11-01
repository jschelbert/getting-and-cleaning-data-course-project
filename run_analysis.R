library(dplyr)
library(reshape2)

## DATASET from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
### TODO:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


features_raw <- read.table("UCI HAR Dataset/features.txt", sep=" ", stringsAsFactors=FALSE)
feature_names <- make.names(names=features_raw[,2], unique=TRUE, allow_ = TRUE)

test_X_raw <- fread("UCI HAR Dataset/test/X_test.txt")
names(test_X_raw) <- feature_names
test_y_raw <- fread("UCI HAR Dataset/test/y_test.txt")
names(test_y_raw) <- c("Labels")
data_test <- cbind(test_y_raw, test_X_raw)

train_X_raw <- fread("UCI HAR Dataset/train/X_train.txt")
names(train_X_raw) <- feature_names
train_y_raw <- fread("UCI HAR Dataset/train/y_train.txt")
names(train_y_raw) <- c("Labels")
data_train <- cbind(train_y_raw, train_X_raw)

data_full <- rbind(data_train, data_test)

data_mean_sd <- data_full %>% select(1, contains("mean"), contains("std"))
