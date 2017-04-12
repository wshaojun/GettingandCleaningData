#initialize dplyr
library(dplyr)

#download, open a temp file and unzip zipped file contents into ./data
setwd("~/../")
if(!file.exists("./data")){dir.create("./data")}
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(zipfile=temp,exdir="./data")
unlink(temp)

#get features (row names/ for the 561 column x_training and x_test data)
print("reading features (activity labels) file")
setwd("~/../data/UCI HAR Dataset/")
features <- read.delim("features.txt", header = FALSE, stringsAsFactors = FALSE, sep = " ")

############################Process training files################################
#read the training files
print("reading training files")
setwd("~/../data/UCI HAR Dataset/train/")
x_train_raw <- read.fwf("X_train.txt", widths = rep(16,561),header = FALSE)
subject_train_raw <- read.csv("subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
y_train_raw <- read.csv("y_train.txt", header = FALSE, stringsAsFactors = FALSE)

#####4. Appropriately labels the data set with descriptive variable names. 
#rename training column names
print("renaming training column names")
names(x_train_raw) <- as.vector(features$V2)
names(subject_train_raw) <- c("subject")
names(y_train_raw) <- c("activity")

#Add subject and activity column to training file
print("adding subject and activity columns to training file")
x_train_raw$activity <- y_train_raw$activity
x_train_raw <- x_train_raw[c(562,1:561)]

x_train_raw$subject <- subject_train_raw$subject
x_train_raw <- x_train_raw[c(563,1:562)]


############################Process test files################################
#read the test files
print("reading test files")
setwd("~/../data/UCI HAR Dataset/test/")
x_test_raw <- read.fwf("X_test.txt", widths = rep(16,561),header = FALSE)
subject_test_raw <- read.csv("subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
y_test_raw <- read.csv("y_test.txt", header = FALSE, stringsAsFactors = FALSE)

#####4. Appropriately labels the data set with descriptive variable names. 
print("renaming test column names")
names(x_test_raw) <- as.vector(features$V2)
names(subject_test_raw) <- c("subject")
names(y_test_raw) <- c("activity")


#Add subject and activity column to x_test_raw
print("adding subject and activity columns to test file")
x_test_raw$activity <- y_test_raw$activity
x_test_raw <- x_test_raw[c(562,1:561)]

x_test_raw$subject <- subject_test_raw$subject
x_test_raw <- x_test_raw[c(563,1:562)]


##################1. Merges the training and the test sets to create one data set.##############################
##merge x train and x test
print("merging data")
merged_data <- rbind(x_train_raw,x_test_raw)

##################2. Extracts only the measurements on the mean and standard deviation for each measurement#####
print("extracting measurements with mean and std")
indices <- c(grep("mean",colnames(merged_data)),grep("std",colnames(merged_data)))
data_with_mean_std <- merged_data[,c(1,2,indices)]

##################3.Uses descriptive activity names to name the activities in the data set######################
print("updating activity IDs to activity names")
setwd("~/../data/UCI HAR Dataset/")
activity_names <- read.csv("activity_labels.txt", sep = " ", header = FALSE) # read activity names
i=1
data_with_activity_names <- data_with_mean_std
for (i in 1:nrow(activity_names)){
        data_with_activity_names$activity <- gsub(paste0("^", activity_names[i,1], "$"),activity_names[i,2],data_with_activity_names$activity)
        
}


tidied_data <- data_with_activity_names

######5. Average of each variable for each activity and each subject
print("Averaging each variable")
by_activity_subject <- group_by(tidied_data,activity,subject)
summarized_avg <- summarise_each(by_activity_subject,funs(mean))

#write to file
setwd("~/../data/")
write.table(summarized_avg,row.name=FALSE,"Week4ProgrammingAssignmentResults.txt")
              
