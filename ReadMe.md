
# Readme.MD

#Getting and Cleaning Data Project Assigment Week 3
This is a repo that contains files related to the Analysis required for Getting and Cleaning data that can be used for Analysis later.

#Analysis Input Files
The input files can reside anywhere in your environment as the path is configurable within the script. Unzip the Analysis files that can be downloaded from this link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Input Description
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Analysis Script
1. The run_Analysis.R script in the Repo requires the path to the Analysis source files as a directory input parameter e.g to run the script, type - run_Analysis("<Working Directory>/UCI HAR Dataset")
The "UCI HAR Dataset" here is the resulting directory that we get after unzipping the Zip file mentioned above.

2. The script takes the directory and starts the Analysis

3. It first loads the training data files
4. Merges all the relevant training data together (Activity, Subject, Observation Data)
5. Loads the test data files
6. Merges all the relevant test data (Activity, Subject, Observation Data)
7. Merges Test with Training data
8. Select only the required Columns (Mean and Standard Deviation)
9. Renames the Column names to friendlier names
10. Groups the data by Activity and Subject and takes a mean mean across the whole group
11. Writes data to a file "TidyData.txt" in the working directory