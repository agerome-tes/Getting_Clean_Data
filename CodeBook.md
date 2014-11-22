Getting Clean Data
==================

Data source
-----------

* Original data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* Data source used for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

1. Merges the training and the test sets to create one data set
---------------------------------------------------------------
* get the test data for subjects, activities and measurements into a variable each
* do the same for the training data and 3 new variables
* 6 variables, group them into 3 pairs and concatenate them with rbind
** subjects test-train pair (subject files)
** activities test-train pair (X files)
** measurements test-train pair (y files)
* Inertial data was not used and was not required for this project

2. Extracts only the measurements on the mean and standard deviation for each measurement
-----------------------------------------------------------------------------------------
* features.txt file contains the descriptions for the full X data set, i.e measurements
* use grep to find the columns that contain either
** "-std()" or
** "-mean()"
** keep only these columns and discard the rest

3. Uses descriptive activity names to name the activities in the data set
-------------------------------------------------------------------------
* activity_labels.txt file provides friendly descriptions for each value found in the y_full data set
* Replaced the raw value in the y_full dataset with the matching description
* Renamed the single column of the y_full dataset as "activities"

4. Appropriately labels the data set with descriptive variable names
--------------------------------------------------------------------
* Renamed the single column of the subject_full dataset as "subjects"

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
-------------------------------------------------------------------------------------------------------------------------------------------------------
* Renamed the columns as per the descriptions found in the features.txt file
* Merged the 3 data sets into a single data set
** subject_full
** y_mapped
** X_std_mean
* Added a new column called "subjects_activities" which is the concatenation of the "subjects" and "activities" columns so we can melt and the dcast the data set based on that new variable. Used the | (pipe character) as a separator
* melt and dcast calculate the average values for each variable, each subject and each activity
* split the "subjects_activity" column into 2 columns and merged these 2 columns with the measurement variable columns into the final dataset. The 2 new columns were:
** subjects
** activities
