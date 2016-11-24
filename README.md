# Getting-and-Cleaning-Data-Course-Project
Peer-graded Assignment for the Getting and Cleaning Data Course

The script "run_analysis.R" convert the data collected from the accelerometers from the Samsung Galaxy S smartphone into tidy data set.

It first loads all the data from the "data" directory. The data is divided into test and training subjects. For each one of them, the data is stored in the following files:

  TEST DATA SET:
  - './test/subject_test.txt' -->  The subject id.
  - './test/y_test.txt'       -->  The activity label.
  - './test/X_test.txt'       -->  The measurements of each record of the data.
  - 'features.txt'            -->  The labels of the measurements found in 'X_test.txt'.
  - 'activity_labels.txt'     -->  Labels of the activities whose codes are in './test/y_test.txt'.
  
  TRAIN DATA SET:
  - './train/subject_train.txt' -->  The subject id.
  - './train/y_train.txt'       -->  The activity label.
  - './train/X_train.txt'       -->  The measurements of each record of the data.
  - 'features.txt'              -->  The labels of the measurements found in 'X_train.txt'.
  - 'activity_labels.txt'       -->  Labels of the activities whose codes are in './train/y_train.txt'.
  
Once all data is loaded, it generates the complete test and training data sets by merging the tables previously loaded.

Afterwards, the complete data set is formed by merging the complete test and train data sets.

From all values stored in 'X_test.txt' and 'X_train.txt' the script selects only those variables that corresponds to the mean and standard deviation of the measurements.

Finally, the mean values of the measurement for each subject and for each activity are calculated.

The resulted data set is stored in the variable 'tidyDataSet'.
