#Code book

Please Note: This is intended to be used as an addition to the codebook that came with the raw dataset. It transformation process and the variables created after each transformation.

###Variable Names & Transformations 

##### 1) Read raw datasets using the read.table() function

"x_train"- training data from raw data set
"y_train"- training data from raw data set
"x_test" - testing data from raw data set
"y_test" - testing raw data from raw data set
"train_subject" - subject data for traiing from raw data set
"test_subject" - subject data for testing from raw data set
"column_features" - column names from raw data set
"activity_labels" - activity descriptions from raw data set

##### 2) Combine train and test data using rbind() function to create 3 new variables
"x_data" - combined x data
"y_data" - combined y data
"subject" - combined subject data

##### 3) Get all the columns with mean or standard deviation using grep() function
"cols_with_mean_or_std" - vector of integers correspoonding to the columns containing mean or std in the "column_features""

##### 4) subset the x_data to only the columns with mean and std deviation
"x_data" - subset of original now containing only required columns

##### 5) Insert the corresponding column names of only required columns to "x_data" using colnames() function
"x_data"- table with appropriate column names

##### 6) Modify "y_data"" with appropriate activity descriptions and change the column name 

##### 7) Combine "x_data"", "y_data"" and "subject"" using cbind() function

"all_data" - data frame containing complete tidy data set

##### 8) extract the average of the mean and standard deviation using colMeans() from plyr package
"tidy_data" - tidy data set

##### 9) Print output to file

"tidy_data.txt"- output file located in the working directory


