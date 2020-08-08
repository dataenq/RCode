##############################################################################
## www.dataenq.com
##############################################################################

# Using tidyverse
library(tidyverse)
library(stringr)

# Read sample file into R using read.csv function
lineage.data <- read.csv("File-1.csv")

# Split the string with space as a delimiter and create two new variables into
# the same data frame
lineage.data$test <- strsplit(lineage.data$clusters_testset, " ")
lineage.data$true <- strsplit(lineage.data$clusters_trueset, " ")

#xx <- unique(unlist(mapply(head, lineage.data$test, length(unlist(lineage.data$test)))))
#lineage.data$all.true <- list(mapply(head, lineage.data$true, length(unlist(lineage.data$true))))

dup.elements <-
        unlist(lineage.data$test)[duplicated(unlist(lineage.data$test)) == TRUE]

all.true.elements <-
        unlist(mapply(head, lineage.data$true, length(unlist(lineage.data$true))))

# define a function to check an element of first list into second and return
# count of match
find.element = function(list1, list2, result.type) {
        vec1 = unlist(list1)
        vec2 = unlist(list2)
        check <- 0
        if (result.type == "a") {
                check <- which((vec1 %in% all.true.elements))
                length(check)
        } else if (result.type == "b") {
                check <- which(!(vec1 %in% all.true.elements))
                length(check)
        } else if (result.type == "c") {
                counter <- 1
                for (i in 1:length(vec2)) {
                        for (j in 1:length(dup.elements)) {
                                if (vec2[i] == dup.elements[j] & counter > 1)
                                        check <- check + 1
                                else
                                        0
                        }
                counter <- counter + 1
        }
        check
        } else if (result.type == "d") {
                length(vec2) - length((intersect(dup.elements,vec2)))
        }
}

# use mapply to loop through and apply the function to the data frame over the
# two lists and add result into new variable
lineage.data$a.result <-
        mapply(find.element, lineage.data$test, lineage.data$true, "a")
lineage.data$b.result <-
        mapply(find.element, lineage.data$test, lineage.data$true, "b")
lineage.data$c.result <-
        mapply(find.element, lineage.data$test, lineage.data$true, "c")
lineage.data$d.result <- 
        mapply(find.element, lineage.data$test, lineage.data$true, "d")


# print the final data frame
lineage.data %>% select(lineage, clusters_testset, clusters_trueset, a.result, b.result, c.result, d.result)