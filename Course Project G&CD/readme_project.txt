Data is first loaded using the read.table () function. Since "activity_label" and "features" 
contain the information in the second column, only the second column is selected.

The variable feautures contains the column names for the data contained in "X_test" and "X_train", 
therefore they are renamed according to the names contained in "features".

The grepl () function is used to create a logical vector that tells me where the mean or sd is 
calculated, to later extract it from the databases that contain the "X_test" and "X_train" data.

Once the ID variables are identified, the data is joined using the cbind function and then the 
test and train data are joined, creating the total data. the data is then reoganized so that a 
clean database can be obtained.