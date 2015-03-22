require(dplyr)

# Assign file locations to variables
root<-"./UCI HAR Dataset"
activities_f<-paste(root,"activity_labels.txt",sep="/")
features_f<-paste(root,"features.txt",sep="/")
x_train_f<-paste(root,"train","X_train.txt",sep="/")
x_test_f<-paste(root,"test","X_test.txt",sep="/")
y_train_f<-paste(root,"train","y_train.txt",sep="/")
y_test_f<-paste(root,"test","y_test.txt",sep="/")
subject_train_f<-paste(root,"train","subject_train.txt",sep="/")
subject_test_f<-paste(root,"test","subject_test.txt",sep="/")

#read all files to R 
activities<-read.table(activities_f,col.names=c("id","Activity"))
features<-read.table(features_f,col.names=c("id","feature"),stringsAsFactors=FALSE)
x_train<-read.table(x_train_f)
x_test<-read.table(x_test_f)
y_train<-read.table(y_train_f)
y_test<-read.table(y_test_f)
subject_train<-read.table(subject_train_f)
subject_test<-read.table(subject_test_f)

#bind columns in train & test data
training_data<-cbind(x_train,y_train,subject_train)
test_data<-cbind(x_test,y_test,subject_test)

#bind training & test data & label the data
all_data<-rbind(training_data,test_data)
col_names<-rbind(features,c(562,"id"),c(563,"subject"))
names(all_data)<-col_names[,2]

#select the mean, std, id and subject column
tidy_data<-all_data[,c(562,563,grep("mean",names(all_data)),grep("std",names(all_data)))]

#join activities info to mean_std_data and reorder columns
tidy_data<-merge(tidy_data,activities,by="id")
tidy_data<-tidy_data[,c(1,82,2,3:81)]

#rename columns more appropriately
names(tidy_data)<-gsub("^(t)","time.",names(tidy_data))
names(tidy_data)<-gsub("^(f)","freq.",names(tidy_data))
names(tidy_data)<-gsub("BodyBody","Body",names(tidy_data))
names(tidy_data)<-gsub("Body","body.",names(tidy_data))
names(tidy_data)<-gsub("Gravity","gravity.",names(tidy_data))
names(tidy_data)<-gsub("Acc","accelerometer.",names(tidy_data))
names(tidy_data)<-gsub("Gyro","gyroscope.",names(tidy_data))
names(tidy_data)<-gsub("Mag","magnitude.",names(tidy_data))
names(tidy_data)<-gsub("Jerk","jerk.",names(tidy_data))

#groupby activity and subject, take means of all feature variables

summary_bysanda<-tidy_data %>% group_by(Activity, subject) %>% summarise_each(funs(mean))

write.table(summary_bysanda, file="summarysanda.txt", row.name=FALSE )
