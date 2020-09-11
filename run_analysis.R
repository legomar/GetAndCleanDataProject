  library(dbplyr)
# Download and extract data
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile="data.zip")
  unzip("data.zip") 

  #Read data into R
  features <- read.table("features.txt", col.names = c("num","functions"))
  activities <- read.table("activity_labels.txt", col.names = c("reference", "activity"))
  subject_test <- read.table("subject_test.txt", col.names = "subjectTest")
  subject_train <- read.table("subject_train.txt", col.names = "subjectTrain")
  x_test <- read.table("X_test.txt", col.names = features$functions)
  y_test <- read.table("y_test.txt", col.names = "reference")
  x_train <- read.table("X_train.txt", col.names = features$functions)
  y_train <- read.table("y_train.txt", col.names = "reference")
  
  #Step 1: Merges the training and the test sets to create one data set.
  
  Xdata <- rbind(x_train, x_test)
  Ydata <- rbind(y_train, y_test)
  Subjectsdata <- rbind(subject_train, subject_test)
  Data <- cbind(Subjectsdata,Xdata,Ydata)
  
  #Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
  
  Data <- Data %>% select(subject, code, contains("mean"), contains("std"))
  
  #Step 3: Uses descriptive activity names to name the activities in the data set.
  
  Data$code <- activities[Data$code, 2]
  
  #Step 4: Appropriately labels the data set with descriptive variable names.
  
  names(Data)[2] = "activity"
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("^t", "Time", names(Data))
  names(Data)<-gsub("^f", "Frequency", names(Data))
  names(Data)<-gsub("tBody", "TimeBody", names(Data))
  names(Data)<-gsub("-mean()", "Mean", names(Data))
  names(Data)<-gsub("-std()", "STD", names(Data))
  names(Data)<-gsub("-freq()", "Frequency", names(Data))
  names(Data)<-gsub("angle", "Angle", names(Data))
  names(Data)<-gsub("gravity", "Gravity", names(Data))
  
  #Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  Data <- TidyData %>%    group_by(subject, activity) %>%    summarise_all(funs(mean))  
  write.table(Data, "Data.txt", row.name=FALSE)
  
  