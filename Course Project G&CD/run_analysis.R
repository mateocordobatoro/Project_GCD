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

# Merge data 
y       <- rbind(y_train, y_test)
x       <- rbind(X_train, X_test)
subject <- rbind(subject_train, subject_test)

# Insert X colname 
colnames(x)  <- features

# Extract only sd and mean data
extract_features  <- grepl("mean|std",features)
x                 <- x[,extract_features]

# Merge all data 
data              <- cbind(subject,y,x)

# Colname for subject and activity
colnames(data)[1] <- c("subject_id")
colnames(data)[2] <- c("activity_id")

# Replace the activity labels levels in acitivity_id
data$activity_id<-factor(data$activity_id, levels = c(1:6), labels=activity_labels)
# re sort Data
id_labels   <- c("subject_id", "activity_id")
melt_data   <- melt(data, id = id_labels)
# Tidy Data
tidy_Data <- dcast(melt_data, subject_id + activity_id ~ variable, mean)
write.table(final_data,file="tidy_Data.txt",row.names = FALSE)




