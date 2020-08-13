###############################
##help from /u/dataenq - www.dataenq.com
###################################
library(tidyverse)

#Make new data frame manually
lineage.data <- data.frame(lineage = c("blood", "bone", "central", "skin", "soft"),
                           clusters_testset = c("0 0 6 65 73 41", "42", "90 53", "1", "65 68"),
                           clusters_trueset = c("43 35 6 65 73 41", "42", "53 7 60", "73", "60 68"))
#What the desired results should be, for each lineage :
# [a] = Number of lineage_X test that aligned to lineage_X true
# [b] = Number of lineage_X test that did NOT align to lineage_X true
# [c] = Any non-lineage_X test that did align to lineage_X true
# [d] = Any non-lineage_X test that did NOT align to lineage_X true(will be biggest number)


#Go ahead and add the correct ("COR") answers manually - used for checking against later
lineage.data$a_COR <- c( "4", "1", "1", "0", "1")
lineage.data$b_COR <- c( "2", "0", "1", "1", "1")
lineage.data$c_COR <- c( "1", "0", "0", "1", "0")
lineage.data$d_COR <- c( "5", "11", "10", "10", "10")

lineage.data$test <- strsplit(lineage.data$clusters_testset, " ")
lineage.data$true <- strsplit(lineage.data$clusters_trueset, " ")

lineage.data$temp <-
        sapply(seq_along(lineage.data$test), function(idx) unlist(lineage.data$test[-idx]))

# use mapply to loop through and apply the function to the data frame over the
# two lists and add result into new variable
lineage.data$a.result <-
        sapply(seq_along(lineage.data$true), function(idx) sum(lineage.data$true[[idx]] %in% unlist(lineage.data$test[idx])))
lineage.data$b.result <-
        sapply(seq_along(lineage.data$true), function(idx) sum(!(lineage.data$test[[idx]] %in% unlist(lineage.data$true[idx]))))
lineage.data$c.result <-
        sapply(seq_along(lineage.data$true), function(idx) sum(lineage.data$true[[idx]] %in% unlist(lineage.data$test[-idx])))
lineage.data$d.result <- 
        sapply(seq_along(lineage.data$test), function(idx) sum(!(unlist(lineage.data$temp[idx]) %in% lineage.data$true[[idx]])))

# print the final data frame
lineage.data %>% select(lineage, clusters_testset, clusters_trueset, a.result, b.result, c.result, d.result)