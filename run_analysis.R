
setwd("C:/rwork/coursera-datasci/getting_and_cleaning_data/UCI HAR Dataset/")

#####################################################
# 1. Reading and cleaing features and activity labels
#####################################################
features <- read.table("features.txt", header=F, stringsAsFactors=F)
names(features) <- c("Index", "Name")
activity_lables <- read.table("activity_labels.txt", header=F, stringsAsFactors=F)

########################################
# 2. Reading and cleaing test data
########################################
testdata <- read.table("test/X_test.txt", header=F)
testlables <- read.table("test/y_test.txt", header=F)
names(testlables) = c("Activity")
testlables$Activity <- sapply (testlables$Activity, function(x) activity_lables$V2[x])
names(testdata) <- features$Name
testdata <- cbind(testlables, testdata) # Giving activity meaningful name


########################################
# 3. reading and cleaing training data
########################################
traindata <- read.table("train/X_train.txt", header=F)
trainlables <- read.table("train/y_train.txt", header=F)
names(trainlables) <- c("Activity")
trainlables$Activity <- sapply (trainlables$Activity, function(x) activity_lables$V2[x])
names(traindata) <- features$Name
traindata <- cbind( trainlables, traindata) # giving activity a meaningful name

########################################
# 4. Merging  test and traing data
########################################
data <- rbind(traindata, testdata)

########################################
# 5. extracting mean and standard deviation 
########################################
mean_std_data <- data[, c("Activity", features[grep("^.*(-mean\\(\\)|std\\(\\))$", features$Name, perl=T), "Name"])]
better_names <- gsub("^t|f", "", names(mean_std_data))
better_names <- gsub("-mean\\(\\)", "Mean", better_names)
better_names <- gsub("-std\\(\\)", "Std", better_names)
names(mean_std_data) <- better_names

##################################################################
# 6. Create new data set consisting of average of each variable
# vis-a-vis each activity and each subject.  
##################################################################
testsbj <- read.table("test/subject_test.txt", header=F)
trainsbj <- read.table("train/subject_train.txt", header=F)
sbj <- rbind (trainsbj, testsbj); names(sbj) = c("Subject")
sbjdata <- cbind(sbj, mean_std_data)
new_dataset <- aggregate(sbjdata[-c(1,2)],by=list(sbjdata$Subject, sbjdata$Activity), mean)
names(new_dataset)[1:2] <- c("Subject", "Activity")
write.table(new_dataset, "dataset_avg_measurements.txt", row.names=F)
