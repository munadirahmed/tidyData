##Set the working directory to folder containing run_analysis and the UCI HAR Dataset folder

#Commenting out for end user
#setwd("~/Documents/Personal/MOOCs/Coursera/Data Science/Getting and Cleaning Data/Project/tidyData/")

## Load required libraries
library(dplyr)
library(reshape2)

## Create a new directory to store the tidy dataset if it doesn't already exits
if(!file.exists("TidyDataSet"))
{
    dir.create("TidyDataSet")
}

## Derive columns of interest from datasets and store activity labels

columnIdDF<-read.table(file="./UCI HAR Dataset/features.txt")
activityID<-read.table(file="./UCI HAR Dataset/activity_labels.txt")

# Mutate dataset to add third column to store which indices are of interest. Set default value to NULL.

columnIdDF<-mutate(columnIdDF,boolLoad = 'NULL')

# Obtain the index number of variables that store the mean and the std of measurements. 
indexOfMean <-grep("-mean()" ,columnIdDF[,2],fixed=TRUE)
indexOfStd <-grep("-std()" ,columnIdDF[,2],fixed=TRUE)

# merge the columns into one variable:
columnIndex <- c(indexOfMean,indexOfStd)

#Set the third column for indices of interest to the type double (or the data type)
columnIdDF[columnIndex,3]<-"double" 

## Training Set

# read all the different text files into R from the train folder:

trainingSubjectId <-read.table(file="./UCI HAR Dataset/train/subject_train.txt")
trainingSetData <-read.table(file="./UCI HAR Dataset/train/X_train.txt",colClasses = columnIdDF[,3],col.names = columnIdDF[,2])
trainingSetLabel <-read.table(file="./UCI HAR Dataset/train/y_train.txt")

## Make training dataset with appropriate variable labels

TrainingDataSet <- cbind(trainingSubjectId,trainingSetLabel,trainingSetData)

colnames(TrainingDataSet)[c(1,2)]<-c("SubjectID","ActivityID")

# Test Set

testSubjectId <-read.table(file="./UCI HAR Dataset/test/subject_test.txt")
testSetData <-read.table(file="./UCI HAR Dataset/test/X_test.txt",colClasses = columnIdDF[,3],col.names = columnIdDF[,2])
testSetLabel <-read.table(file="./UCI HAR Dataset/test/y_test.txt")

## Make training dataset with appropriate variable labels

TestDataSet <- cbind(testSubjectId,testSetLabel,testSetData)

colnames(TestDataSet)[c(1,2)]<-c("SubjectID","ActivityID")

## Convert the Activity into a factors variable and replace the number with the activity

TrainingDataSet[,2]<-factor(TrainingDataSet[,2],labels = activityID[,2])
TestDataSet[,2]<-factor(TestDataSet[,2],labels = activityID[,2])

## Merge the TestDataSet and TrainingDataSet to create a complete dataset

MergedData=rbind(TestDataSet,TrainingDataSet)

## Store the mean of each variable grouped by each subject and each activity from the total data set
AveragedDataSet<-MergedData %>% group_by(SubjectID,ActivityID) %>% summarise_each(funs(mean))

# Rearrange the dataset with respect to the SubjectID
AveragedDataSet<-arrange(AveragedDataSet,SubjectID)

## Write this to a text file in the TidyDataSet folder

write.table(AveragedDataSet,file="./TidyDataSet/tidyAveragedDataSet.txt",row.names = FALSE) 
write.table(colnames(AveragedDataSet),file="./TidyDataSet/variableNames.txt",row.names = FALSE,col.names = FALSE) 