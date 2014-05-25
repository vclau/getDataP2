getDataP2
=========

Getting and Cleaning Data Proyect 2

1) Read files
First all Test & Train files are read and left into independent data frames
Another set of data frames are made for features & activity

2)Create Unified dataset Train & Features
xTrain & xTest files are rowbinded into a new data frame
Features text is then is added as column name and row binded with Train and Test files. 

3) Add Subjects & activity
Subjects and activity are added into a new data frame that is column binded to the previous one. 

4)Rename Activity
Activity numbers are then replaced by descriptions. 

5) Subset & Mean 
A new data frame with a subset of all data including a Mean or Standard deviation is created. 
We are considering mean every variable that has mean in it, such as: mean() , FreqMean, or GravityMean
A new tidy data set is created with just the mean & std columns along with activity & subject

7) Summarized Dataset
We melt the data into a new data set, by subject & activity & then cast it by variable using the function mean

The new file now provides the mean by subject & activity for each value

8)Save new Dataset 
The new tidy dataset is exported into a tab delimeted txt file

