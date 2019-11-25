library(data.table)
library(dplyr)

#You should create one R script called run_analysis.R that does the following.


#########################  
#1. Merges the training and the test sets to create one data set.
########################
#Supporting Metadata
feature_names <- read.table("./features.txt", header=FALSE)
activity_labels <- read.table("./activity_labels.txt", header=FALSE)

#Test Data
X_test_features <- read.table("./test/X_test.txt", header=FALSE)
y_test_activity <- read.table("./test/y_test.txt", header=FALSE)
subject_test <- read.table("./test/subject_test.txt", header=FALSE)

#Training Data
X_train_features <- read.table("./train/X_train.txt", header=FALSE)
y_train_activity <- read.table("./train/y_train.txt", header=FALSE)
subject_train <- read.table("./train/subject_train.txt", header=FALSE)

#Combining the Data
features <- rbind(X_train_features, X_test_features)
activity <- rbind(y_train_activity, y_test_activity)
subject <- rbind(subject_train, subject_test)

colnames(features) <- t(feature_names[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
merged_data <- cbind(features,activity,subject)

#########################  
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#########################
columns_mean_std <- grep(".*Mean.*|.*Std.*", names(merged_data), ignore.case=TRUE)
required_columns <- c(columns_mean_std, 562, 563)
dim(merged_data)
extracted_data <- merged_data[,required_columns]

#########################  
#3. Uses descriptive activity names to name the activities in the data set
########################
extracted_data$Activity <- as.character(extracted_data$Activity)
for (i in 1:6)
{
  extracted_data$Activity[extracted_data$Activity == i] <- as.character(activity_labels[i,2])
}
extracted_data$Activity <- as.factor(extracted_data$Activity)

#########################  
#4. Appropriately labels the data set with descriptive variable names.
#########################  
names(extracted_data)

names(extracted_data)<-gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data)<-gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data)<-gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data)<-gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data)<-gsub("^t", "Time", names(extracted_data))
names(extracted_data)<-gsub("^f", "Frequency", names(extracted_data))
names(extracted_data)<-gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data)<-gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-std()", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("angle", "Angle", names(extracted_data))
names(extracted_data)<-gsub("gravity", "Gravity", names(extracted_data))


#########################  
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#########################  
extracted_data$Subject <- as.factor(extracted_data$Subject)
extracted_data <- data.table(extracted_data)

tidy_data <- aggregate(. ~Subject + Activity, extracted_data, mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity),]
write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)