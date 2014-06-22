CODEBOOK
========

A. TIDY DATA SET

1. The files "train/X_train.txt"  and "test/X_test.txt" are merged using the rbind function, into the variable xdata.
2. The files "train/y_train.txt" and   "test/y_test.txt" are merged using the rbind funtcion, into the variable ydata.
3. The files "train/subject_train.txt" and "test/subject_test.txt" are merged using the rbind function, into the variable subject
4. The file features.txt is read to get the name of the columns. A regular expression is ued to get the number of the columns that contain a mean or a standard desviation (66 columns in total)
5. The variable xdata is filtered with the columns obtained in the step 4. 
6. The names of the columns for xdata are transformed by eliminating "(" ")" and "-" from the column names
7. The file "activity_labels.txt" is read to get descriptive activity names for the activities in the data set.
8. The activity names are transformed by eliminating "_" and converting to lowercase the names.
9. The numbers of activities of variable ydata is replaced with the names from step 8.
10. The clean data set is the union of the variables subject, ydata and xdata.


B. AVERAGE VALUES DATA SET

11. For each one of the 30 subjects, for each one of the 6 activities, the following actions are performed (180 records for the new data set):
	a) The subject is placed in the column 1 of the record
	b) The activity name is placed in the column 2 of the record
	c) From the tidy data set, we get all the rows for the specified subject in the specified activity. All the numeric columns are summarized to its mean and appended to the record.




  