################################################################################
## www.dataenq.com
################################################################################

## Reading both header-less file using read.csv function
file1 <- read.csv("File-1.csv", header = FALSE)
file2 <- read.csv("File-2.csv", header = FALSE)

## Check the names of the variables using names function
names(file1)
names(file2)

## Check the first few rows to confirm the variable contents

head(file1)
head(file2)

## Use merge function to join both the data frame using V1 column and set all 
## values from file1 to show (left outer join in DB terms where File1 is on left)

FinalFile <- merge(file1, file2, by.x = "V1", by.y = "V1", all.x = TRUE)

## Display results of the merged data frame

FinalFile

