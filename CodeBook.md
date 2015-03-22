# CODE BOOK
Raw Data is from UCI's Machine Learning Repository. 
[Desc](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), [Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

dplyr is required for this script
## Reading the Data
Data was read using an instruction to load files from UCI HAR Dataset, which is assumed to be in the home directory 

## Column Names
Activity data was set with the a numeric and descriptive column. The descriptive column took its values from activitylabel.txt WALKING, WALKING UPSTAIRS,WALKING DOWNSTAIRS, SITTING, STANDING, LAYING
Feature variables data was set by variable names found in features.txt. There were 561 different features, and they can be found in data.frame features

##Combining data sets
test and training data was supplemented with activity and subject data via a column bind. data.frame all_data combines the training and test data sets via a rowbind. 

the tidy_data set extracts only subject and activity data related to mean or standard deviation measures, resulting in 81 variables. An 82nd variable, Activity, is added to provide a descriptive version of id. 

the data is then reordered such that id, and its corresponding Activity are in the first two columns, followed by subject, and lastly the 79 feature variables. 

## renaming variables
feature Variables are renamed with . seperating each branch of the measurement. Reference document used is UCI HAR Dataset Readme and features_info text files. 

Branch | Variable Names
-------|--------
Domain | freq or time
Gravity| body or gravity
Sensor | accelerometer or gyroscope
Triaxial| if triaxial -X, -Y, or -Z is used at the eend of each variable
Other1  | jerk is used if jerk variable derived, mag is used if magnitude is derived
measures | -mean()- for mean -std()- for standard deviation -meanFreq() for mean frequency

## group_by subject and activity
summary_bysanda first groups tidydata by activity and subject, then takes the mean of each variable



