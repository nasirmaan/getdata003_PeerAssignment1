
setwd("C:/rwork/coursera-datasci/getting_and_cleaning_data/UCI HAR Dataset/")

features <- read.table("features.txt", header=F, stringsAsFactors=F)
names(features) <- c("Index", "Name")
activity_lables <- read.table("activity_labels.txt", header=F, stringsAsFactors=F)

########################################
# 1. Reading and cleaing test data
########################################
testdata <- read.table("test/X_test.txt", header=F)
testlables <- read.table("test/y_test.txt", header=F)
names(testlables) = c("Activity")
testlables$Activity <- sapply (testlables$Activity, function(x) activity_lables$V2[x])
names(testdata) <- features$Name
testdata <- cbind(testlables, testdata) # Task 3/4: Giving activity meaningful name


########################################
# reading and cleaing training data
########################################
traindata <- read.table("train/X_train.txt", header=F)
trainlables <- read.table("train/y_train.txt", header=F)
names(trainlables) <- c("Activity")
trainlables$Activity <- sapply (trainlables$Activity, function(x) activity_lables$V2[x])
names(traindata) <- features$Name
traindata <- cbind( trainlables, traindata) # Task 3/4: giving activity a meaningful name

########################################
# 1. Merging  test and traing data
########################################
data <- rbind(traindata, testdata)

########################################
# 2. extracting mean and standard deviation 
########################################
mean_std_data <- data[, c("Activity", features[grep("mean|std", features$Name), "Name"])]

##################################################################
# 5. Create new data set consisting of average of each variable
# vis-a-vis each activity and each subject.  
##################################################################
testsbj <- read.table("test/subject_test.txt", header=F)
trainsbj <- read.table("train/subject_train.txt", header=F)
sbj <- rbind (trainsbj, testsbj); names(sbj) = c("Subject")
sbjdata <- cbind(sbj, mean_std_data)
new_dataset <- aggregate(sbjdata[-c(1,2)],by=list(sbjdata$Subject, sbjdata$Activity), mean)
write.csv(new_dataset, "dataset_avg_measurements.csv", row.names=F)
