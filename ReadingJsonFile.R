################################################################################
## www.dataenq.com
## Reading a JSON file and preparing data for analysis
################################################################################

#Using jsonlite to read .json file
library(jsonlite)

#Using function fromJSON from jsonlite package to read the file
djson <- fromJSON("https://statbank.cso.ie/StatbankServices/StatbankServices.svc/jsonservice/responseinstance/CIS78")

#Preparing the data frame from the list of lists djson created above
#Reading individual lists and preparing columns
df <- data.frame(
        #Reading dimension Type of Cooperation Partner
        unique(rapply(djson$dataset$dimension$`Type of Cooperation Partner`$category$label, function(lst) head(lst, 1))), 
        #Reading first and every other third value from there for each observation
        V2 = djson$dataset$value[seq(1, length(djson$dataset$value), 3)],
        #Reading second and every other third value from there for each observation
        V3 = djson$dataset$value[seq(2, length(djson$dataset$value), 3)],
        #Reading third and every other third value from there for each observation
        V4 = djson$dataset$value[seq(3, length(djson$dataset$value), 3)],
        #Reading first and every other third value from there for each observation but for dimension called year
        V5 = djson$dataset$value[seq(1, length(djson$dataset$value), 3)], 
        #Reading first and every other third value from there for each observation but for dimension called Statistic
        V6 = djson$dataset$value[seq(2, length(djson$dataset$value), 3)])

#Assigning column names from vectors to match the data presented on the site given below
# https://data.gov.ie/dataset/7b6c5d4c-955c-4eeb-a9d0-e35fb58bf200/resource/5a856b72-f470-4c71-ab1f-fbb0ef3b1e22#&r=Type%20of%20Cooperation%20Partner&c=NACE%20Rev%202%20Sector
colnames(df) = c(djson$dataset$dimension$`Type of Cooperation Partner`$label, 
                 unique(rapply(djson$dataset$dimension$`NACE Rev 2 Sector`$category$label, function(lst) head(lst, 1))),
                 unique(rapply(djson$dataset$dimension$Year$category$label, function(lst) head(lst, 1))),
                 unique(rapply(djson$dataset$dimension$Statistic$category$label, function(lst) head(lst, 1))))

#Structure of the data frame
str(df)

#Printing data frame
df