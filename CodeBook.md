# Code Book for the course project of Coursera course "Getting and cleaning data"


## Background
This files should clarify the process of obtaining the tidy data set from the original data.
The source of the original data is from an experiment which involved the measurement of different sensors in a mobile phone while several test persons did distinguished activities (e.g. sitting, walking etc.).
The overall goal of the collection of data is to develop algorithms that can guess the current activity based on the readings from the smartphone's sensors.


## Original data
The original data used in this project was taken from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

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


## Processing steps to obtain a tidy data set


## Variables in the tidy data set