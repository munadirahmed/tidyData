# Tidy Data for Coursera Project

The dataset summarises the activity of a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The tidy data set provides an average of multiple measurements made for each activity for each volunteer. It includes records of both the training and test data sets.

A script (run_analysis.R) takes raw data available that was downloaded from the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The folder was unzipped and the placed the same folder as the script. This is important as the script usess relative paths to load the data into R. The data has not been added to the Github accound as it can be downloaded from the link above. Please refer to the README.txt file in that folder to get a detailed description of the different data files and the experimental setup.

The script creates a folder called TidyDataSet (if it doesn't already exits). It uses the 'dplyr' and 'reshape2' library packages which are loaded. Users must install this package in order to be able to run this script properly.

The measurement variable names and activity names are loaded into the R environment. The measurement variables of interest are subsetted from the total list, and the data for the training and test sets are loaded into R. These data sets are combined to form a larger data sets.

Finally, a summary (average) of each set of measurements is provided for each subject across each activity that they perform. This is provided as a dataset for futuer analysis in the TidyDataSet folder.

The file variableNames.txt in the TidyDataSet folder contains all the different variables for the measurements.

For each record it is provided:
======================================

- A SubjectID to indicate the volunteer number
- An ActivityID to indicate the activity the subject was doing when all the measurements were conducted.
- Average on each measurement of interest for 66 different types of measurementes.

The dataset includes the following files:
=========================================
I
- 'README.md'

- 'run_analysis.R': script to create the desired tidy data set from the raw data

- 'UCI HAR Dataset': folder that contains all the data. This is the folder that has to be extracted from the link above.

- 'TidyDataSet/tidyAveragedDataSet.txt': text file containing average values for 66 variables of interest. Each row summarises the average of measurements taken on each subject doing one of six activities.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each column (apart from SubjectID and ActivityID) represents a measurement of interest.