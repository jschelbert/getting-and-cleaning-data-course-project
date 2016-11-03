# Code Book for the course project of Coursera course "Getting and cleaning data"


## Background
This files should clarify the process of obtaining the tidy data set from the original data.
The source of the original data is from an experiment which involved the measurement of different sensors in a mobile phone while several test persons did distinguished activities (e.g. sitting, walking etc.).
The overall goal of the collection of data is to develop algorithms that can guess the current activity based on the readings from the smartphone's sensors.


## Original data
The original data used in this project was taken from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The correct citation for the data is as follows:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

A more detailed description of the experiment and data set can be found under
[this link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) that also mentions the original papers written about that data.

### Directory structure of original data
To start with the project, the zip-file was unpacked in the root folder of the repository.
The original data consists of a main folder `UCI HAR Dataset` that contains several files and additional folders `train` and `test`.
For our task we will use the following:

- `features.txt`: List of all features.
- `activity_labels.txt`: Links the class labels with their activity name.
- `train/X_train.txt`: Training set.
- `train/y_train.txt`: Training labels.
- `test/X_test.txt`: Test set.
- `test/y_test.txt`: Test labels.
- `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- `test/subject_test.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


## Variables in the original data
The variables in the original data is described in detail in the file `features_info.txt` within the main folder of the data set (`UCI HAR Dataset`).

## Processing steps to obtain a tidy data set
We start by reading in the file `features.txt` that contains the column names of the training set and test set files.
For smoother handling the names we process the names via the following command which strips out unwanded characters and makes every name unique.
```R
feature_names <- make.names(names = features_raw[, 2],
                   			 unique = TRUE,
                   			 allow_ = TRUE)
```

We then load the activity labels that are contained in the file `activity_labels.txt`.
This data has two columns, the id (column `id`, containing integers) and the activity name (column `activity` read in as a factor).
This is done via the following code.
```R
    activities_raw <- read.table("UCI HAR Dataset/activity_labels.txt",
            					  sep = " ",
            					  colClasses = c("integer", "factor"),
            					  col.names = c("id", "Activity"))
```

For both the test and training data we do the following. We read in the main data set `train/X_train.txt` (or `test/X_test.txt` respectively) and set the names of the columns to `feature_names` which we generated before.

Then also the test/training labels (file `test/y_test.txt` and `train/y_train.txt`) and performing subjects (file `test/subject_test.txt` and `train/subject_train.txt`) are read in.
These files basically consist only of one column.
Finally for both test and training set the content of each of the three files is combined into one data frame for training and test data via the following command.
```R
data_test <- cbind(test_subject_raw, test_y_raw, test_X_raw)
data_train <- cbind(train_subject_raw, train_y_raw, train_X_raw)
```

The data from the training set and the test set are then merged via the `rbind` command.
```R
data_full <- rbind(data_train, data_test)
```

To select only the appropriate columns we use the `select` function from `dplyr` which selects the first two columns (`Subject` and `Activity_id`) and then all columns that contain the word "mean" and all that contain "std" (which stands for standard deviation).
```R
data_mean_sd <- data_full %>% select(1, 2, contains("mean"), contains("std"))
```

In order to have the correct activities as specific names within our data set (and not only the ids) we do a left join with the data frame that contains the mapping of activity ids to activity names.
```R
data_mean_sd_activity_names <- left_join(data_mean_sd, activities_raw, by = c("Activity_id" = "id"))
```

The only remaining step - and the most important one - is to use the data to generate our final tidy data set.
For this we make use of `dplyr`'s nice chaining capabilities.
First we group the data by subject and activity.
Then we summarize all remaining columns, i.e. all but `Subject` and `Activity`, each by taking their mean.
This means that for each combination of subject and activity `dplyr` filters the rows that correspond to that particular combination and then takes the mean of each column.
The last step is to omit the column `Activity_id` since we do not need it.
```R
tidydata <- data_mean_sd_activity_names %>% group_by(Subject, Activity) %>% summarize_each(funs(mean)) %>% select(-3)
```

