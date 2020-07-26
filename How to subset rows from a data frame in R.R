################################################################################
## www.dataenq.com
## https://www.dataenq.com/2020/07/subset-rows-from-data-frame-in-R.html
## How to subset rows from a data frame in R
################################################################################

library(dplyr)

## Reading CSV file using read.csv function
        financials <- read.csv("constituents-financials_csv.csv")
        
## Checking structure of the newly created data frame
        str(financials)
        
## Checking first two observations
        head(financials,2)
        
## Selecting 7th row from the data frame
        financials[7,]
        
## Selecting 7th row from the data frame using dplyr package filter clause. Note
## the use of piping operation. 
        financials %>% filter(row(financials) == 7)
        
## Selecting the range of row from the data frame starting from the 2nd row
        financials[2:4,]
        
## Selecting the range of row from the data frame starting from the 2nd row
## the only difference here is the use of concatenation function.
        financials[c(2:4),]
        
## Selecting the range of row from the data frame starting from the 2nd row using
## dplyr package
        financials %>% filter(row(financials) >= 2 & row(financials) <= 4)
        
## Selecting rows based on a condition.
        financials[(financials$Symbol == "ACN" | financials$Symbol == "APTV") & 
                (financials$Sector == "Consumer Discretionary" | financials$Sector == "Industrials"),]
        
## Selecting rows based on a condition usning dplyr function.
        financials %>% filter((Symbol == "ACN" | Symbol == "APTV") & 
                (Sector == "Consumer Discretionary" | Sector == "Industrials"))

################################################################################
## If you like it then please share and comment here:
## https://www.dataenq.com/2020/07/subset-rows-from-data-frame-in-R.html
################################################################################
        