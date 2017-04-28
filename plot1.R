# Clear workspace
rm(list = ls())

# load packages
library(dplyr)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_ assuming the files are saved in a folder called data in the working directoryPM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# summarise data by year
dat <- group_by(NEI, year) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
png(filename = "plot1.png")
plot(dat$year, dat$Emissions, 
    type = "b", 
    ylab = "Emissions (tons)", 
    xlab= "year",
    main = "Total emissions of PM2.5 per year")
dev.off()

