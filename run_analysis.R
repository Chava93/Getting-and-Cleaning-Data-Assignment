## Getting and cleaning Ddata
## Programming assignment

## setting dirrectory
setwd("C:/Users/adrian/Documents/R works/clean data/project")
## Reading all files  that´ll be used 
labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")


x_test <- read.table("./test/X_test.txt", sep = "")
y_test <- read.table("./test/y_test.txt", sep = "")
subject_test <- read.table("./test/subject_test.txt", sep = "")


x_train <- read.table("./train/X_train.txt", sep = "")
y_train <- read.table("./train/y_train.txt", sep = "")
subject_train <- read.table("./train/subject_train.txt", sep = "")
## joining train and test data properly
totalSubject <- rbind(subject_train,subject_test)
total_x <- rbind(x_train,x_test)
total_y <- rbind(y_train, y_test)

names(totalSubject) <- c("subject")
names(total_y) <- c("activity")
names(total_x)<- features[,2]

## Creating one big table

two_bind <- cbind(totalSubject,total_y)
total_bind <- cbind(two_bind,total_x)

## Extracting only the measurements on the mean and standard deviation
x <- rbind(features[grep("-mean()",features[,2]),],features[grep("-std()",features[,2]),])
Data <-total_bind[,c(1,2,x[,1]+2)]

## Changing variable activity into character
Data[,2] <- labels[Data[,2],2] 

## changing variable names into more specific names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## Print head of the tidy data
head(Data)