We decided to opt for a "wide" tidy data format.
See the discussion in the forum or this very neat blog post that explains the issue.
One could easily go to the "long" format by using the `reshape2` package's `melt` command:
```R
tidy_data_long <- melt(tidy_data_wide, c(1,2))
```

For reading in the tidy data set just use the standard command.
```R
tidy_data <- read.table("tidydata.txt")
```

## Variables in the tidy data set
* **Subject** - Identifier of the subject that performed the activitiy
* **Activity** - Activity performed by subject

The remaining variables are the mean for each combination of subject and activity of the entries in the original data set as described before.
For their original meaning we refer to the `features_info.txt` file within the original data set.

* tBodyAcc.mean...X
* tBodyAcc.mean...Y
* tBodyAcc.mean...Z
* tGravityAcc.mean...X
* tGravityAcc.mean...Y
* tGravityAcc.mean...Z
* tBodyAccJerk.mean...X
* tBodyAccJerk.mean...Y
* tBodyAccJerk.mean...Z
* tBodyGyro.mean...X
* tBodyGyro.mean...Y
* tBodyGyro.mean...Z
* tBodyGyroJerk.mean...X
* tBodyGyroJerk.mean...Y
* tBodyGyroJerk.mean...Z
* tBodyAccMag.mean..
* tGravityAccMag.mean..
* tBodyAccJerkMag.mean..
* tBodyGyroMag.mean..
* tBodyGyroJerkMag.mean..
* fBodyAcc.mean...X
* fBodyAcc.mean...Y
* fBodyAcc.mean...Z
* fBodyAcc.meanFreq...X
* fBodyAcc.meanFreq...Y
* fBodyAcc.meanFreq...Z
* fBodyAccJerk.mean...X
* fBodyAccJerk.mean...Y
* fBodyAccJerk.mean...Z
* fBodyAccJerk.meanFreq...X
* fBodyAccJerk.meanFreq...Y
* fBodyAccJerk.meanFreq...Z
* fBodyGyro.mean...X
* fBodyGyro.mean...Y
* fBodyGyro.mean...Z
* fBodyGyro.meanFreq...X
* fBodyGyro.meanFreq...Y
* fBodyGyro.meanFreq...Z
* fBodyAccMag.mean..
* fBodyAccMag.meanFreq..
* fBodyBodyAccJerkMag.mean..
* fBodyBodyAccJerkMag.meanFreq..
* fBodyBodyGyroMag.mean..
* fBodyBodyGyroMag.meanFreq..
* fBodyBodyGyroJerkMag.mean..
* fBodyBodyGyroJerkMag.meanFreq..
* angle.tBodyAccMean.gravity.
* angle.tBodyAccJerkMean..gravityMean.
* angle.tBodyGyroMean.gravityMean.
* angle.tBodyGyroJerkMean.gravityMean.
* angle.X.gravityMean.
* angle.Y.gravityMean.
* angle.Z.gravityMean.
* tBodyAcc.std...X
* tBodyAcc.std...Y
* tBodyAcc.std...Z
* tGravityAcc.std...X
* tGravityAcc.std...Y
* tGravityAcc.std...Z
* tBodyAccJerk.std...X
* tBodyAccJerk.std...Y
* tBodyAccJerk.std...Z
* tBodyGyro.std...X
* tBodyGyro.std...Y
* tBodyGyro.std...Z
* tBodyGyroJerk.std...X
* tBodyGyroJerk.std...Y
* tBodyGyroJerk.std...Z
* tBodyAccMag.std..
* tGravityAccMag.std..
* tBodyAccJerkMag.std..
* tBodyGyroMag.std..
* tBodyGyroJerkMag.std..
* fBodyAcc.std...X
* fBodyAcc.std...Y
* fBodyAcc.std...Z
* fBodyAccJerk.std...X
* fBodyAccJerk.std...Y
* fBodyAccJerk.std...Z
* fBodyGyro.std...X
* fBodyGyro.std...Y
* fBodyGyro.std...Z
* fBodyAccMag.std..
* fBodyBodyAccJerkMag.std..
* fBodyBodyGyroMag.std..
* fBodyBodyGyroJerkMag.std..


## Appendix
I hope you like my explanation :trollface:.