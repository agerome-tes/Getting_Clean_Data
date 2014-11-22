# 1. Merges the training and the test sets to create one data set.
subject_test<-read.table("./test/subject_test.txt",header=F)
X_test<-read.table("./test/X_test.txt",header=F)
y_test<-read.table("./test/y_test.txt",header=F)

subject_train<-read.table("./train/subject_train.txt",header=F)
X_train<-read.table("./train/X_train.txt",header=F)
y_train<-read.table("./train/y_train.txt",header=F)

subject_full<-rbind(subject_test,subject_train)
X_full<-rbind(X_test,X_train)
y_full<-rbind(y_test,y_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("features.txt", header=F)
X_std_mean<-X_full[,grep("-(std|mean)\\(\\)",features[,2])]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table("activity_labels.txt", header=F)
y_mapped<-sapply(y_full,function(x){
  tolower(
    sub("_"," ",activity_labels[x,2])
  )
})
colnames(y_mapped)<-"activities"

# 4. Appropriately labels the data set with descriptive variable names
colnames(subject_full)<-"subjects"

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
colnames(X_std_mean)<-grep(
  "-(std|mean)\\(\\)",
  features[,2],
  value=T
)
merged<-cbind(subject_full,y_mapped,X_std_mean)
merged_mutate<-mutate(
  merged,
  subjects_activities=paste(
    merged$subjects,
	merged$activities,
	sep="|"
  )
)
merged_melt<-melt(
  merged_mutate,
  id="subjects_activities",
  measure.vars=colnames(merged_mutate[3:68])
)
merged_summary<-dcast(
  merged_melt,
  subjects_activities~variable,
  mean
)
merged_final<-cbind(
  colsplit(
    merged_summary$subjects_activities,
	"[|]",
	c("subjects","activities")
  ),
  merged_summary[2:67]
)
write.table(merged_final, "tidy data set with averages.txt",row.name=FALSE)