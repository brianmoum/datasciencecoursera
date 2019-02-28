Data comes from scientific study collected from smartphone accelerometers.
Data link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

There are two primary data sets from file, X_train and X_test, which represent data from 30 different subjects participating in tests.
The data is comprised of each subject performing 6 different activities, while accelerometer data is recorded in X, Y, and Z directions. 
The raw data as well as statistical data calculated from the raw data is stored for each test by subject and activity. The data is 
then split randomly into two sets to be used for ML training. 

R code run_analysis.R loads two primary data sets into R. Then the following alterations are made:

* Files containing subject ID numbers and activity ID numbers are loaded into R, then added as columns next to their corresponding rows 
* File containing descriptive feature labels is loaded into R and applied to both tables
* Both tables are combined into one full data set.
* Full data set is reduced to short data set which contains only features which correspond to mean and standard deviation calculations.
* Short data set is then aggregated by subject and activity, so that each each subject and activity pair occur only once, and the value
listed for each feature represents the average value for that feature. 
