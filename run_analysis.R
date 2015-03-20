library(plyr)
#create one R script called run_analysis.R that does the following. 
#      1)Merges the training and the test sets to create one data set.
#      2)Extracts only the measurements on the mean and standard deviation for each measurement. 
#      3)Uses descriptive activity names to name the activities in the data set
#      4)Appropriately labels the data set with descriptive variable names. 
#      5) From the data set in step 4, creates a second, 
#      independent tidy data set with the average of each variable for each activity and each subject.



#Step 1: Merge the training and test sets to create one data set
##################################################################

#Load required Data & features 

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = F, header = F )
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = F, header = F )
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = F, header = F)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = F, header = F )
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = F, header = F )
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = F, header = F)


column_features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F, header = F ) #column names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F, header = F) #activity labels

x_data <- rbind (x_train,x_test)#create 'x' data set
y_data <- rbind (y_train, y_test)#create 'y' data set
subject <- rbind (train_subject, test_subject)#create 'subject' data set
rm(x_train);rm(y_train);rm(x_test); rm(y_test);rm(train_subject);rm(test_subject)#Remove data frame no longer required

#Step 2: Extract Measurements with only mean and standard deviation 
####################################################################

# get a vector all the columns numbers with only mean or std from the features table.
cols_with_mean_or_std <- grep("-(mean|std)\\(\\)", column_features[, 2])

# subset the x data to only the columns with mean and std
x_data <- x_data[,cols_with_mean_or_std]

#corrrect the column names (i.e only columns with mean and std in thier names)
colnames (x_data) <- column_features[cols_with_mean_or_std, 2]

#Step 3: USe descriptive activity names to name the activities in the data set.
###########################################################################
y_data[, 1] <- activity_labels[y_data[, 1], 2]
colnames(y_data) <- "activity"

#Step 4: Appropriately label the data set with descriptive variable names
############################################################################
colnames(subject) <- "subject" #correct column name

#Bind all the data into a single data set: #Frst tidy data set
all_data <- cbind (x_data, y_data, subject)

#Step 5: Create a second, independent tidy data set with the average of each variable
##########################################################################


#calculate average of means and std deviation(makes no sense)- excludes the activity and subject columns. 
tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66])) 

#write output to file
write.table(tidy_data, "tidy_data.txt", row.name=FALSE) 


#check <- read.table("tidy_data.txt", stringsAsFactors = F, header = T)