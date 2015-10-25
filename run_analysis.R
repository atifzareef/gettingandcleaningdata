

run_Analysis <- function(dir ){
  
  
  # Loading features data
  feature_file <- paste(dir,"/features.txt",sep="")
  print(paste("Loading feature list......",feature_file))
  feature_list <- read.table(feature_file,header=FALSE)
  
  
  # Loading activity labels
  activity_list_file <- paste(dir,"/activity_labels.txt",sep="")
  print(paste("Loading Activity Lables list......",activity_list_file))
  activity_labels <- read.table(activity_list_file, header=FALSE)
  
  colnames(activity_labels) <- c("Activity_Id","Activity_Desc") 
  
  ## Load Train data files ----------------------------------------
  train_subjects_file <- paste(dir,"/train/subject_train.txt",sep="")
  print(paste("Loading Training data subjects......",train_subjects_file))
  train_subjects <- read.table(train_subjects_file,header=FALSE)
  
  colnames(train_subjects) <- c("Subject_Id")
  
  train_data_file <- paste(dir,"/train/X_train.txt",sep="")
  print(paste("Loading Training data......",train_data_file))
  train_data <- read.table(train_data_file,header=FALSE)
  
  colnames(train_data) <- feature_list[,2]
  
  activity_data_file <- paste(dir,"/train/y_train.txt",sep="")
  print(paste("Loading Activity data......",activity_data_file))
  train_activity_data <- read.table(activity_data_file,header=FALSE)
  
  colnames(train_activity_data) <- c("Activity_Id")
  ## --------------------------------------------------------------
  
  
  print("Merge Training,Subjects and Activity data");
  merged_train_data <- cbind(train_activity_data,train_subjects,train_data)
  
  print("------")
  ## Load Test Data -------------------------------------------
  test_subjects_file <- paste(dir,"/test/subject_test.txt",sep="")
  print(paste("Loading Test data subjects......",test_subjects_file))
  test_subjects <- read.table(test_subjects_file,header=FALSE)
  
  colnames(test_subjects) <- c("Subject_Id")
  
  test_data_file <- paste(dir,"/test/X_test.txt",sep="")
  print(paste("Loading Test data......",test_data_file))
  test_data <- read.table(test_data_file,header=FALSE)
  
  colnames(test_data) <- feature_list[,2]
  
  test_activity_data_file <- paste(dir,"/test/y_test.txt",sep="")
  print(paste("Loading Test Activity data......",test_activity_data_file))
  test_activity_data <- read.table(test_activity_data_file,header=FALSE)
  
  colnames(test_activity_data) <- c("Activity_Id")
  ## --------------------------------------------------------------

  
  print("Merge Test,Subjects and Activity data");
  merged_test_data <- cbind(test_activity_data,test_subjects,test_data)

  
  print("Merge Test with training data ")
  merged_data <- rbind(merged_train_data,merged_test_data)
  
  merged_data <- merge(activity_labels,merged_data,by="Activity_Id")
  
  
  print("------------------------------------------------------------- ")
  
  print("Selecting only Mean, Standard Deviation values")
  select_col_names <- colnames(merged_data)
  
  # Forming a Vector that contains TRUE values for the Id, Mean & Standard Deviation columns
  select_col_list = (grepl("Activity..",select_col_names) | 
                       grepl("Subject..",select_col_names) | 
                       grepl("-mean()",select_col_names) | 
                       grepl("-meanFreq()",select_col_names) |
                       grepl("-std()..-",select_col_names))
  
  # select colums against which the index is set to TRUE
  merged_data <- merged_data[select_col_list==TRUE]
 
  print("Tidying up Col names") 
  col_names <- colnames(merged_data)
  
  
  #Subtituting colum name desc by friendly desc
  for (i in 1:length(col_names)) 
  {
    col_names[i] = sub("std\\()","StdDev",col_names[i])
    col_names[i] = sub("mean\\()","Mean",col_names[i])
    col_names[i] = sub("meanFreq\\()","MeanFreq",col_names[i])
  }

  colnames(merged_data) <- col_names
  
  print("Grouping data by Activity and Subject ")
  #Aggregating by Activity and Subject and taking mean of all those
  tidy_final_data <- aggregate(merged_data[,names(merged_data) != c("Activity_Id","Activity_Desc","Subject_Id")],
                           by=list(merged_data$Activity_Id,merged_data$Activity_Desc,merged_data$Subject_Id),
                           mean)
  print("Merge and Clean up successful ")
  
  colnames(tidy_final_data)[1:3] <- c("Activity_Id","Activity_Desc","Subject_Id")
  
  print("Writing data to file") 
  write.table(tidy_final_data, 'tidyData.txt',row.names=FALSE,sep='\t');
  tidy_final_data
  
  
}