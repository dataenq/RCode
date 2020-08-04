################################################################################
## www.dataenq.com
## https://www.dataenq.com/2020/07/Creating-Scatterplot-in-ggplot2-in-R.html
## Creating and Decorating Scatterplot in ggplot2 in R
################################################################################

library(tidyverse)

## Reading CSV file using read.csv function
financials <- read.csv("constituents-financials_csv.csv")

## Creating a ggplot object and adding aesthetics, smooth, labels etc.
pt <- ggplot(financials, aes(x=Price, y=Dividend.Yield)) +
        geom_point(aes(col=Sector), show.legend=FALSE) +
        geom_smooth(se=FALSE) +
        labs(title="Scatterplot Example", 
             subtitle="S and P 500 companies financials. Price v/s Dividend Yield",
             caption = "Source: https://datahub.io/core/s-and-p-500-companies-financials#readme",
             x = "Price",
             y = "Dividend.Yield") +
        theme(plot.title = element_text(hjust = 0, color="blue", size=14, face="bold"),
              plot.subtitle = element_text(hjust = 0, color="black", size=12, face="italic"),
              plot.caption = element_text(hjust = 0.5, color="blue", size=10, face="plain"))

# Define device, set characteristics and plot
png("Scatterplot.png", 480, 480)

## Plot scatter plot
plot(pt)

# set the device off and back to the default screen device
dev.off()

################################################################################
## If you like it then please share and comment here:
## https://www.dataenq.com/2020/07/Creating-Scatterplot-in-ggplot2-in-R.html
################################################################################