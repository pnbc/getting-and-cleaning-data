prepare_dataset=function(x_file,y_file,subject_file){
  #load feature names
  features=read.table("features.txt")
  colnames(features) =c("index","feature_name")
  
  activity=read.table("activity_labels.txt")
  colnames(activity)=c("index","label")
  
  # first load test data set
  # We need to merge x observations and y labels
  x = read.table(x_file)
  # assign features as column names to x
  colnames(x) = features$feature_name
  #load lables
  y = read.table(y_file)
  colnames(y)=c("index")
  #append the actual label for lable index
  y=merge(y,activity, by.x="index", by.y="index")
  
  #merge x and y
  data=cbind(x,y$label)
  
  # append subjects 
  subj=read.table(subject_file)
  colnames(subj)=c("subject")
  data=cbind(data,subj)
  # assign non-cryptic names
  colnames(data)[ncol(data)-1]="activity"
  colnames(data)[ncol(data)]="subject"

  data
}



# 1. Merges the training and the test sets to create one data set.
data_test = prepare_dataset("test/X_test.txt","test/y_test.txt","test/subject_test.txt")
data_train = prepare_dataset("train/X_train.txt","train/y_train.txt","train/subject_train.txt")

data=rbind(data_test,data_train)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# what columns have mean features (and not meanFreq)
mean_columns=grep("mean\\(\\)",colnames(data))
std_columns=grep("std",colnames(data))

# the last two are the subject and activity
columns_to_keep=c(mean_columns,std_columns,ncol(data)-1,ncol(data))
data=data[,columns_to_keep]

# 3. Uses descriptive activity names to name the activities in the data set
# - was done already in our function prepare_dataset that returns value of activity in activity column

# 4. Appropriately labels the data set with descriptive variable names. 
#- we have done it by labelling activity and subject columns

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each
# activity and each subject.

# We need to group by subject and activity
library(data.table)
data_table=data.table(data)

groupped=data_table[,lapply(.SD,mean),by=list(subject,activity)]

write.table(groupped,file="tidy-dataset.txt", row.name=FALSE)

