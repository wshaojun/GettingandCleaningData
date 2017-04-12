#This codebook describes each step of the script. The print messages in the run_Analysis.R file used for debugging have been omitted here

1. Load dplyr package
```r
library(dplyr)
```

2. Create a folder "data" in the root folder

```r
setwd("~/../")
if(!file.exists("./data")){dir.create("./data")}
```

3. Downloads and unzips the contents of the zip file into the "/data" folder
```r
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(zipfile=temp,exdir="./data")
unlink(temp)
```

4. Reads the features file (this is for the column names for the X_training and X_test files) and stores into a dataframe
```r
setwd("~/../data/UCI HAR Dataset/")
features <- read.delim("features.txt", header = FALSE, stringsAsFactors = FALSE, sep = " ")
```

5. Read the 3 training files (X, Y and subject)
```r
setwd("~/../data/UCI HAR Dataset/train/")
x_train_raw <- read.fwf("X_train.txt", widths = rep(16,561),header = FALSE)
subject_train_raw <- read.csv("subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
y_train_raw <- read.csv("y_train.txt", header = FALSE, stringsAsFactors = FALSE)
```

6. Rename the column names for the 3 training files (X, Y and subject)
```r
names(x_train_raw) <- as.vector(features$V2)
names(subject_train_raw) <- c("subject")
names(y_train_raw) <- c("activity")
```

7. Combine the activity file to the X training file
```r
x_train_raw$activity <- y_train_raw$activity
x_train_raw <- x_train_raw[c(562,1:561)]
```

8. Combine the subject file to the X training file
```r
x_train_raw$subject <- subject_train_raw$subject
x_train_raw <- x_train_raw[c(563,1:562)]
```

9. Read the 3 test files (X, Y and subject)
```r
setwd("~/../data/UCI HAR Dataset/test/")
x_test_raw <- read.fwf("X_test.txt", widths = rep(16,561),header = FALSE)
subject_test_raw <- read.csv("subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
y_test_raw <- read.csv("y_test.txt", header = FALSE, stringsAsFactors = FALSE)
```

10. Rename the column names for the 3 test files (X, Y and subject)
```r
names(x_test_raw) <- as.vector(features$V2)
names(subject_test_raw) <- c("subject")
names(y_test_raw) <- c("activity")
```

11. Combine the activity file to the X test file
```r
x_test_raw$activity <- y_test_raw$activity
x_test_raw <- x_test_raw[c(562,1:561)]
```

12. Combine the subject file to the X test file
```r
x_test_raw$subject <- subject_test_raw$subject
x_test_raw <- x_test_raw[c(563,1:562)]
```

13. Merge the X training and X test files (that both have the subject and activity files already combined) using rbind
```r
merged_data <- rbind(x_train_raw,x_test_raw)
```

14. Obtain the indexes of the columns in the merged dataframe that contains "mean" or "std"
```r
indices <- c(grep("mean",colnames(merged_data)),grep("std",colnames(merged_data)))
```

16. Subset the dataframe based on the indices obtained above, + the subject and activity columns
```r
data_with_mean_std <- merged_data[,c(1,2,indices)]
```

17. Read the activity labels file
```r
setwd("~/../data/UCI HAR Dataset/")
activity_names <- read.csv("activity_labels.txt", sep = " ", header = FALSE) # read activity names
```

18. Replace the activity codes with a lookup against the activity labels file, using gsub with regex in a for loop
```r
i=1
data_with_activity_names <- data_with_mean_std
for (i in 1:nrow(activity_names)){
        data_with_activity_names$activity <- gsub(paste0("^", activity_names[i,1], "$"),activity_names[i,2],data_with_activity_names$activity)
        
}
```

19. Create a final dataframe called "tidied_data"
```r
tidied_data <- data_with_activity_names
```

20. Group by activity and subject
```r
by_activity_subject <- group_by(tidied_data,activity,subject)
```

21. Summarize each of the variable using summarise_each function available in dplyr package
```r
summarized_avg <- summarise_each(by_activity_subject,funs(mean))
```

22. Output to txt file for submission
```r
setwd("~/../data/")
write.table(summarized_avg,row.name=FALSE,"Week4ProgrammingAssignmentResults.txt")
```          
