library(rlang)
library(data.table)

## run_analysis loads data from "UCI HAR Dataset" folder and cleans it into specified form. Namely,
## it merges the train and test datasets, adds columns for subject id and activity, reduces feature
## columns to only those with mean() or std(), and then creates a second, tidy dataset which contains
## the average value for each feature organized by subject and activity.


run_analysis <- function(source_folder) {
  
  ## creating variable strings with path locations for txt files containing the data
  
  test_file <- paste(source_folder, "/test/X_test.txt", sep = "")
  test_subject_file <- paste(source_folder, "/test/subject_test.txt", sep = "")
  test_activities_file <- paste(source_folder, "/test/y_test.txt", sep = "")
  
  train_file <- paste(source_folder, "/train/X_train.txt", sep = "")
  train_subject_file <- paste(source_folder, "/train/subject_train.txt", sep = "")
  train_activities_file <- paste(source_folder, "/train/y_train.txt", sep = "")
  
  feature_file <- paste(source_folder, "/features.txt", sep = "")
  activity_labels <- paste(source_folder, "/activity_labels.txt", sep = "")
  
  ## loading data from txt files into R variables. 
  
  test_data <- fread(test_file, sep = " ", sep2 = "", stringsAsFactors=FALSE)
  train_data <- fread(train_file, sep = " ", sep2 = "", stringsAsFactors=FALSE)
  features <- read.table(feature_file)
  features <- as.character(features[,2])
  test_subjects <- read.table(test_subject_file)
  test_activities <- read.table(test_activities_file)
  train_subjects <- read.table(train_subject_file)
  train_activities <- read.table(train_activities_file)
  
  print("load completed.")
  
  ## datasets are appended with column vectors containing subject id's and activity id's.

  test_data <- cbind(test_activities, test_data)
  test_data <- cbind(test_subjects, test_data)
  train_data <- cbind(train_activities, train_data)
  train_data <- cbind(train_subjects, train_data)
  
  print(nrow(test_data))
  print(ncol(test_data))
  
  print(nrow(train_data))
  print(ncol(train_data))
  
  ## test and train datasets are combined into full dataset.
  
  full_data <- rbind(test_data, train_data)
  
  print("combine completed.")
  
  ## descriptive feature names are applied to the column names of the full dataset
  
  features <- prepend(features, "Activity")
  features <- prepend(features, "Subject")
  colnames(full_data) <- features
  
  ## the indicies of the feature vector which contain the characters "mean()" or "std()", which
  ## represent features that contain mean or standard deviation data, are stored in the variable
  ## short_ind. Subject and activity column indicies are also added to this vector.
  
  patterns <- c("mean\\(\\)", "std\\(\\)")
  short_ind <- c(grep(patterns[1], features), grep(patterns[2], features))
  short_ind <- prepend(short_ind, c(1,2))
  
  ## The full dataset is reduced to only include the relevant feature columns.
  
  short_data <- full_data[short_ind]
  short_feats <- features[short_ind]
  print(length(short_feats))
  ## following loop iterates through short dataset and creates new dataframe containing the average
  ## value of each feature column for each subject and each activity, then applies descriptive
  ## column labels.
  
  print("Beginning loop.")
  
  tidy_data <- data.frame()
  
  for (sub in unique(short_data$Subject)) {
    for (act in 1:6) {
      new_row <- c(sub, act)
      for (j in 3:ncol(short_data)) {
        count = 0
        temp_sum <- 0
        for (i in 1:nrow(short_data)) {
          if (as.numeric(sub) == as.numeric(short_data[i,1]) && as.numeric(act) == as.numeric(short_data[i,2])) {
            temp_sum <- temp_sum + as.numeric(short_data[i,j])
            count = count + 1
          }
        }
        ## print(count)
        temp_mean = (temp_sum/count)
        new_row <- append(new_row, temp_mean)
      }
      tidy_data <- rbind(tidy_data, new_row)
    }
    print(sub)
  }
  
  colnames(tidy_data) <- short_feats
  tidy_data <- within(tidy_data, Activity[Activity == 1] <- "Walking")
  tidy_data <- within(tidy_data, Activity[Activity == 2] <- "Walking Upstairs")
  tidy_data <- within(tidy_data, Activity[Activity == 3] <- "Walking Downstairs")
  tidy_data <- within(tidy_data, Activity[Activity == 4] <- "Sitting")
  tidy_data <- within(tidy_data, Activity[Activity == 5] <- "Standing")
  tidy_data <- within(tidy_data, Activity[Activity == 6] <- "Laying")
  
  write.table(tidy_data, file = "tidy_data.txt", sep = " ", row.names = FALSE)
  return(tidy_data)
  print("Completed.")
}

source <- "C:/.../UCI HAR Dataset"
run_analysis(source)