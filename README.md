Data source
===========

* Original data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* Data source used for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1. Merges the training and the test sets to create one data set
--------------------------------------------------------------
* subject_test: loads the data from /test/subject_test.txt file
* X_test: loads the data from /test/X_test.txt file
* y_test: loads the data from /test/y_test.txt file

* subject_train: loads the data from /train/subject_train.txt file
* X_train: loads the data from /train/X_train.txt file
* y_train: loads the data from /train/y_train.txt file

* subject_full: subject_test and subject_train concatenated
* X_full: X_test and X_train concatenated
* y_full: y_test and y_train concatenated - this stores the type of activity as a single digit

2. Extracts only the measurements on the mean and standard deviation for each measurement
-----------------------------------------------------------------------------------------

* features: loads the data from features.txt - these are the descriptions of the columns of X_full
* X_std_mean: subset of X_full, I kept only the columns where the description text contained "-std()" or "-mean()"

3. Uses descriptive activity names to name the activities in the data set
-------------------------------------------------------------------------actitity_labels.txt file
* activity_labels: loads the data from activities.txt - these are the descriptions for the values stored in y_full, I use this to replace the numeric value of the activity by their text description as explained above
* y_mapped: y_full data but with the values replaced with the matching descriptions found in the 

4. Appropriately labels the data set with descriptive variable names
--------------------------------------------------------------------
* no new variables declared

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
-------------------------------------------------------------------------------------------------------------------------------------------------------
* merged: subject_full, y_mapped and X_std_mean concatenated
* merged_mutate: copy of "merged" but with one new column called "subjects_activities" which is the concatenation of the values of the subjects and activities columns in "merged"
* merge_melt: all the measurements columns melt by the "subjects_activities" column, the original "subject" and "activities" columns in "merged" are discarded
* merge_summary: calculates the mean (average) for each unique value found in the "subjects_activities" column
* merged_final: splits the "subjects_activities" column back into 2 distinct columns, i.e. a "subjects" and an "activities" columns