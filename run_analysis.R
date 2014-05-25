setwd('~/Dropbox/Coursera - R/Getting and Cleaning Data/Course Project/UCI HAR Dataset/')

#Read test files
subjectTest = read.table("test/subject_test.txt", 
               col.names=c("subjectTest"), 
               fill=FALSE, 
               strip.white=TRUE)

xTest = read.table("test/X_test.txt", 
                         fill=FALSE, 
                         strip.white=TRUE)

yTest = read.table("test/y_test.txt", 
                   col.names=c("yTest"), 
                   fill=FALSE, 
                   strip.white=TRUE)

#Read train files
subjectTrain = read.table("train/subject_train.txt", 
                         col.names=c("subjectTrain"), 
                         fill=FALSE, 
                         strip.white=TRUE)

xTrain = read.table("train/X_train.txt", 
                   fill=FALSE, 
                   strip.white=TRUE)

yTrain = read.table("train/y_train.txt", 
                   col.names=c("yTrain"), 
                   fill=FALSE, 
                   strip.white=TRUE)

#Read feature files
features = read.table("features.txt", , 
                          fill=FALSE, 
                          strip.white=TRUE, 
                        )

#Read activity file
activityLabel = read.table("activity_labels.txt", , 
                      fill=FALSE, 
                      strip.white=TRUE)


#Create Unified dataset Train & Features
newdb<-(xTrain)
newdb2<-(xTest)
names(newdb) <- features[,2]
names(newdb2) <- features[,2]
newdb<-rbind(newdb,newdb2)
rm(newdb2)

#adding Test & Subjects
subjectData<-(subjectTrain)
names(subjectData)<-c("Subject")
names(subjectTest)<-c("Subject")
subjectData<-rbind(subjectData,subjectTest)
activityData<-(yTrain)
names(activityData)<-c("Activity")
names(yTest)<-c("Activity")
activityData<-rbind(activityData,yTest)
newdb3<-as.data.frame(matrix(nrow=10299, ncol=2))
names(newdb3)<-c("Subject", "Activity")

#Rename Activity

activityData$Act <- "Unset"
activityData$Act[activityData$Activity == 1] <- "Walking"
activityData$Act[activityData$Activity == 2] <- "Walking_Upstairs"
activityData$Act[activityData$Activity== 3] <- "Walking_Downstairs"
activityData$Act[activityData$Activity == 4] <- "Sitting"
activityData$Act[activityData$Activity == 5] <- "Standing"
activityData$Act[activityData$Activity== 6] <- "Laying"


#Merge Test & Subjects to Train & features
newdb3$Subject<-(subjectData)
newdb3$Activity<-(activityData$Act)

#Unified Dataset for the analysis
newdb<-cbind(newdb,newdb3)

#Subset Mean & SD
subsetMeans<- newdb[,grep("mean", colnames(newdb))] 
subsetStd<- newdb[,grep("std", colnames(newdb))] 
tidyD<-(subsetMeans)
tidyD<-cbind(tidyD,subsetStd)

#Add Activity & Subject data back
tidyD<-cbind(tidyD,newdb$Subject)
tidyD<-cbind(tidyD,activityData$Act)
colnames(tidyD)[81] <- "Activity"

#Summarized dataset
meltD<-melt(tidyD, id=c("Subject", "Activity"))
tidyD2<-dcast(meltD, Subject + Activity ~ variable, fun.aggregate=mean)


#Save new Dataset 
write(tidyD2, "tidyData.txt",  na="")


