# Initial Checking and loading of libraries

# was used only during testing locally
# Checking if we are in the right working directory
# currdir<-getwd()
# if(currdir != "D:/MyProCert/Workspace/GACDAssigment1")
# {
#   
#   setwd("D:/MyProCert/Workspace/GACDAssigment1")
#   
# }

#load libraries in use for the manipulation and tidying of data

library(data.table)
library(dplyr)

# End of initial checking and loading of libraries

#Beginning Part 1 Merge Data to form single data set

#Capture featurename and activity labels

featureNames<-read.table("UCI HAR Dataset/features.txt")
activityLabels <-read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Read in training and test data for merging
#Both sets will need to read in subject activity and features separately 


#Read in training data set
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#Read in test data set

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)


#Use rbind to combine data from both data sets

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Capturing column names

colnames(features) <- t(featureNames[2])
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

#Merge the data and extract only needed columns with cbind

completeData <- cbind(features,activity,subject)

#End of Part 1

#Beginning Part 2 Extraction of only mean and standard deviation for each measurement

#Extraction of column with mean and standard deviation data

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#Adding activity and subject columns

requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

#Get the extracted data

extractedData <- completeData[,requiredColumns]
dim(extractedData)

#End of Part 2

#Beginning Part 3 Use descriptive activity names

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

extractedData$Activity <- as.factor(extractedData$Activity)

#End of Part 3

#Beginning Part 4 Label data set with descriptive variable name

#Substitute used acronoyms with readable names

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

# End of Part 4

# Beginning Part 5 Create and independent tidy data set with average of each variable
# per activity per subject

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

# copy out tidy data to Tidy.txt

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)


#End of Part 5


