# getting-and-cleaning-data

The script run_analysis contains R sequence of actions that produced tidy dataset from original data on smartphone usage from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The script requires standard R libraries and data.table library. Please make sure data.table library is installed before running the script

The following steps were applied to the original data to receive a tidy dataset
1) Data set was constructed by merging x (observations) and y (labels) portions of test dataset
2) Features names were read from features.txt and used as column names for the x dataset
3) This test dataset was combined with users observations (subjects)
4) Y labels were disambiguated to be textual labels like 'Running', 'Walking' etc, by reading activity_labels.txt file and marging datasets on activity index
5) The same sequence of steps (1-4) was repeated for train dataset
6) The resulting test and train portions were combined together to receive a full dataset
5) Data was then groupped by subject and activity, and by applying mean function to each of the feature
