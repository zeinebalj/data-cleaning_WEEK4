
# Question 1
# Merge the training and test sets to create one data set
###############################################################################

X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

#create data set
X_data <- rbind(X_train, X_test)
Y_data <- rbind(Y_train, Y_test)
subject_data <- rbind(subject_train, subject_test)

# Question 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

Features_data <- read.table("features.txt")
MEANSTD_FEATURES <- grep("-(mean|std)\\(\\)", Features_data[, 2])

# subset the desired columns
DATA_MEANSTD_FEATURES <- X_data[,MEANSTD_FEATURES]
names(DATA_MEANSTD_FEATURES) <- Features_data[MEANSTD_FEATURES, 2]

#Question 3 
# Use descriptive activity names to name the activities in the data set
###############################################################################

ACTIVITY <- read.table("activity_labels.txt")
# update values with correct activity names
Y_data[, 1] <- ACTIVITY[Y_data[, 1], 2]
# correct column name
names(Y_data) <- "Activity"

# Question 4  
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) <- "Subject"

# Cbind all the data in a single data set
Data_All <- cbind(DATA_MEANSTD_FEATURES, Y_data, subject_data)

# Question 5 
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
library(plyr)
tidy_data <- ddply(Data_All, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
