library(dplyr)
library(data.table)
library(assertthat)

## DATASET from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
### TODO:
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


features_raw <- read.table("UCI HAR Dataset/features.txt", sep=" ", stringsAsFactors=FALSE)
feature_names <- make.names(names=features_raw[,2], unique=TRUE, allow_ = TRUE)

activities_raw <- read.table("UCI HAR Dataset/activity_labels.txt", sep=" ", colClasses = c("integer","factor"), col.names=c("id","Activity"))

test_X_raw <- fread("UCI HAR Dataset/test/X_test.txt")
assert_that(length(feature_names) == ncol(test_X_raw))
names(test_X_raw) <- feature_names
test_y_raw <- fread("UCI HAR Dataset/test/y_test.txt")
names(test_y_raw) <- c("Activity_id")
test_subject_raw <- fread("UCI HAR Dataset/test/subject_test.txt")
names(test_subject_raw) <- c("Subject")
data_test <- cbind(test_subject_raw, test_y_raw, test_X_raw)

train_X_raw <- fread("UCI HAR Dataset/train/X_train.txt")
assert_that(length(feature_names) == ncol(train_X_raw))
names(train_X_raw) <- feature_names
train_y_raw <- fread("UCI HAR Dataset/train/y_train.txt")
names(train_y_raw) <- c("Activity_id")
train_subject_raw <- fread("UCI HAR Dataset/train/subject_train.txt")
names(train_subject_raw) <- c("Subject")
data_train <- cbind(train_subject_raw, train_y_raw, train_X_raw)

# 1) Merges the training and the test sets to create one data set.
data_full <- rbind(data_train, data_test)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
data_mean_sd <- data_full %>% select(1, 2, contains("mean"), contains("std"))


# 3) Uses descriptive activity names to name the activities in the data set
data_mean_sd_activity_names <- left_join(data_mean_sd, activities_raw, by=c("Activity_id"="id"))

# 4) Appropriately labels the data set with descriptive variable names.
# --> already done in loading step

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- data_mean_sd_activity_names %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))

write.table(tidydata, "tidydata.txt")
