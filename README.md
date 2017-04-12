# GettingandCleaningData
Repository for Coursera course Getting and Cleaning Data
1. Initialize dplyr library as some functions are required
2. Download, open a temp file and unzip zipped file contents into ./data
3. Read the features.txt file into a dataframe for the column names of the X "training" and "test" sets
4. Read the X training file and the Y training file and the subject training file into 3 dataframes
5. Rename column names of the data frames created in step 4
6. Cbind the columns of the Y training file and subject training file with the X training file into one dataframe
7. Repeat steps 4, 5, 6 for the 3 test files (X test, Y test, subject test)
8. Merge the training and test dataframes obtained from steps 6 and 7 into a final tidied dataframe
9. Extract only the columns with "mean" and "std" in the column names
10. Replace the activity codes with activity names using a for loop, with gsub and regex
11. Group the dataframe by subject and activity
12. Apply summarize_each to the grouped dataframe
