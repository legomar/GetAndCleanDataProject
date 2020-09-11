
# Variable Description




## Assigned data
Data frames below contain each data described below from downloaded project dataset files.  


**features** <- features.txt  
**activities** <- activity_labels.txt  
**subject_test** <- subject_test.txt  
**x_test** <- X_test.txt  
**y_test** <- y_test.txt  
**subject_train** <- subject_train.txt  
**x_train** <- X_train.txt  
**y_train** <- y_train.txt  




## Merged data
Data frames below are created by merging each following dataset.


**X** <- x_train, x_test  
**Y** <- y_train, y_test  
**Subject** <- subject_train, subject_test  
**Data** <- Subject, Y, X  




## Extracted data
Latter **Data** is created by subsetting Data with subject, code, and mean and standard deviation for each measurement.




## Final tidy data
Last **Data** is created by subsetting and summarizing Data with the average of each variable after groupped by subject and activity.
