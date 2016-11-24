##Run Analysis:
##Load the required packages:
library(dplyr)

labels <- read.table("./data/activity_labels.txt")
features <- read.table("./data/features.txt")

##Load training data set:
training_values <- read.table("./data/train/X_train.txt")
training_labels <- read.table("./data/train/y_train.txt")
training_subject <- read.table("./data/train/subject_train.txt")

##Assign columns names:
names(training_values) <- features[, 2]
names(training_labels) <- "ActivityLabel"
names(training_subject) <- "SubjectId"

##Merge the training data:
training_complete <- cbind(training_subject, training_labels, training_values)

##Select only mean and std. values:
only_select <- (grepl("SubjectId", names(training_complete)) | grepl("ActivityLabel", names(training_complete)) 
                | grepl("mean..", names(training_complete)) | grepl("std..", names(training_complete)))
training_complete <- training_complete[, only_select==TRUE]

##Load test data set:
test_values <- read.table("./data/test/X_test.txt")
test_labels <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")

##Assign columns names:
names(test_values) <- features[, 2]
names(test_labels) <- "ActivityLabel"
names(test_subject) <- "SubjectId"

##Merge the test data:
test_complete <- cbind(test_subject, test_labels, test_values)

##Select only mean and std. values:
only_select <- (grepl("SubjectId", names(test_complete)) | grepl("ActivityLabel", names(test_complete)) 
                | grepl("mean..", names(test_complete)) | grepl("std..", names(test_complete)))
test_complete <- test_complete[, only_select==TRUE]

##Merge the test and training data sets and sort it by subjects and activities:
merged_data <- rbind(test_complete, training_complete)
merged_data <- arrange(merged_data, SubjectId, ActivityLabel)

##Creation of the tidy data set:
tidyDataSet <- matrix(data=NA, nrow=180, ncol=81)
n <- 1
for(i in unique(merged_data$SubjectId)){
  for(j in unique(merged_data$ActivityLabel)){
    tidyDataSet[n, ] <- merged_data %>% filter(SubjectId == i, ActivityLabel ==j) %>% colMeans()
    n <- n+1
  }
}
tidyDataSet <- as.data.frame(tidyDataSet)
names(tidyDataSet) <- names(merged_data)

##Change the names of the activity labels:
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 1] <- as.character(labels$V2[labels$V1==1])
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 2] <- as.character(labels$V2[labels$V1==2])
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 3] <- as.character(labels$V2[labels$V1==3])
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 4] <- as.character(labels$V2[labels$V1==4])
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 5] <- as.character(labels$V2[labels$V1==5])
tidyDataSet$ActivityLabelName[tidyDataSet$ActivityLabel == 6] <- as.character(labels$V2[labels$V1==6])

##Substitute the old activity labels by the new, more descriptive variable:
tidyDataSet$ActivityLabel <- tidyDataSet$ActivityLabelName
tidyDataSet$ActivityLabelName <- NULL

##Write the tidy data set into a txt file:
write.table(tidyDataSet, "./tidy_data_set.txt", row.name = FALSE)

