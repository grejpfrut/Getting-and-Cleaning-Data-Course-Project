Introduction

This is my submission for Peer Graded Assignment: Getting and Cleaning Data Course Project.

Data Source

Data for this project was taken from the Coursera assignment instructions. Data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

Data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]

Analysis File Description

 Dplyr, datasets and tidyr packages were required to run this script.
 
 When you run the script, it will read test, y_test and test_X data, as well as train, y_train and train_X data and merge them into one big data set called table.  Each variables were names accordingly based on the features listed in the features.txt file.

The script extracts all columns, which names contains "mean" and "std" so we can have all data which tells us about avarage results and standard diviations. 

All activities has names given in the 'activity_labels.txt' file. Column names are taken from the 'features.txt' one. 

Using the combined data set, independent tidy data set with the average of each variable for each activity and each subject was created and calles as 'final'. 
