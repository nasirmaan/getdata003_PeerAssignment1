# How run_analysis.R script works?

The script peforms follow sequence of tasks;


## 1. Reading Features and Activity Labels
From provided files, it reads list of features and (integer based) activity labels.

## 2. Training Data
First it performs reading and cleaning of training data. Second, it adds a column
"Activity" labels which consists of text based (desctiptive) labels.

## 3. Test Data
This step is similar to step 2 but the input is test data.

## 4. Merging data
This step mergs training and test data into one data frame.

## 5. Extracting data
From merged data frame, we extract mean and standard deviation related columns and put them
into a new data frame.

## 6. Averaging
In this step, we create a new data set which consist of averages of measurements of each 
subject and the activity. This step also adds addition column about subject information. The final
data set is written down to a text file and uploaded on assignement page.
