run_analysis.R is a script that loads raw data from the UCI HAR Dataset

This Dataset should be stored in the home directory

The script reads the data into R and creates a dataframe, all_data.R from both the test and train data in the UCI HAR Dataset

The script then parses the data for only the standard deviation and mean data as applicable to each activity and subject. 

Finally the script groups the data by subject and activity and calculates the mean of each feature variable, and writes the values to a text file. 