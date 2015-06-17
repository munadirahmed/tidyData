setwd("~/Documents/Personal/MOOCs/Coursera/Data Science/Getting and Cleaning Data/Project/tidyData/")

library(dplyr)
# Create a new directory to store the tidy dataset if it doesn't already exits
if(!file.exists("TidyDataSet"))
{
    dir.create("TidyDataSet")
}

## Derive columns of interest from datasets

columnIdDF<-read.table(file="./UCI HAR Dataset/features.txt")

columnIdDF<-mutate(columnIdDF,boolLoad = 'NULL')

# Obtain the index number of variables that store the mean and the std of measurements
indexOfMean <-grep("-mean()" ,columnIdDF[,2],fixed=TRUE)
indexOfStd <-grep("-std()" ,columnIdDF[,2],fixed=TRUE)

# merge the columns into one variable:
columnIndex <- c(indexOfMean,indexOfStd)

columnIdDF[columnIndex,3]<-"double" # set the columns that need to be loaded to TRUE

## Training Set

# read all the different text files into R from the train folder:

trainingSubectId <-read.table(file="./UCI HAR Dataset/train/subject_train.txt")
trainingSetData <-read.table(file="./UCI HAR Dataset/train/X_train.txt",colClasses = columnIdDF[,3],col.names = columnIdDF[,2])
trainingSetLabel <-read.table(file="./UCI HAR Dataset/train/y_train.txt")

# Test Set

testSubectId <-read.table(file="./UCI HAR Dataset/test/subject_test.txt")
testSetData <-read.table(file="./UCI HAR Dataset/test/X_test.txt",colClasses = columnIdDF[,3],col.names = columnIdDF[,2])
testSetLabel <-read.table(file="./UCI HAR Dataset/test/y_test.txt")
