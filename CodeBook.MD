#Code Book

The run_Analysis script takes "dir" as an input parameter which is the path to the Analysis source files e.g. run_Analysis("/home/UCI HAR Dataset" is an example

The Analysis is performed in the code using the following steps.

1. Loads all the features in the feature_list variable
2. Loads all the activity labels in the activity_label variable and assigns column names

3. Loads training subjects into train_subjects variable and assigns column names
4. Loads training observation data file in train_data and assigns columns names using the feature_list variable
5. Loads training activity data file and assigns column names to it
6. Merges train_activity,train_train_subject, train_data through cbind

7. It applies step 4-7 for Test data in the same order using variables test_subjects, test_activity, test_data

8. At this point we have two datasets merged_train_data and merged_test_data
9. Both are merged again through rbind so that training and testing data is combined

10. This gives us a completed merged data set, out of which we filter colums that only contain Mean and Standard Deviation values
11. Column names are given friendlier names by search replace through the grepl function
12. Data is then grouped by Activity and Subject and aggregated by applying the mean function
13. The final_data is then written to a file called TidyData.txt


 
   



