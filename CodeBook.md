This codebook describes the variables and the data used. The print messages in the run_Analysis.R file used for debugging have been omitted here

## Data
There are 7,352 observations in the train files and 2,947 observations in the test files giving a total of 10,299 observations when the files are merged.


## Variables
The 561 variables used in this assignment are found in the X_train and X_test files
The 561 variable names are found in the features.txt file.
For purposes of the review criteria of the final file "Appropriately labels the data set with descriptive variable names", "descriptive variable names" is interpreted to be the variable names provided in the features.txt file (vis-a-vis something more layman-descriptive and lengthy)


The subject variable used for this assignment can be found in the subject_train and subject_test files


The activity variable used for this assignment can be found in the Y_train and Y_test files
The description for each activity code can be found in the activity_label file


The final file contains only columns which have been deemed to meet this criteria: "Extracts only the measurements on the mean and standard deviation for each measurement." The interpretation is that the column names contain either "mean()" or "std()".
These columns are not considered to meet the "mean" criteria and are thus not extracted:
555 angle(tBodyAccMean,gravity)
556 angle(tBodyAccJerkMean),gravityMean)
557 angle(tBodyGyroMean,gravityMean)
558 angle(tBodyGyroJerkMean,gravityMean)
559 angle(X,gravityMean)
560 angle(Y,gravityMean)
561 angle(Z,gravityMean)
