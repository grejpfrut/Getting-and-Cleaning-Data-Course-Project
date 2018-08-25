run_analysis.R <- 
        setwd("/Users/maria/Desktop/kurs/kurs3/UCI HAR Dataset")
##SUBJECT
subject_test <- read.table("test/subject_test.txt", sep = ",")
subject_train <- read.table("train/subject_train.txt", sep = ",")
subject <- rbind(subject_test,subject_train)
colnames(subject) <- c("subject")
## Y-test
y_test <- read.table("test/y_test.txt", sep = ",")
y_train <- read.table("train/y_train.txt", sep = ",")
y_total <- rbind(y_test, y_train)
colnames(y_total) <- c("activities")
##X 
train_Xnames <- read.table("features.txt", sep = " ")
traincharnames <- as.character(train_Xnames$V2)

library(tidyr)

test_X <- read.table("test/X_test.txt", nrows = 2947 , sep = "", na.strings=c(""," ","NA"))
train_X <- read.table("train/X_train.txt" , sep = "", na.strings=c(""," ","NA"))
X_total <- rbind(test_X, train_X)
colnames(X_total) <- traincharnames

table <- cbind(subject, y_total, X_total)

##subsetting mean and std
tableme <- grep("mean",colnames(table))
tablestd <- grep("std",colnames(table))
table <- table[ ,c(1:2,tableme,tablestd)]

##changing activity names
table$activities <- as.character(table$activities)
table$activities[table$activities == "1"] <- "WALKING"
table$activities[table$activities == "2"] <- "WALKING_UPSTAIRS"
table$activities[table$activities == "3"] <- "WALKING_DOWNSTAIRS"
table$activities[table$activities == "4"] <- "SITTING"
table$activities[table$activities == "5"] <- "STANDING"
table$activities[table$activities == "6"] <- "LAYING"

##giving descriptive variable names
names(table) <- sub("\\()","",names(table))
names(table) <- gsub("-",".",names(table))
names(table) <- sub("^t","time",names(table))
names(table) <- sub("^f","freq",names(table))

##creating new tidy data set
library(dplyr)
library(datasets)

empty_as_na <- function(x){
        if("factor" %in% class(x)) x <- as.character(x) 
        ifelse(as.character(x)!="", x, NA)
}
table <- table %>% mutate_all(funs(empty_as_na)) 

table$subject <- as.factor(table$subject)
table$activities <- as.factor(table$activities)

table <- tbl_df(table)
table <- group_by(table, subject, activities) 
final <- summarise_all(table, mean, na.rm = TRUE)
View(final)