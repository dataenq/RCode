##############################################################################
## www.dataenq.com
##############################################################################

# Using tidyverse
library(tidyverse)

# Read sample file into R using read.csv function
lineage.data <- read.csv("File-1.csv")

# Split the string with space as a delimiter and create two new variables into 
# the same data frame
lineage.data$test <- strsplit(lineage.data$clusters_testset, " ")
lineage.data$true <- strsplit(lineage.data$clusters_trueset, " ")

# define a function to check an element of first list into second and return 
# count of match
find.element=function(list1,list2){
        x=unlist(list1)
        y=unlist(list2)
        check <- 0
        for(i in 1:length(x)){
                if(x[i] %in% y) check <- check + 1 else 0
        }
        check
}

# use mapply to loop through and apply the function to the data frame over the 
# two lists and add result into new variable
lineage.data$new <- mapply(find.element, lineage.data$test, lineage.data$true)

# print the final data frame
lineage.data