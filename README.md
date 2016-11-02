# Getting and cleaning data - Course project
This repository contains all files which are associated with the assignment of
week 4 within the Coursera course "Getting and cleaning data".
This document explains the files wihin the repository and gives some additional
information.


## Task
The overall goal of the assignment is to show that the student is able to handle data, describe his approach when manipulating data and obtaining a tidy data set from potential untidy data sources. For this a analysis script was written to obtain a tidy data set from a real world data set on 

The script **run_analysis.R** should achieve the following (taken from the assignment instructions):

1. Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Files
The following files are contained in the repository:

* **CodeBook.md** contains information about the variables, processing steps and final outcome.
* **README.md** is this very file you are reading at the moment. It (hopefully) explains all files and the background.
* **run_analysis.R** is the main working horse. This file does the reading of the supplied data and processing to get the tidy data set.
* **tidydata.txt** is the product of the script **run_analysis.R** and contains the tidy data set. More precisely it has for every subject and activity the mean of all 


## Prerequisites
In order to run the script, you need the [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) extracted to the root of the repository. In addition, you'll also need the following libraries installed, as they are used in the script:

* dplyr
* data.table
* assertthat


## Execution of the analysis
Just set the working directory to the root folder of the repository, source the script via `source(run_analysis.R)` and then run it by `tidydata <- run_analysis()`. This will also generate the file **tidydata.txt**.