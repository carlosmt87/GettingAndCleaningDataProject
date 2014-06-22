runAnalysis <- function()
{
  
  ################################################################
  #Merges the training and the test sets to create one data set.
  
  #X Data
  temporal1 <- read.table( "train/X_train.txt")
  temporal2 <- read.table("test/X_test.txt")
  xdata <- rbind(temporal1, temporal2)
  
  #Y Data
  temporal1 <- read.table("train/y_train.txt")
  temporal2 <- read.table("test/y_test.txt")
  ydata <- rbind(temporal1, temporal2)
  
  #subject data
  temporal1 <- read.table("train/subject_train.txt")
  temporal2 <- read.table("test/subject_test.txt")
  subject <- rbind(temporal1, temporal2)
  
  #Set column name
  names(subject) <- "subject"
  
  ################################################################
  #Determine mean and std desv columns
  feat <- read.table("features.txt")
  #get the indexes
  idx <- grep("-mean\\(\\)|-std\\(\\)", feat[, 2])
  #filter the xdata columns
  xdata <- xdata[, idx]
  #Set the names
  names(xdata) <- feat[idx, 2]
  #Transformation: Delete "(" ")" and "-" from the column names
  names(xdata) <- gsub("\\(|\\)|\\-", "", names(xdata))
  
  ################################################################
  #Set descriptive activity names for the activities in the data set
  act <- read.table("activity_labels.txt")
  act[, 2] = gsub("_", "", tolower(as.character(act[, 2])))
  #Replace Actitivity numbers with names
  ydata[,1] = act[ydata[,1], 2]
  names(ydata) <- "activity"
  

  #Build the clean data set
  cleanData <- cbind(subject, ydata, xdata)
  write.table(cleanData, "tidyDataSet.txt")
  
  
  #Create a new data set with the average for each variable for each activity for each 
  #one of the 30 subjects of the experiment
  row = 1
  totalSubjects = 30
  totalActivities = 6
  avg = cleanData[1:(totalSubjects*totalActivities), ]
  
    
  for(s in 1:totalSubjects){
    for(a in 1:totalActivities){
      #Add subject column
      avg[row,1] = s
      #add activity
      avg[row,2] = act[a, 2]
      data <- cleanData[cleanData$subject==s & cleanData$activity==act[a, 2], ]
      #Get the average for each column, except the first and the second which
      #we have already added
      avg[row,c(-1,-2)] = colMeans(data[,c(-1,-2)])
      row = row + 1
    }
  }
  
  write.table(avg, "AveragesDataSet.txt")

}