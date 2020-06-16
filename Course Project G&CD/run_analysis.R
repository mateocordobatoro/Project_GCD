# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.

library(data.table)

# Load Data

activity_labels <- read.table("activity_labels.txt")
activity_labels <- activity_labels[,2]

features        <- read.table("features.txt")
features        <- features[,2]

X_test          <- read.table("X_test.txt")
y_test          <- read.table("y_test.txt")
subject_test    <- read.table("subject_test.txt")
X_train         <- read.table("X_train.txt")
y_train         <- read.table("y_train.txt")
subject_train   <- read.table("subject_train.txt")

# colnames features in X_test & X_train
colnames(X_test)  <- features
colnames(X_train) <- features
# Extract only sd and mean observations
extract_features  <- grepl("mean|std",features)

X_test  <- X_test[,extract_features]
X_train <- X_train[,extract_features]

# Activity labels
y_test[,2]             <- activity_labels[y_test[,1]]
colnames(y_test)       <- c("Activity_ID", "Activity_Label")
colnames(subject_test) <- "subject"

# Activity data
y_train[,2]          <- activity_labels[y_train[,1]]
names(y_train)       <- c("Activity_ID", "Activity_Label")
names(subject_train) <- "subject"

# merge data by col 
test_data  <- cbind(as.data.table(subject_test), y_test, X_test)
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# merge test & train by rows
data <- rbind(test_data, train_data)

# re sort Data
id_labels   <- c("subject", "Activity_ID", "Activity_Label")
data_labels <- setdiff(colnames(data), id_labels)
melt_data   <- melt(data, id = id_labels, measure.vars = data_labels)

# final data

final_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)



