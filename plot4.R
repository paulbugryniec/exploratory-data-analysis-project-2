# Clear workspace
rm(list = ls())

# load packages
library(dplyr)
library(ggplot2)

# load data assuming the files are saved in a folder called data in the working directory
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# find the sources that are related to coal
sources <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE)]

# summarise data by year and and the sources that are related to coal
dat4 <- filter(NEI, SCC %in% sources) %>%
  group_by(year) %>%
  summarise(Emissions = sum(Emissions))

# produce plot
png(filename = "plot4.png")
plot(dat4$year, dat4$Emissions, 
     type = "b", 
     ylab = "Emissions (tons)", 
     xlab= "year",
     main = "Total emissions of PM2.5 per year for coal related sources")
dev.off()