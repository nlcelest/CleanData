# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## Data source

* [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data set

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

## Data structure

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

1. Download the dataset and import the libraries
Dataset downloaded and extract under the folder called UCI HAR Dataset
Import - library(data.table), library(dplyr)

2. Assign data to variables
- feature_names <- features.txt 
- activity_labels <- activity_labels.txt 
- subject_test <- test/subject_test.txt 
- X_test_features <- test/X_test.txt 
- y_test_activity <- test/y_test.txt 
- subject_train <- test/subject_train.txt 
- X_train_features <- test/X_train.txt 
- y_train_activity <- test/y_train.txt 

3. Merges the training and the test sets to create one data set
features (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
activity (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
merged_data (10299 rows, 563 column) is created by merging features, activity and subject using cbind() function

4. Extracts only the measurements on the mean and standard deviation for each measurement
extracted_data (10299 rows, 88 columns) is created by subsetting merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

5. Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the extracted_data replaced with corresponding activity taken from second column of the activities variable

6. Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time
All tBody in column’s name replaced by TimeBody
All -mean() in column’s name replaced by Mean
All -std() in column's name replaced by STD
All -freq() in column's name replaced by Frequency
All angle in column's name replaced by Angle
All gravity in column's name replaced by Gravity

7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data (180 rows, 88 columns) is created by sumarizing extracted_data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export tidy_data into Tidy.txt file.
